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