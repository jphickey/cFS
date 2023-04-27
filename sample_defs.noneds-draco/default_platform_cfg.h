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

/**
 * @file
 *
 * Purpose:
 *   This header file contains the platform configuration parameters.
 *
 * Notes:
 *   The impact of changing these configurations from their default value is
 *   not yet documented.  Changing these values may impact the performance
 *   and functionality of the system.
 *
 * Author:   R.McGraw/SSI
 *
 */

#ifndef DEFAULT_PLATFORM_CFG_H
#define DEFAULT_PLATFORM_CFG_H

#include "cfe_es_platform_cfg.h"

/**
**  \cfesbcfg Maximum Number of Unique Message IDs SB Routing Table can hold
**
**  \par Description:
**       Dictates the maximum number of unique MsgIds the SB routing table will hold.
**       This constant has a direct effect on the size of SB's tables and arrays.
**       Keeping this count as low as possible will save memory.
**       To see the run-time, high-water mark and the current utilization figures
**       regarding this parameter, send an SB command to 'Send Statistics Pkt'.
**
**  \par Limits
**       This must be a power of two if software bus message routing hash implementation
**       is being used.  Lower than 64 will cause unit test failures, and
**       telemetry reporting is impacted below 32.  There is no hard
**       upper limit, but impacts memory footprint.  For software bus message routing
**       search implementation the number of msg ids subscribed to impacts performance.
**
*/
#define CFE_PLATFORM_SB_MAX_MSG_IDS 256

/**
**  \cfesbcfg Maximum Number of Unique Pipes SB Routing Table can hold
**
**  \par Description:
**       Dictates the maximum number of unique Pipes the SB routing table will hold.
**       This constant has a direct effect on the size of SB's tables and arrays.
**       Keeping this count as low as possible will save memory.
**       To see the run-time, high-water mark and the current utilization figures
**       regarding this parameter, send an SB command to 'Send Statistics Pkt'.
**
**  \par Limits
**       This parameter has a lower limit of 1.  This parameter must also be less than
**       or equal to OS_MAX_QUEUES.
**
*/
#define CFE_PLATFORM_SB_MAX_PIPES 64

/**
**  \cfesbcfg Maximum Number of unique local destinations a single MsgId can have
**
**  \par Description:
**       Dictates the maximum number of unique local destinations a single MsgId can
**       have.
**
**  \par Limits
**       This parameter has a lower limit of 1.  There are no restrictions on the upper
**       limit however, the maximum number of destinations per packet is system dependent
**       and should be verified.  Destination number values that are checked against this
**       configuration are defined by a 16 bit data word.
**
*/
#define CFE_PLATFORM_SB_MAX_DEST_PER_PKT 16

/**
**  \cfesbcfg Default Subscription Message Limit
**
**  \par Description:
**       Dictates the default Message Limit when using the #CFE_SB_Subscribe API. This will
**       limit the number of messages with a specific message ID that can be received through
**       a subscription. This only changes the default; other message limits can be set on a per
**       subscription basis using #CFE_SB_SubscribeEx .
**
**  \par Limits
**       This parameter has a lower limit of 4 and an upper limit of 65535.
**
*/
#define CFE_PLATFORM_SB_DEFAULT_MSG_LIMIT 4

/**
**  \cfesbcfg Size of the SB buffer memory pool
**
**  \par Description:
**       Dictates the size of the SB memory pool. For each message the SB
**       sends, the SB dynamically allocates from this memory pool, the memory needed
**       to process the message. The memory needed to process each message is msg
**       size + msg descriptor(CFE_SB_BufferD_t). This memory pool is also used
**       to allocate destination descriptors (CFE_SB_DestinationD_t) during the
**       subscription process.
**       To see the run-time, high-water mark and the current utilization figures
**       regarding this parameter, send an SB command to 'Send Statistics Pkt'.
**       Some memory statistics have been added to the SB housekeeping packet.
**       NOTE: It is important to monitor these statistics to ensure the desired
**       memory margin is met.
**
**  \par Limits
**       This parameter has a lower limit of 512 and an upper limit of UINT_MAX (4 Gigabytes).
**
*/
#define CFE_PLATFORM_SB_BUF_MEMORY_BYTES 524288

