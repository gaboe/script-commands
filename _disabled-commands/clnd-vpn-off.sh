#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Checkpoint VPN Off
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔐

# Documentation:
# @raycast.author gabriel_ecegi
# @raycast.authorURL https://raycast.com/gabriel_ecegi

SERVICE='Endpoint_Security_VPN'

# $SERVICE is running. Shut it down
[ -f /Library/LaunchDaemons/com.checkpoint.epc.service.plist ] && sudo launchctl unload /Library/LaunchDaemons/com.checkpoint.epc.service.plist
[ -d /Library/Extensions/cpfw.kext ] && sudo kextunload /Library/Extensions/cpfw.kext
[ -d '/Applications/Check Point Firewall.app' ] && open -W -n -a '/Applications/Check Point Firewall.app' --args --disable
killall $SERVICE