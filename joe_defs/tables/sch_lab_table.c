/************************************************************************
 * NASA Docket No. GSC-18,719-1, and identified as “core Flight System: Bootes”
 *
 * Copyright (c) 2020 United States Government as represented by the
 * Administrator of the National Aeronautics and Space Administration.
 * All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may
 * not use this file except in compliance with the License. You may obtain
 * a copy of the License at http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 ************************************************************************/

#include "cfe_tbl_filedef.h" /* Required to obtain the CFE_TBL_FILEDEF macro definition */
#include "sch_lab_tbl.h"
#include "cfe_sb_api_typedefs.h" /* Required to use the CFE_SB_MSGID_WRAP_VALUE macro */

/* This is for the standard set of CFE core app MsgID values */
#include "cfe_msgids.h"

#ifdef HAVE_BP
#include "bp_msgids.h"
#include "bp_msg.h"
#endif

/*
** Include headers for message IDs here
*/
#ifdef HAVE_CI_LAB
#include "ci_lab_msgids.h"
#endif

#ifdef HAVE_TO_LAB
#include "to_lab_msgids.h"
#endif

#ifdef HAVE_CI
#include "ci_msgids.h"
#endif

#ifdef HAVE_TO
#include "to_msgids.h"
#endif

#ifdef HAVE_SAMPLE_APP
#include "sample_app_msgids.h"
#endif

#ifdef HAVE_HS
#include "hs_msgids.h"
#endif

#ifdef HAVE_FM
#include "fm_msgids.h"
#endif

#ifdef HAVE_SC
#include "sc_msgids.h"
#endif

#ifdef HAVE_DS
#include "ds_msgids.h"
#endif

#ifdef HAVE_LC
#include "lc_msgids.h"
#endif

#ifdef HAVE_CF
#include "cf_msgids.h"
#endif

#ifdef HAVE_CS
#include "cs_msgids.h"
#endif

#ifdef HAVE_HK
#include "hk_msgids.h"
#endif

#ifdef HAVE_MD
#include "md_msgids.h"
#endif

#ifdef HAVE_MM
#include "mm_msgids.h"
#endif

#ifdef HAVE_FCX
#include "fcx_msgids.h"
#endif

/*
** SCH Lab schedule table
** When populating this table:
**  1. The entire table is processed (SCH_LAB_MISSION_MAX_SCHEDULE_ENTRIES) but entries with a
**     packet rate of 0 are skipped
**  2. You can have commented out entries or entries with a packet rate of 0
**  3. If the table grows too big, increase SCH_LAB_MISSION_MAX_SCHEDULE_ENTRIES
*/