/**
**  \cfesbcfg Highest Valid Message Id
**
**  \par Description:
**       The value of this constant dictates the range of valid message ID's, from 0
**       to CFE_PLATFORM_SB_HIGHEST_VALID_MSGID (inclusive).
**
**       Although this can be defined differently across platforms, each platform can
**       only publish/subscribe to message ids within their allowable range. Typically
**       this value is set the same across all mission platforms to avoid this complexity.
**
**  \par Limits
**       CFE_SB_INVALID_MSG is set to the maximum representable number of type CFE_SB_MsgId_t.
**       CFE_PLATFORM_SB_HIGHEST_VALID_MSGID lower limit is 1, up to CFE_SB_INVALID_MSG_ID - 1.
**
**       When using the direct message map implementation for software bus routing, this
**       value is used to size the map where a value of 0x1FFF results in a 16 KBytes map
**       and 0xFFFF is 128 KBytes.
**
**       When using the hash implementation for software bus routing, a multiple of the
**       CFE_PLATFORM_SB_MAX_MSG_IDS is used to size the message map.  In that case
**       the range selected here does not impact message map memory use, so it's
**       reasonable to use up to the full range supported by the message ID implementation.
*/
#define CFE_PLATFORM_SB_HIGHEST_VALID_MSGID 0x1FFF

/**
**  \cfesbcfg Platform Endian Indicator
**
**  \par Description:
**       The value of this constant indicates the endianess of the target system
**
**  \par Limits
**       This parameter has a lower limit of 0 and an upper limit of 1.
*/
#define CFE_PLATFORM_ENDIAN CCSDS_LITTLE_ENDIAN

/**
**  \cfesbcfg Default Routing Information Filename
**
**  \par Description:
**       The value of this constant defines the filename used to store the software
**       bus routing information.  This filename is used only when no filename is
**       specified in the command.
**
**  \par Limits
**       The length of each string, including the NULL terminator cannot exceed the
**       #OS_MAX_PATH_LEN value.
*/
#define CFE_PLATFORM_SB_DEFAULT_ROUTING_FILENAME "/ram/cfe_sb_route.dat"

/**
**  \cfesbcfg Default Pipe Information Filename
**
**  \par Description:
**       The value of this constant defines the filename used to store the software
**       bus pipe information. This filename is used only when no filename is
**       specified in the command.
**
**  \par Limits
**       The length of each string, including the NULL terminator cannot exceed the
**       #OS_MAX_PATH_LEN value.
*/
#define CFE_PLATFORM_SB_DEFAULT_PIPE_FILENAME "/ram/cfe_sb_pipe.dat"

/**
**  \cfesbcfg Default Message Map Filename
**
**  \par Description:
**       The value of this constant defines the filename used to store the software
**       bus message map information. This filename is used only when no filename is
**       specified in the command. The message map is a lookup table (array of 16bit
**       words) that has an element for each possible MsgId value and holds the
**       routing table index for that MsgId. The Msg Map provides fast access to the
**       destinations of a message.
**
**  \par Limits
**       The length of each string, including the NULL terminator cannot exceed the
**       #OS_MAX_PATH_LEN value.
*/
#define CFE_PLATFORM_SB_DEFAULT_MAP_FILENAME "/ram/cfe_sb_msgmap.dat"

/**
**  \cfesbcfg SB Event Filtering
**
**  \par Description:
**       This group of configuration parameters dictates what SB events will be
**       filtered through EVS. The filtering will begin after the SB task initializes
**       and stay in effect until a cmd to EVS changes it.
**       This allows the operator to set limits on the number of event messages that
**       are sent during system initialization.
**       NOTE: Set all unused event values and mask values to zero
**
**  \par Limits
**       This filtering applies only to SB events.
**       These parameters have a lower limit of 0 and an upper limit of 65535.
*/
#define CFE_PLATFORM_SB_FILTERED_EVENT1 CFE_SB_SEND_NO_SUBS_EID
#define CFE_PLATFORM_SB_FILTER_MASK1    CFE_EVS_FIRST_4_STOP

#define CFE_PLATFORM_SB_FILTERED_EVENT2 CFE_SB_DUP_SUBSCRIP_EID
#define CFE_PLATFORM_SB_FILTER_MASK2    CFE_EVS_FIRST_4_STOP

#define CFE_PLATFORM_SB_FILTERED_EVENT3 CFE_SB_MSGID_LIM_ERR_EID
#define CFE_PLATFORM_SB_FILTER_MASK3    CFE_EVS_FIRST_16_STOP

#define CFE_PLATFORM_SB_FILTERED_EVENT4 CFE_SB_Q_FULL_ERR_EID
#define CFE_PLATFORM_SB_FILTER_MASK4    CFE_EVS_FIRST_16_STOP

