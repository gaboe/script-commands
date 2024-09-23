#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Checkpoint VPN On
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔐

# Documentation:
# @raycast.author gabriel_ecegi
# @raycast.authorURL https://raycast.com/gabriel_ecegi

SERVICE='Endpoint_Security_VPN'

# $SERVICE is not running. Fire it up
[ -f /Library/LaunchDaemons/com.checkpoint.epc.service.plist ] && sudo launchctl load /Library/LaunchDaemons/com.checkpoint.epc.service.plist
[ -d /Library/Extensions/cpfw.kext ] && sudo kextload /Library/Extensions/cpfw.kext
[ -d '/Applications/Check Point Firewall.app' ] && open -W -n -a '/Applications/Check Point Firewall.app' --args --enable
[ -d '/Applications/Endpoint Security VPN.app' ] && open '/Applications/Endpoint Security VPN.app'