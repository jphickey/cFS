/**
 * \file list.h
 *
 *  Created on: Aug 22, 2014
 *      Author: jphickey
 *
 *  Copyright (c) 2004-2014, United States government as represented by the 
 *  administrator of the National Aeronautics Space Administration.  
 *  All rights reserved. This software was created at NASA Glenn
 *  Research Center pursuant to government contracts.
 *
 *  This is governed by the NASA Open Source Agreement and may be used, 
 *  distributed and modified only according to the terms of that agreement.
 *
 *
 *
 * This is an implementation of a generic doubly linked list.  In order to be
 * fully type agnostic, the list implementation is separated from the object
 * instantiation.  Therefore the list implementation here has no idea what
 * type of objects it is dealing with, it only deals with indices.
 *
 * There are some constraints to these lists:
 *   - All lists are always circular (the "end" of a list means returning to the start)
 *   - There is no such thing as an empty list.
 *
 * With a conventional linked list, most of the insert/delete logic consists of
 * conditionals to handle empty lists and/or first/last node special cases.  These
 * two constraints remove all that and the resulting insert/delete functions become
 * extremely simple and very reliable, hence why they can be done as macros.  The
 * simplicity and lack of conditionals also makes operations very efficient / low cost
 * for a real-time application.
 *
 * If the concept of an "empty" list is truly necessary, there are a few options:
 *   - Declare extra node(s) as "head" nodes.  The head node can then be skipped during
 *     traversal of the list. Of course this has a memory penalty equal to the link size,
 *     but this is pretty small, and you would need a head node reference somewhere anyway.
 *   - The application can keep track of it externally.  This is the conventional approach
 *     where a head index is kept and set to an "invalid" value when the list is empty.  The
 *     application must do the work of checking for and handling this condition.
 *
 * This header file contains an implementation as (mostly) inline functions for efficiency.
 * The insert/remove fundamental operations are relatively few instructions so it is suggested
 * to inline these functions however that choice is ultimately up to the compiler/optimizer.
 *
 */



#ifndef LIST_H_
#define LIST_H_

#include <common_types.h>

typedef uint16 ListIndex_t;

#define LISTINDEX_INVALID       ((uint16)(-1))

typedef struct
{
    ListIndex_t Prev;
    ListIndex_t Next;
} ListLink_t;

typedef struct
{
    ListIndex_t Start;
    ListIndex_t Current;
} ListIterator_t;

typedef const struct
{
    ListIndex_t ValidSize;
    ListIndex_t LinkSize;
    ListLink_t *Links;
} ListObject_t;

/**
 * A macro to simplify the creation of lightweight list objects
 * The linked list is type independent; it uses a backing storage object (an array) that must be declared externally.
 * The link structure effectively allows you to skip around to indices within an array object.  Also note that
 * this allows more than one list object to reference the same backing store i.e. to index the same array in multiple
 * ways.
 */
#define LISTOBJECT_CREATE_LINKS(BackingObj,ObjId,NumHeads)      \
    static ListLink_t BackingObj##ObjId##_Links[NumHeads + (sizeof(BackingObj) / sizeof(BackingObj[0]))];