#define CFE_PLATFORM_SB_FILTERED_EVENT5 0
#define CFE_PLATFORM_SB_FILTER_MASK5    CFE_EVS_NO_FILTER

#define CFE_PLATFORM_SB_FILTERED_EVENT6 0
#define CFE_PLATFORM_SB_FILTER_MASK6    CFE_EVS_NO_FILTER

#define CFE_PLATFORM_SB_FILTERED_EVENT7 0
#define CFE_PLATFORM_SB_FILTER_MASK7    CFE_EVS_NO_FILTER

#define CFE_PLATFORM_SB_FILTERED_EVENT8 0
#define CFE_PLATFORM_SB_FILTER_MASK8    CFE_EVS_NO_FILTER

/**
**  \cfeescfg Define SB Memory Pool Block Sizes
**
**  \par Description:
**       Software Bus Memory Pool Block Sizes
**
**  \par Limits
**       These sizes MUST be increasing and MUST be an integral multiple of 4.
**       The number of block sizes defined cannot exceed
**       #CFE_PLATFORM_ES_POOL_MAX_BUCKETS
*/
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_01 8
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_02 16
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_03 20
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_04 36
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_05 64
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_06 96
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_07 128
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_08 160
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_09 256
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_10 512
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_11 1024
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_12 2048
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_13 4096
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_14 8192
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_15 16384
#define CFE_PLATFORM_SB_MEM_BLOCK_SIZE_16 32768
#define CFE_PLATFORM_SB_MAX_BLOCK_SIZE    (CFE_MISSION_SB_MAX_SB_MSG_SIZE + 128)

/**
**  \cfetimecfg Time Server or Time Client Selection
**
**  \par Description:
**       This configuration parameter selects whether the Time task functions as a
**       time "server" or "client".  A time server generates the "time at the tone"
**       packet which is received by time clients.
**
**  \par Limits
**       Enable one, and only one by defining either CFE_PLATFORM_TIME_CFG_SERVER or
**       CFE_PLATFORM_TIME_CFG_CLIENT AS true.  The other must be defined as false.
*/
#define CFE_PLATFORM_TIME_CFG_SERVER true
#define CFE_PLATFORM_TIME_CFG_CLIENT false

/**
** \cfetimecfg Time Tone In Big-Endian Order
**
** \par Description:
**      If this configuration parameter is defined, the CFE time server will
**      publish time tones with payloads in big-endian order, and time clients
**      will expect the tones to be in big-endian order. This is useful for
**      mixed-endian environments. This will become obsolete once EDS is
**      available and the CFE time tone message is defined.
*/
#undef CFE_PLATFORM_TIME_CFG_BIGENDIAN

/**
**  \cfetimecfg Local MET or Virtual MET Selection for Time Servers
**
**  \par Description:
**       Depending on the specific hardware system configuration, it may be possible
**       for Time Servers to read the "local" MET from a h/w register rather than
**       having to track the MET as the count of tone signal interrupts (virtual MET)
**
**       Time Clients must be defined as using a virtual MET.  Also, a Time Server
**       cannot be defined as having both a h/w MET and an external time source (they
**       both cannot synchronize to the same tone).
**
**       Note: "disable" this define (set to false) only for Time Servers with local hardware
**       that supports a h/w MET that is synchronized to the tone signal !!!
**
**  \par Limits
**       Only applies if #CFE_PLATFORM_TIME_CFG_SERVER is set to true.
*/
#define CFE_PLATFORM_TIME_CFG_VIRTUAL true

/**
**  \cfetimecfg Include or Exclude the Primary/Redundant Tone Selection Cmd
**
**  \par Description:
**       Depending on the specific hardware system configuration, it may be possible
**       to switch between a primary and redundant tone signal.  If supported by
**       hardware, this definition will enable command interfaces to select the
**       active tone signal. Both Time Clients and Time Servers support this feature.
**       Note: Set the CFE_PLATFORM_TIME_CFG_SIGNAL define to true to enable tone signal commands.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_TIME_CFG_SIGNAL false

/**
**  \cfetimecfg Include or Exclude the Internal/External Time Source Selection Cmd
**
**  \par Description:
**       By default, Time Servers maintain time using an internal MET which may be a
**       h/w register or software counter, depending on available hardware. The
**       following definition enables command interfaces to switch between an
**       internal MET, or external time data received from one of several supported
**       external time sources. Only a Time Server may be configured to use external
**       time data.
**       Note: Set the CFE_PLATFORM_TIME_CFG_SOURCE define to true to include the Time Source
**             Selection Command (command allows selection between the internal
**             or external time source). Then choose the external source with the
**             CFE_TIME_CFG_SRC_??? define.
**
**  \par Limits
**       Only applies if #CFE_PLATFORM_TIME_CFG_SERVER is set to true.
*/
#define CFE_PLATFORM_TIME_CFG_SOURCE false

