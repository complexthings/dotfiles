# BASH UTILITIES
# -----------------------------------

# Return Echo of Blue Text
__echo_blue() {
    ansi --blue "${1}"
    return
}

# Return Echo of Red Text
__echo_red() {
    ansi --red "${1}"
    return
}

# Returns Echo of Green Text
__echo_green() {
    ansi --green "${1}"
    return
}

# Returns Echo of Gray Text
__echo_black() {
    ansi --black "${1}"
    return
}

kill_sophos() {
    sudo rm -R /Library/Sophos\ Anti-Virus/
    sudo rm -R /Library/Application\ Support/Sophos/
    sudo rm -R /Library/Preferences/com.sophos.*
    sudo rm /Library/LaunchDaemons/com.sophos.*
    sudo rm /Library/LaunchAgents/com.sophos.*
    sudo rm -R /Library/Extensions/Sophos*
    sudo rm -R /Library/Caches/com.sophos.*
}