#define LISTOBJECT_STATIC_INIT(BackingObj,ObjId)                    \
    {                                                               \
        .ValidSize = (sizeof(BackingObj) / sizeof(BackingObj[0])),  \
        .LinkSize = (sizeof(BackingObj##ObjId##_Links) / sizeof(BackingObj##ObjId##_Links[0])), \
        .Links = BackingObj##ObjId##_Links                          \
    }

/**
 * A macro to get the actual object (type-specific) from an iterator
 * This is implemented as a macro because we do not know what type the BackingObj is.
 */
#define LISTOBJECT_GET(BackingObj,Iter)     (&(BackingObj)[(Iter).Current])

/**
 * Splits the List so that the node at "Pos" becomes a list of one.
 * If the node at Pos was part of a larger list then it is removed.
 */
static inline void ListIndex_Remove(ListObject_t *ListObj, ListIndex_t Pos)
{
    ListLink_t *RemNode = &ListObj->Links[Pos];

    ListObj->Links[RemNode->Prev].Next = RemNode->Next;
    ListObj->Links[RemNode->Next].Prev = RemNode->Prev;
    RemNode->Next = Pos;
    RemNode->Prev = Pos;
}

/**
 * Inserts the whole contents of ListSrc just before the node pointed to by ListTgt
 */
static inline void ListIndex_Insert_Before(ListObject_t *ListObj, ListIndex_t ListTgt, ListIndex_t ListSrc)
{
    ListLink_t *NodeTgt = &ListObj->Links[ListTgt];
    ListLink_t *NodeSrc = &ListObj->Links[ListSrc];

    ListObj->Links[NodeSrc->Next].Prev = NodeTgt->Prev;
    ListObj->Links[NodeTgt->Prev].Next = NodeSrc->Next;
    NodeTgt->Prev = ListSrc;
    NodeSrc->Next = ListTgt;
}

/**
 * Inserts the whole contents of ListSrc just after the node pointed to by ListTgt
 */
static inline void ListIndex_Insert_After(ListObject_t *ListObj, ListIndex_t ListTgt, ListIndex_t ListSrc)
{
    ListLink_t *NodeTgt = &ListObj->Links[ListTgt];
    ListLink_t *NodeSrc = &ListObj->Links[ListSrc];

    ListObj->Links[NodeSrc->Prev].Next = NodeTgt->Next;
    ListObj->Links[NodeTgt->Next].Prev = NodeSrc->Prev;
    NodeTgt->Next = ListSrc;
    NodeSrc->Prev = ListTgt;
}

static inline void ListIndex_Iterator_Init(ListIterator_t *Iter, ListIndex_t Pos)
{
    Iter->Start = Pos;
    Iter->Current = Pos;
}

static inline void ListIndex_Iterator_Reset(ListIterator_t *Iter)
{
    Iter->Current = Iter->Start;
}

static inline void ListIndex_Iterator_ResetStart(ListIterator_t *Iter)
{
    Iter->Start = Iter->Current;
}


static inline ListIndex_t ListIndex_Head_Position(ListObject_t *ListObj, ListIndex_t HeadId)
{
    return (ListObj->ValidSize + HeadId);
}

static inline uint8 ListIndex_Is_Valid(ListObject_t *ListObj, ListIndex_t Pos)
{
    return (Pos < ListObj->ValidSize);
}

static inline uint8 ListIndex_GetNext(ListObject_t *ListObj, ListIndex_t Pos)
{
    return ListObj->Links[Pos].Next;
}

static inline uint8 ListIndex_GetPrev(ListObject_t *ListObj, ListIndex_t Pos)
{
    return ListObj->Links[Pos].Prev;
}

static inline uint8 ListIndex_Move_Next(ListObject_t *ListObj, ListIterator_t *Iter)
{
    Iter->Current = ListIndex_GetNext(ListObj, Iter->Current);
    return (Iter->Start != Iter->Current);
}

static inline uint8 ListIndex_Move_Prev(ListObject_t *ListObj, ListIterator_t *Iter)
{
    Iter->Current = ListIndex_GetPrev(ListObj, Iter->Current);
    return (Iter->Start != Iter->Current);
}

/**
 * Shortcut function that initializes an iterator to the head node of a list
 */
static inline void ListIndex_Iterator_Head(ListObject_t *ListObj, ListIterator_t *Iter, ListIndex_t HeadId)
{
    ListIndex_Iterator_Init(Iter, ListIndex_Head_Position(ListObj, HeadId));
}

/**
 * Shortcut function that pushes onto the head of the list
 * With the corresponding pop/shift operation this can emulate a typical LIFO stack or FIFO queue
 */
static inline void ListIndex_Push(ListObject_t *ListObj, ListIndex_t HeadId, ListIndex_t NodeIdx)
{
    ListIndex_Insert_After(ListObj, ListIndex_Head_Position(ListObj, HeadId), NodeIdx);
}

/**
 * Shortcut function that pops from the head of the list
 * With the corresponding push operation this can emulate a typical LIFO stack
 * In the case of an empty list this will return the head node index which can be checked for
 * using the ListIndex_Is_Valid
 */
static inline ListIndex_t ListIndex_Pop(ListObject_t *ListObj, ListIndex_t HeadId)
{
    ListIndex_t NodeIdx = ListIndex_GetNext(ListObj, ListIndex_Head_Position(ListObj, HeadId));
    ListIndex_Remove(ListObj, NodeIdx);
    return NodeIdx;
}

/**
 * Shortcut function that shifts from the tail of the list
 * With the corresponding push operation this can emulate a typical FIFO queue
 * In the case of an empty list this will return the head node index which can be checked for
 * using the ListIndex_Is_Valid
 */
static inline ListIndex_t ListIndex_Shift(ListObject_t *ListObj, ListIndex_t HeadId)
{
    ListIndex_t NodeIdx = ListIndex_GetPrev(ListObj, ListIndex_Head_Position(ListObj, HeadId));
    ListIndex_Remove(ListObj, NodeIdx);
    return NodeIdx;
}

static inline void ListIndex_Merge(ListObject_t *ListObj, ListIndex_t SrcHeadId, ListIndex_t TgtHeadId)
{
    ListIndex_t SrcNode = ListIndex_Head_Position(ListObj, SrcHeadId);
    ListIndex_Insert_After(ListObj, ListIndex_Head_Position(ListObj, TgtHeadId), SrcNode);
    ListIndex_Remove(ListObj, SrcNode);
}

extern void ListIndex_Init_Links(ListObject_t *ListObj);



#endif /* LIST_H_ */