/**
**  \cfetimecfg Choose the External Time Source for Server only
**
**  \par Description:
**       If #CFE_PLATFORM_TIME_CFG_SOURCE is set to true, then one of the following external time
**       source types must also be set to true.  Do not set any of the external time
**       source types to true unless #CFE_PLATFORM_TIME_CFG_SOURCE is set to true.
**
**  \par Limits
**       -# If #CFE_PLATFORM_TIME_CFG_SOURCE is set to true then one and only one of the following
**       three external time sources can and must be set true:
**       #CFE_PLATFORM_TIME_CFG_SRC_MET, #CFE_PLATFORM_TIME_CFG_SRC_GPS, #CFE_PLATFORM_TIME_CFG_SRC_TIME
**       -# Only applies if #CFE_PLATFORM_TIME_CFG_SERVER is set to true.
*/
#define CFE_PLATFORM_TIME_CFG_SRC_MET  false
#define CFE_PLATFORM_TIME_CFG_SRC_GPS  false
#define CFE_PLATFORM_TIME_CFG_SRC_TIME false

/**
**  \cfetimecfg Define the Max Delta Limits for Time Servers using an Ext Time Source
**
**  \par Description:
**       If #CFE_PLATFORM_TIME_CFG_SOURCE is set to true and one of the external time sources is
**       also set to true, then the delta time limits for range checking is used.
**
**       When a new time value is received from an external source, the value is
**       compared against the "expected" time value. If the delta exceeds the
**       following defined amount, then the new time data will be ignored. This range
**       checking is only performed after the clock state has been commanded to
**       "valid". Until then, external time data is accepted unconditionally.
**
**  \par Limits
**       Applies only if both #CFE_PLATFORM_TIME_CFG_SERVER and #CFE_PLATFORM_TIME_CFG_SOURCE are set
**       to true.
*/
#define CFE_PLATFORM_TIME_MAX_DELTA_SECS 0
#define CFE_PLATFORM_TIME_MAX_DELTA_SUBS 500000

/**
**  \cfetimecfg Define the Local Clock Rollover Value in seconds and subseconds
**
**  \par Description:
**       Specifies the capability of the local clock.  Indicates the time at which
**       the local clock rolls over.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_TIME_MAX_LOCAL_SECS 27
#define CFE_PLATFORM_TIME_MAX_LOCAL_SUBS 0

/**
**  \cfetimecfg Define Timing Limits From One Tone To The Next
**
**  \par Description:
**       Defines limits to the timing of the 1Hz tone signal. A tone signal is valid
**       only if it arrives within one second (plus or minus the tone limit) from
**       the previous tone signal.Units are microseconds as measured with the local
**       clock.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_TIME_CFG_TONE_LIMIT 20000

/**
**  \cfetimecfg Define Time to Start Flywheel Since Last Tone
**
**  \par Description:
**       Define time to enter flywheel mode (in seconds since last tone data update)
**       Units are microseconds as measured with the local clock.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_TIME_CFG_START_FLY 2

/**
**  \cfetimecfg Define Periodic Time to Update Local Clock Tone Latch
**
**  \par Description:
**       Define Periodic Time to Update Local Clock Tone Latch. Applies only when
**       in flywheel mode. This define dictates the period at which the simulated
**       'last tone' time is updated. Units are seconds.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_TIME_CFG_LATCH_FLY 8

/**
**  \cfeescfg Define EVS Task Priority
**
**  \par Description:
**       Defines the cFE_EVS Task priority.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_EVS_START_TASK_PRIORITY 61

/**
**  \cfeescfg Define EVS Task Stack Size
**
**  \par Description:
**       Defines the cFE_EVS Task Stack Size
**
**  \par Limits
**       There is a lower limit of 2048 on this configuration parameter.  There
**       are no restrictions on the upper limit however, the maximum stack size
**       is system dependent and should be verified.  Most operating systems provide
**       tools for measuring the amount of stack used by a task during operation. It
**       is always a good idea to verify that no more than 1/2 of the stack is used.
*/
#define CFE_PLATFORM_EVS_START_TASK_STACK_SIZE CFE_PLATFORM_ES_DEFAULT_STACK_SIZE

