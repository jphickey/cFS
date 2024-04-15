/************************************************************************
 * File: bp_flowtable.c
 *
 * Purpose:
 *  Source for the flow table
 *
 *************************************************************************/


/************************************************************************
** Includes
*************************************************************************/

#include <common_types.h>

#include "bplib.h"
#include "bp_tbl.h"
#include "bp_platform_cfg.h"

#include "cfe.h"
#include "cfe_tbl_filedef.h"
#include "cfe_msgids.h"

#include "cf_msgids.h"

/************************************************************************
** Data
*************************************************************************/

/*
** Table file header
*/
CFE_TBL_FileDef_t CFE_TBL_FileDef =
{
    "BP_FlowTable",
    "BP_APP.FlowTable",
    "Configuration of bundle flows",
    "bp_flowtable.tbl",
    sizeof(BP_FlowTable_t)
};

/*
** Table contents
*/
BP_FlowTable_t BP_FlowTable =
{
    .LocalNodeIpn = 12,
    .Flows =
    {
        {   /* Flow 0 */
            .Name = "CFDP",
            .Enabled = true,
            .PipeDepth = BP_APP_READ_LIMIT,
            .SrcServ = 1,
            .DstNode = 13,
            .DstServ = 1,
            .Timeout = 0,
            .Lifetime = 86400,
            .Priority = BP_COS_NORMAL,
            .MaxActive = 0,
            .PktTbl = {{ CFE_SB_MSGID_WRAP_VALUE(0x081a), 1, 1, BP_APP_READ_LIMIT }},
            .RecvStreamId = CFE_SB_MSGID_WRAP_VALUE(0x181a)
        },
        #ifdef jphfix
        {   /* Flow 1 */
            .Name = "EVT",
            .Enabled = false,
            .PipeDepth = BP_APP_READ_LIMIT,
            .SrcServ = 2,
            .DstNode = 23,
            .DstServ = 2,
            .Timeout = 0,
            .Lifetime = 86400,
            .Priority = BP_COS_BULK,
            .MaxActive = 0,
            .PktTbl = {{ CFE_EVS_EVENT_MSG_MID, 1, 1, BP_APP_READ_LIMIT }},
            .IOParm = "OutMID=0x08BD&InMID=0x18C1&InDepth=32"
        }
        #endif
    }
};

/************************/
/*  End of File Comment */
/************************/
