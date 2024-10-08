#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Checkpoint VPN Toggle
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔐

# Documentation:
# @raycast.author gabriel_ecegi
# @raycast.authorURL https://raycast.com/gabriel_ecegi

#
# The reason of creating this script is that Endpoint Security VPN installs it's own application firewall kext cpfw.kext
# which prevents for example PPTP connections from this computer, which is not appropriate if you need subj connection just
# from time to time
#
# Usage: ./checkpoint.sh
#
# The script checks if Enpoint Security VPN is running. If it is, then it shuts it down, if it is not, it fires it up.
# Or, make an Automator action and paste the script.
# You will need sudo power, of course
#
# To prevent Endpoint Security VPN from starting automatically whenever you restart your Mac, edit this file:
# `/Library/LaunchAgents/com.checkpoint.eps.gui.plist`
# And change the values of `RunAtLoad` and `KeepAlive` to `false`
# [Source](https://superuser.com/questions/885273)

SERVICE='Endpoint_Security_VPN'

if pgrep $SERVICE > /dev/null
then
    # $SERVICE is running. Shut it down
    [ -f /Library/LaunchDaemons/com.checkpoint.epc.service.plist ] && sudo launchctl unload /Library/LaunchDaemons/com.checkpoint.epc.service.plist
    [ -d /Library/Extensions/cpfw.kext ] && sudo kextunload /Library/Extensions/cpfw.kext
    [ -d '/Applications/Check Point Firewall.app' ] && open -W -n -a '/Applications/Check Point Firewall.app' --args --disable
    killall $SERVICE
else
    # $SERVICE is not running. Fire it up
    [ -f /Library/LaunchDaemons/com.checkpoint.epc.service.plist ] && sudo launchctl load /Library/LaunchDaemons/com.checkpoint.epc.service.plist
    [ -d /Library/Extensions/cpfw.kext ] && sudo kextload /Library/Extensions/cpfw.kext
    [ -d '/Applications/Check Point Firewall.app' ] && open -W -n -a '/Applications/Check Point Firewall.app' --args --enable
    [ -d '/Applications/Endpoint Security VPN.app' ] && open '/Applications/Endpoint Security VPN.app'
fi