/**
**  \cfeescfg Define SB Task Priority
**
**  \par Description:
**       Defines the cFE_SB Task priority.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_SB_START_TASK_PRIORITY 64

/**
**  \cfeescfg Define SB Task Stack Size
**
**  \par Description:
**       Defines the cFE_SB Task Stack Size
**
**  \par Limits
**       There is a lower limit of 2048 on this configuration parameter.  There
**       are no restrictions on the upper limit however, the maximum stack size
**       is system dependent and should be verified.  Most operating systems provide
**       tools for measuring the amount of stack used by a task during operation. It
**       is always a good idea to verify that no more than 1/2 of the stack is used.
*/
#define CFE_PLATFORM_SB_START_TASK_STACK_SIZE CFE_PLATFORM_ES_DEFAULT_STACK_SIZE

/**
**  \cfeescfg Define ES Task Priority
**
**  \par Description:
**       Defines the cFE_ES Task priority.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_ES_START_TASK_PRIORITY 68

/**
**  \cfeescfg Define ES Task Stack Size
**
**  \par Description:
**       Defines the cFE_ES Task Stack Size
**
**  \par Limits
**       There is a lower limit of 2048 on this configuration parameter.  There
**       are no restrictions on the upper limit however, the maximum stack size
**       is system dependent and should be verified.  Most operating systems provide
**       tools for measuring the amount of stack used by a task during operation. It
**       is always a good idea to verify that no more than 1/2 of the stack is used.
*/
#define CFE_PLATFORM_ES_START_TASK_STACK_SIZE CFE_PLATFORM_ES_DEFAULT_STACK_SIZE

/**
**  \cfetimecfg Define TIME Task Priorities
**
**  \par Description:
**       Defines the cFE_TIME Task priority.
**       Defines the cFE_TIME Tone Task priority.
**       Defines the cFE_TIME 1HZ Task priority.
**
**  \par Limits
**       There is a lower limit of zero and an upper limit of 255 on these
**       configuration parameters.  Remember that the meaning of each task
**       priority is inverted -- a "lower" number has a "higher" priority.
*/
#define CFE_PLATFORM_TIME_START_TASK_PRIORITY 60
#define CFE_PLATFORM_TIME_TONE_TASK_PRIORITY  25
#define CFE_PLATFORM_TIME_1HZ_TASK_PRIORITY   25

/**
**  \cfetimecfg Define TIME Task Stack Sizes
**
**  \par Description:
**       Defines the cFE_TIME Main Task Stack Size
**       Defines the cFE_TIME Tone Task Stack Size
**       Defines the cFE_TIME 1HZ Task Stack Size
**
**  \par Limits
**       There is a lower limit of 2048 on these configuration parameters.  There
**       are no restrictions on the upper limit however, the maximum stack size
**       is system dependent and should be verified.  Most operating systems provide
**       tools for measuring the amount of stack used by a task during operation. It
**       is always a good idea to verify that no more than 1/2 of the stack is used.
*/
#define CFE_PLATFORM_TIME_START_TASK_STACK_SIZE CFE_PLATFORM_ES_DEFAULT_STACK_SIZE
#define CFE_PLATFORM_TIME_TONE_TASK_STACK_SIZE  4096
#define CFE_PLATFORM_TIME_1HZ_TASK_STACK_SIZE   8192

/**
**  \cfeescfg Define TBL Task Priority
**
**  \par Description:
**       Defines the cFE_TBL Task priority.
**
**  \par Limits
**       Not Applicable
*/
#define CFE_PLATFORM_TBL_START_TASK_PRIORITY 70

/**
**  \cfeescfg Define TBL Task Stack Size
**
**  \par Description:
**       Defines the cFE_TBL Task Stack Size
**
**  \par Limits
**       There is a lower limit of 2048 on this configuration parameter.  There
**       are no restrictions on the upper limit however, the maximum stack size
**       is system dependent and should be verified.  Most operating systems provide
**       tools for measuring the amount of stack used by a task during operation. It
**       is always a good idea to verify that no more than 1/2 of the stack is used.
*/
#define CFE_PLATFORM_TBL_START_TASK_STACK_SIZE CFE_PLATFORM_ES_DEFAULT_STACK_SIZE

/**
**  \cfeevscfg Define Maximum Number of Event Filters per Application
**
**  \par Description:
**       Maximum number of events that may be filtered per application.
**
**  \par Limits
**       There are no restrictions on the lower and upper limits however,
**       the maximum number of event filters is system dependent and should be
**       verified.
*/
#define CFE_PLATFORM_EVS_MAX_EVENT_FILTERS 8