SCH_LAB_ScheduleTable_t Schedule = {
    .TickRate = 10,
    .Config   = {
        {CFE_SB_MSGID_WRAP_VALUE(CFE_ES_SEND_HK_MID), 40, 0},
        {CFE_SB_MSGID_WRAP_VALUE(CFE_EVS_SEND_HK_MID), 40, 0},
        {CFE_SB_MSGID_WRAP_VALUE(CFE_TIME_SEND_HK_MID), 40, 0},
        {CFE_SB_MSGID_WRAP_VALUE(CFE_SB_SEND_HK_MID), 40, 0},
        {CFE_SB_MSGID_WRAP_VALUE(CFE_TBL_SEND_HK_MID), 40, 0},
#ifdef HAVE_CI_LAB
    {CFE_SB_MSGID_WRAP_VALUE(CI_LAB_SEND_HK_MID), 40, 0}, /* TopicID=133 */
    //{CFE_SB_MSGID_WRAP_VALUE(CI_LAB_READ_UPLINK_MID), 40, 0}, /* TopicID=134 */
#endif
#ifdef HAVE_TO_LAB
    {CFE_SB_MSGID_WRAP_VALUE(TO_LAB_SEND_HK_MID), 40, 0}, /* TopicID=129 */
#endif
#ifdef HAVE_CI
        {CFE_SB_MSGID_WRAP_VALUE(CI_SEND_HK_MID), 40, 0},
#endif
#ifdef HAVE_TO
        {CFE_SB_MSGID_WRAP_VALUE(TO_SEND_HK_MID), 40, 0},
#endif
#ifdef HAVE_SAMPLE_APP
    {CFE_SB_MSGID_WRAP_VALUE(SAMPLE_APP_SEND_HK_MID), 40, 0}, /* TopicID=131 */
    //{CFE_SB_MSGID_WRAP_VALUE(SAMPLE_APP_WAKEUP_MID), 40, 0}, /* TopicID=135 */
#endif
#ifdef HAVE_CF
    {CFE_SB_MSGID_WRAP_VALUE(CF_SEND_HK_MID), 40, 0}, /* TopicID=180 */
    {CFE_SB_MSGID_WRAP_VALUE(CF_WAKE_UP_MID), 40, 0}, /* TopicID=181 */
#endif
#ifdef HAVE_FM
    {CFE_SB_MSGID_WRAP_VALUE(FM_SEND_HK_MID), 40, 0}, /* TopicID=141 */
#endif
#ifdef HAVE_DS
    {CFE_SB_MSGID_WRAP_VALUE(DS_SEND_HK_MID), 40, 0}, /* TopicID=188 */
#endif
#ifdef HAVE_BP
    {CFE_SB_MSGID_WRAP_VALUE(BP_WAKEUP_MID), 1, BP_WAKEUP_PROCESS_CC},
#endif
#ifdef HAVE_CS
    {CFE_SB_MSGID_WRAP_VALUE(CS_SEND_HK_MID), 40, 0}, /* TopicID=160 */
    {CFE_SB_MSGID_WRAP_VALUE(CS_BACKGROUND_CYCLE_MID), 1, 0}, /* TopicID=161 */
#endif
#ifdef HAVE_HK
    {CFE_SB_MSGID_WRAP_VALUE(HK_SEND_HK_MID), 40, 0}, /* TopicID=155 */
    //{CFE_SB_MSGID_WRAP_VALUE(HK_SEND_COMBINED_PKT_MID), 40, 0}, /* TopicID=156 */
#endif
#ifdef HAVE_HS
    {CFE_SB_MSGID_WRAP_VALUE(HS_SEND_HK_MID), 40, 0}, /* TopicID=175 */
    {CFE_SB_MSGID_WRAP_VALUE(HS_WAKEUP_MID), 40, 0}, /* TopicID=176 */
#endif
#ifdef HAVE_LC
    {CFE_SB_MSGID_WRAP_VALUE(LC_SEND_HK_MID), 40, 0}, /* TopicID=165 */
    //{CFE_SB_MSGID_WRAP_VALUE(LC_SAMPLE_AP_MID), 40, 0}, /* TopicID=166 (note this has a payload) */
#endif
#ifdef HAVE_MD
    {CFE_SB_MSGID_WRAP_VALUE(MD_SEND_HK_MID), 40, 0}, /* TopicID=145 */
    {CFE_SB_MSGID_WRAP_VALUE(MD_WAKEUP_MID), 5, 0}, /* TopicID=146 */
#endif
#ifdef HAVE_MM
    {CFE_SB_MSGID_WRAP_VALUE(MM_SEND_HK_MID), 40, 0}, /* TopicID=137 */
#endif
#ifdef HAVE_SC
    {CFE_SB_MSGID_WRAP_VALUE(SC_SEND_HK_MID), 40, 0}, /* TopicID=170 */
    {CFE_SB_MSGID_WRAP_VALUE(SC_WAKEUP_MID), 10, 0}, /* TopicID=171 */
#endif
#ifdef HAVE_FCX
        {CFE_SB_MSGID_WRAP_VALUE(FCX_SEND_HK_MID), 40, 0},
#endif
}};

/*
** The macro below identifies:
**    1) the data structure type to use as the table image format
**    2) the name of the table to be placed into the cFE Table File Header
**    3) a brief description of the contents of the file image
**    4) the desired name of the table image binary file that is cFE compatible
*/
CFE_TBL_FILEDEF(Schedule, SCH_LAB.Schedule, Schedule Lab MsgID Table, sch_lab_table.tbl)
