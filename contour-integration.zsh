# vim:et:ts=4:sw=4
#
#/**
# * This file is part of the "contour" project
# *   Copyright (c) 2019-2020 Christian Parpart <christian@parpart.family>
# *
# * Licensed under the Apache License, Version 2.0 (the "License");
# * you may not use this file except in compliance with the License.
# *
# * Unless required by applicable law or agreed to in writing, software
# * distributed under the License is distributed on an "AS IS" BASIS,
# * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# * See the License for the specific language governing permissions and
# * limitations under the License.
# */

# Changes to a new profile.
vt_set_profile()
{
    local name="${1}"
    echo -ne "\eP\$p${name}\e\\"
}

# Example hook to change profile based on directory.
# update_profile()
# {
#     case "$PWD" in
#         "$HOME"/work*) vt_set_profile work ;;
#         "$HOME"/projects*) vt_set_profile main ;;
#         *) vt_set_profile mobile ;;
#     esac
# }

autoload -Uz add-zsh-hook

precmd_hook_contour()
{
    # Disable text reflow for the command prompt (and below).
    print -n '\e[?2027l' >$TTY

    # Marks the current line (command prompt) so that you can jump to it via key bindings.
    echo -n '\e[>M' >$TTY

    # Informs contour terminal about the current working directory, so that e.g. OpenFileManager works.
    echo -ne '\e]7;'$(pwd)'\e\\' >$TTY

    # Example hook to update configuration profile based on base directory.
    # update_profile >$TTY
}

preexec_hook_contour()
{
    # Enables text reflow for the main page area again, so that a window resize will reflow again.
    print "\e[?2027h" >$TTY
}

add-zsh-hook precmd precmd_hook_contour
add-zsh-hook preexec preexec_hook_contour