/**
**  \cfeevscfg Maximum number of event before squelching
**
**  \par Description:
**       Maximum number of events that may be emitted per app per second.
**       Setting this to 0 will cause events to be unrestricted.
**
**  \par Limits
**       This number must be less than or equal to INT_MAX/1000
*/
#define CFE_PLATFORM_EVS_MAX_APP_EVENT_BURST 32

/**
**  \cfeevscfg Sustained number of event messages per second per app before squelching
**
**  \par Description:
**       Sustained number of events that may be emitted per app per second.
**
**  \par Limits
**       This number must be less than or equal to #CFE_PLATFORM_EVS_MAX_APP_EVENT_BURST.
**       Values lower than 8 may cause functional and unit test failures.
*/
#define CFE_PLATFORM_EVS_APP_EVENTS_PER_SEC 8

/**
**  \cfeevscfg Default Event Log Filename
**
**  \par Description:
**       The value of this constant defines the filename used to store the Event
**       Services local event log. This filename is used only when no filename is
**       specified in the command to dump the event log.
**
**  \par Limits
**       The length of each string, including the NULL terminator cannot exceed the
**       #OS_MAX_PATH_LEN value.
*/
#define CFE_PLATFORM_EVS_DEFAULT_LOG_FILE "/ram/cfe_evs.log"

/**
**  \cfeevscfg Maximum Number of Events in EVS Local Event Log
**
**  \par Description:
**       Dictates the EVS local event log capacity. Units are the number of events.
**
**  \par Limits
**       There are no restrictions on the lower and upper limits however,
**       the maximum log size is system dependent and should be verified.
*/
#define CFE_PLATFORM_EVS_LOG_MAX 20

/**
**  \cfeevscfg Default EVS Application Data Filename
**
**  \par Description:
**       The value of this constant defines the filename used to store the EVS
**       Application Data(event counts/filtering information). This filename is
**       used only when no filename is specified in the command to dump the event
**       log.
**
**  \par Limits
**       The length of each string, including the NULL terminator cannot exceed the
**       #OS_MAX_PATH_LEN value.
*/
#define CFE_PLATFORM_EVS_DEFAULT_APP_DATA_FILE "/ram/cfe_evs_app.dat"

/**
**  \cfeevscfg Default EVS Output Port State
**
**  \par Description:
**       Defines the default port state (enabled or disabled) for the four output
**       ports defined within the Event Service. Port 1 is usually the uart output
**       terminal. To enable a port, set the proper bit to a 1. Bit 0 is port 1,
**       bit 1 is port2 etc.
**
**  \par Limits
**       The valid settings are 0x0 to 0xF.
*/
#define CFE_PLATFORM_EVS_PORT_DEFAULT 0x0001

/**
**  \cfeevscfg Default EVS Event Type Filter Mask
**
**  \par Description:
**       Defines a state of on or off for all four event types. The term event
**       'type' refers to the criticality level and may be Debug, Informational,
**       Error or Critical. Each event type has a bit position. (bit 0 = Debug,
**       bit 1 = Info, bit 2 = Error, bit 3 = Critical). This is a global setting,
**       meaning it applies to all applications. To filter an event type, set its
**       bit to zero. For example,
**       0xE means Debug = OFF, Info = ON, Error = ON, Critical = ON
**
**  \par Limits
**       The valid settings are 0x0 to 0xF.
*/
#define CFE_PLATFORM_EVS_DEFAULT_TYPE_FLAG 0xE

/**
**  \cfeevscfg Default EVS Local Event Log Mode
**
**  \par Description:
**       Defines a state of overwrite(0) or discard(1) for the operation of the
**       EVS local event log. The log may operate in either Overwrite mode = 0,
**       where once the log becomes full the oldest event in the log will be
**       overwritten, or Discard mode = 1, where once the log becomes full the
**       contents of the log are preserved and the new event is discarded.
**       Overwrite Mode = 0, Discard Mode = 1.
**
**  \par Limits
**       The valid settings are 0 or 1
*/
#define CFE_PLATFORM_EVS_DEFAULT_LOG_MODE 1

/**
**  \cfeevscfg Default EVS Message Format Mode
**
**  \par Description:
**       Defines the default message format (long or short) for event messages being
**       sent to the ground. Choose between #CFE_EVS_MsgFormat_LONG or
**       #CFE_EVS_MsgFormat_SHORT.
**
**  \par Limits
**       The valid settings are #CFE_EVS_MsgFormat_LONG or #CFE_EVS_MsgFormat_SHORT
*/
#define CFE_PLATFORM_EVS_DEFAULT_MSG_FORMAT_MODE CFE_EVS_MsgFormat_LONG

