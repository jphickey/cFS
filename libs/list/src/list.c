/**
 * \file list.c
 *
 *  Created on: Aug 25, 2014
 *      Author: jphickey
 *
 *  Copyright (c) 2004-2014, United States government as represented by the 
 *  administrator of the National Aeronautics Space Administration.  
 *  All rights reserved. This software was created at NASA Glenn
 *  Research Center pursuant to government contracts.
 *
 *  This is governed by the NASA Open Source Agreement and may be used, 
 *  distributed and modified only according to the terms of that agreement.
 */

#include <list.h>
#include <cfe_error.h>

void ListIndex_Init_Links(ListObject_t *ListObj)
{
    uint16 i;

    i = ListObj->LinkSize;
    while (i > 0)
    {
        --i;
        ListObj->Links[i].Next = i;
        ListObj->Links[i].Prev = i;

        if (i < ListObj->ValidSize && ListObj->LinkSize > ListObj->ValidSize)
        {
            ListIndex_Insert_After(ListObj, ListObj->ValidSize, i);
        }
    }
}

int32 List_LibInit(void)
{
    return CFE_SUCCESS;
}
