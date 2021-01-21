#!/bin/bash
# shellcheck disable=SC1090,SC2034
#===============================================================================
#
#          FILE: bin/send_message.sh
# 
USAGE='send_message.sh [-h|--help] "CHAT[ID]" "message" "text|url" ...'
# 
#   DESCRIPTION: send a send buttons in a row to the given user/group
# 
#       OPTIONS: CHAT[ID] - ID number of CHAT or BOTADMIN to send to yourself
#                message - message to send
#                text|url - buttons to send,  each button as "text|url" pair or
#                        "url" only to show url as text also, "" starts new row
#
#                -h - display short help
#                --help -  this help
#
#       EXAMPLE: 2 buttons on 2 rows, first shows Amazon, second the url as text
#                send_buttons.sh "Amazon|https://www.amazon.com" "" "https://mydealz.de" ...
#
#                Set BASHBOT_HOME to your installation directory
#
#	LICENSE: WTFPLv2 http://www.wtfpl.net/txt/copying/
#        AUTHOR: KayM (gnadelwartz), kay@rrr.de
#       CREATED: 18.01.2021 11:34
#
#### $$VERSION$$ v1.31-dev-14-g749eee7
#===============================================================================

####
# parse args
SEND="send_inline_keyboard"

# set bashbot environment
source "${0%/*}/bashbot_env.inc.sh" "debug"
print_help

####
# ready, do stuff here -----
if [ "$1" == "BOTADMIN" ]; then
	CHAT="${BOT_ADMIN}"
else
	CHAT="$1"
fi
TEXT="$2"
shift 2

# send message in selected format
"${SEND}" "${CHAT}" "${TEXT}" "$(_button_row "$@")"

# output send message result
print_result