/* Platform Configuration Parameters for Table Service (TBL) */

/**
**  \cfetblcfg Size of Table Services Table Memory Pool
**
**  \par Description:
**       Defines the TOTAL size of the memory pool that cFE Table Services allocates
**       from the system.  The size must be large enough to provide memory for each
**       registered table, the inactive buffers for double buffered tables and for
**       the shared inactive buffers for single buffered tables.
**
**  \par Limits
**       The cFE does not place a limit on the size of this parameter.
*/
#define CFE_PLATFORM_TBL_BUF_MEMORY_BYTES 524288

/**
**  \cfetblcfg Maximum Size Allowed for a Double Buffered Table
**
**  \par Description:
**       Defines the maximum allowed size (in bytes) of a double buffered table.
**
**  \par Limits
**       The cFE does not place a limit on the size of this parameter but it must be
**       less than half of #CFE_PLATFORM_TBL_BUF_MEMORY_BYTES.
*/
#define CFE_PLATFORM_TBL_MAX_DBL_TABLE_SIZE 16384

/**
**  \cfetblcfg Maximum Size Allowed for a Single Buffered Table
**
**  \par Description:
**       Defines the maximum allowed size (in bytes) of a single buffered table.
**       \b NOTE: This size determines the size of all shared table buffers.
**       Therefore, this size will be multiplied by #CFE_PLATFORM_TBL_MAX_SIMULTANEOUS_LOADS
**       below when allocating memory for shared tables.
**
**  \par Limits
**       The cFE does not place a limit on the size of this parameter but it must be
**       small enough to allow for #CFE_PLATFORM_TBL_MAX_SIMULTANEOUS_LOADS number of tables
**       to fit into #CFE_PLATFORM_TBL_BUF_MEMORY_BYTES.
*/
#define CFE_PLATFORM_TBL_MAX_SNGL_TABLE_SIZE 16384

/**
**  \cfetblcfg Maximum Number of Tables Allowed to be Registered
**
**  \par Description:
**       Defines the maximum number of tables supported by this processor's Table Services.
**
**  \par Limits
**       This number must be less than 32767.  It should be recognized that this parameter
**       determines the size of the Table Registry.  An excessively high number will waste
**       memory.
*/
#define CFE_PLATFORM_TBL_MAX_NUM_TABLES 128

/**
**  \cfetblcfg Maximum Number of Critical Tables that can be Registered
**
**  \par Description:
**       Defines the maximum number of critical tables supported by this processor's Table Services.
**
**  \par Limits
**       This number must be less than 32767.  It should be recognized that this parameter
**       determines the size of the Critical Table Registry which is maintained in the Critical
**       Data Store.  An excessively high number will waste Critical Data Store memory.  Therefore,
**       this number must not exceed the value defined in CFE_ES_CDS_MAX_CRITICAL_TABLES.
*/
#define CFE_PLATFORM_TBL_MAX_CRITICAL_TABLES 32

/**
**  \cfetblcfg Maximum Number of Table Handles
**
**  \par Description:
**       Defines the maximum number of Table Handles.
**
**  \par Limits
**       This number must be less than 32767.  This number must be at least as big as
**       the number of tables (#CFE_PLATFORM_TBL_MAX_NUM_TABLES) and should be set higher if tables
**       are shared between applications.
*/
#define CFE_PLATFORM_TBL_MAX_NUM_HANDLES 256

/**
**  \cfetblcfg Maximum Number of Simultaneous Loads to Support
**
**  \par Description:
**       Defines the maximum number of single buffered tables that can be
**       loaded simultaneously.  This number is used to determine the number
**       of shared buffers to allocate.
**
**  \par Limits
**       This number must be less than 32767.  An excessively high number will
**       degrade system performance and waste memory.  A number less than 5 is
**       suggested but not required.
*/
#define CFE_PLATFORM_TBL_MAX_SIMULTANEOUS_LOADS 4

/**
**  \cfetblcfg Maximum Number of Simultaneous Table Validations
**
**  \par Description:
**       Defines the maximum number of pending validations that
**       the Table Services can handle at any one time.  When a
**       table has a validation function, a validation request is
**       made of the application to perform that validation.  This
**       number determines how many of those requests can be
**       outstanding at any one time.
**
**  \par Limits
**       This number must be less than 32767.  An excessively high number will
**       degrade system performance and waste memory.  A number less than 20 is
**       suggested but not required.
*/
#define CFE_PLATFORM_TBL_MAX_NUM_VALIDATIONS 10

/**
**  \cfetblcfg Default Filename for a Table Registry Dump
**
**  \par Description:
**       Defines the file name used to store the table registry when
**       no filename is specified in the dump registry command.
**
**  \par Limits
**       The length of each string, including the NULL terminator cannot exceed the
**       #OS_MAX_PATH_LEN value.
*/
#define CFE_PLATFORM_TBL_DEFAULT_REG_DUMP_FILE "/ram/cfe_tbl_reg.log"

/**
**  \cfetblcfg Number of Spacecraft ID's specified for validation
**
**  \par Description:
**       Defines the number of specified spacecraft ID values that
**       are verified during table loads.  If the number is zero
**       then no validation of the spacecraft ID field in the table
**       file header is performed when tables are loaded.  Non-zero
**       values indicate how many values from the list of spacecraft
**       ID's defined below are compared to the spacecraft ID field
**       in the table file header.  The ELF2CFETBL tool may be used
**       to create table files with specified spacecraft ID values.
**
**  \par Limits
**       This number must be greater than or equal to zero and
**       less than or equal to 2.
*/
#define CFE_PLATFORM_TBL_VALID_SCID_COUNT 0

/* macro to construct 32 bit value from 4 chars */
#define CFE_PLATFORM_TBL_U32FROM4CHARS(_C1, _C2, _C3, _C4) \
    ((uint32)(_C1) << 24 | (uint32)(_C2) << 16 | (uint32)(_C3) << 8 | (uint32)(_C4))

/**
**  \cfetblcfg Spacecraft ID values used for table load validation
**
**  \par Description:
**       Defines the spacecraft ID values used for validating the
**       spacecraft ID field in the table file header.  To be valid,
**       the spacecraft ID specified in the table file header must
**       match one of the values defined here.
**
**  \par Limits
**       This value can be any 32 bit unsigned integer.
*/
#define CFE_PLATFORM_TBL_VALID_SCID_1 (0x42)
#define CFE_PLATFORM_TBL_VALID_SCID_2 (CFE_PLATFORM_TBL_U32FROM4CHARS('a', 'b', 'c', 'd'))

/**
**  \cfetblcfg Number of Processor ID's specified for validation
**
**  \par Description:
**       Defines the number of specified processor ID values that
**       are verified during table loads.  If the number is zero
**       then no validation of the processor ID field in the table
**       file header is performed when tables are loaded.  Non-zero
**       values indicate how many values from the list of processor
**       ID's defined below are compared to the processor ID field
**       in the table file header.  The ELF2CFETBL tool may be used
**       to create table files with specified processor ID values.
**
**  \par Limits
**       This number must be greater than or equal to zero and
**       less than or equal to 4.
*/
#define CFE_PLATFORM_TBL_VALID_PRID_COUNT 0

/**
**  \cfetblcfg Processor ID values used for table load validation
**
**  \par Description:
**       Defines the processor ID values used for validating the
**       processor ID field in the table file header.  To be valid,
**       the spacecraft ID specified in the table file header must
**       match one of the values defined here.
**
**  \par Limits
**       This value can be any 32 bit unsigned integer.
*/
#define CFE_PLATFORM_TBL_VALID_PRID_1 (1)
#define CFE_PLATFORM_TBL_VALID_PRID_2 (CFE_PLATFORM_TBL_U32FROM4CHARS('a', 'b', 'c', 'd'))
#define CFE_PLATFORM_TBL_VALID_PRID_3 0
#define CFE_PLATFORM_TBL_VALID_PRID_4 0

/** \cfeescfg CFE core application startup timeout
**
**  \par Description:
**      The upper limit for the amount of time that the cFE core applications
**      (ES, SB, EVS, TIME, TBL) are each allotted to reach their respective
**      "ready" states.
**
**      The CFE "main" thread starts individual tasks for each of the core applications
**      (except FS).  Each of these must perform some initialization work before the
**      next core application can be started, so the main thread waits to ensure that the
**      application has reached the "ready" state before starting the next application.
**
**      If any core application fails to start, then it indicates a major problem with
**      the system and startup is aborted.
**
**      Units are in milliseconds
**
**  \par Limits:
**       Must be defined as an integer value that is greater than
**       or equal to zero.
**
*/
#define CFE_PLATFORM_CORE_MAX_STARTUP_MSEC 30000

#endif /* CPU1_PLATFORM_CFG_H */
