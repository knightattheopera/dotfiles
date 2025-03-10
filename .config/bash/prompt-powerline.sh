#!/usr/bin/env bash

# Inspiration: https://github.com/z4ziggy/bash-powerline-ng

# maximum number of directories displayed by the prompt
__ps1_max_length=5

function __powerline {

    function __create_prompt {

		# Colors
		local FG_BLACK="\[\e[38;5;0m\]"
		local FG_GREEN="\[\e[38;5;40m\]"
		local FG_DARKGREEN="\[\e[38;5;28m\]"
		local FG_YELLOW="\[\e[38;5;33m\]"
		local FG_RED="\[\e[38;5;31m\]"
		local FG_DARKRED="\[\e[38;5;52m\]"
		local FG_LIGHTWHITE="\[\e[38;5;250m\]"
		local FG_GREY="\[\e[38;5;240m\]"
		local FG_WHITE="\[\e[38;5;15m\]"
		local FG_BLUE="\[\e[38;5;18m\]"
		local FG_DARKGREY="\[\e[38;5;237m\]"
		local FG_LIGHTBLUE="\[\e[38;5;33m\]"
		local FG_DARKBLUE="\[\e[38;5;25m\]"
		local FG_PURPLE="\[\e[38;5;127m\]"

		local BG_RED="\[\e[48;5;41m\]"
		local BG_DARKRED="\[\e[48;5;52m\]"
		local BG_GREY="\[\e[48;5;240m\]"
		local BG_BLUE="\[\e[48;5;18m\]"
		local BG_DARKGREY="\[\e[48;5;237m\]"
		local BG_GREEN="\[\e[48;5;40m\]"
		local BG_LIGHTBLUE="\[\e[48;5;33m\]"

		local BOLD="\[\e[1m\]"

		local COLOR_RESET="\[\e[m\]"


		# The escaped brackets '\[' and '\]' make it so that
		# everything in between is ignored when computing
		# the length of the prompt, which is necessary for
		# things like the colors above.

		# Save cursor position with `tput sc`, then print a space,
		# then return to the saved position with `tput rc`,
		# and then print the unicode character.
		# This is necessary if the terminal is failing to
		# compute the correct length of the prompt (e.g.
		# the cursor doesn't move down when the line is full,
		# but it moves to the beginning of the same line
		# and starts writing over its contents).
		# For unicode characters that are 2 characters
		# wide, 2 spaces should be used instead.

		local SYMBOL_HOME_PATH='\['"`tput sc`"'\] \['"`tput rc`"'⌂\]'
		local SYMBOL_ROOT_PATH='\['"`tput sc`"'\] \['"`tput rc`"'𝄞\]'
		local SYMBOL_PART_NEXT='\['"`tput sc`"'\] \['"`tput rc`"'🭬\]'
		local SYMBOL_PATH_NEXT='\['"`tput sc`"'\] \['"`tput rc`"'⟩\]'
		# FIXME this symbol seems to cause some issues, even with the workaround
		# If necessary, prefer the laptop symbol (💻)
		local SYMBOL_COMPUTER='\['"`tput sc`"'\]  \['"`tput rc`"'🖥\]'
		local SYMBOL_FOLDER='\['"`tput sc`"'\] \['"`tput rc`"'📂\]'

		# The output of the previous command
        local RESULT=${?##0}

        local PATH_FG=${FG_BLUE}
        local PATH_BG=${BG_LIGHTBLUE}
        local USER_FG=${FG_BLUE}
        local PART_FG=${FG_LIGHTBLUE}
		local INFO_FG=${FG_BLUE}
		local INFO_BG=${BG_GREEN}
	

        # Check if PWD is writable and set color accordingly
        if [ ! -w "${PWD}" ]; then
            PATH_FG=${FG_PURPLE}
            USER_FG=${FG_PURPLE}
        fi

        # Check for root
        if [[ $EUID -eq 0 ]]; then
            USER_FG=${FG_LIGHTWITE}
            PATH_BG=${BG_RED}
            PART_FG=${FG_RED}
        fi

        # Parse path
        local WD
        if [[ "${PWD}" == ${HOME}* ]]
		then
			# Save the head of the working directory and remove it from the variable
			local WD_HEAD="${USER_FG}${SYMBOL_HOME_PATH}"	
            WD=${PWD/$HOME/}
			# Remove the first slash if present
			WD=${WD/\//}

			# Separate each directory
			local DIRS
			while IFS='/' read -ra DIRS
			do
				# offset to select only the last __ps1_max_length elements of the working directory path
				local OFFSET=$((${#DIRS[@]} - $__ps1_max_length))
				if [[ "$OFFSET" -gt "0" ]]
				then
					# there are more than 3 elements in the path
					# truncate the path and add three dots at the beginning of it
					DIRS=("..." "${DIRS[@]:$OFFSET}")
				fi
				# emit the tail of the path
				local WD_TAIL
				for d in "${DIRS[@]}"
				do
					WD_TAIL="${WD_TAIL} ${FG_DARKBLUE}${SYMBOL_PATH_NEXT}${PATH_FG} ${d}"
				done
			done <<< "$WD"
			WD="${WD_HEAD}${WD_TAIL}"
        else
            [[ "$PWD" != "/" ]] && WD=${PWD//\// ${FG_DARKBLUE}${SYMBOL_PATH_NEXT}${PATH_FG} }
            WD=${USER_FG}${SYMBOL_ROOT_PATH}${WD}
        fi

		# FIXME beware of code injection. The PS1 variable is automatically expanded, so if a directory name contains
		# shell code, it will be executed when the prompt is drawn. This is mainly an issue with prompts that display
		# git branch names, but it could be an issue here too.
		# For the issues with git branch names, see https://github.com/njhartwell/pw3nage and 
		# https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324

		# FIXME it seems that the PS1 variable shouldn't really be set during the execution of the function
		# instead, it could be better to set some other global variables that are then used by the PS1 variable

		# Add time and host name
		PS1="${BOLD}${INFO_FG}${INFO_BG} \A ${FG_DARKGREEN}${SYMBOL_PATH_NEXT}${INFO_FG} ${SYMBOL_COMPUTER}  \h "

		# Close time and host name
		PS1+="${FG_GREEN}${PATH_BG}${SYMBOL_PART_NEXT}"

        # Add working directory
        PS1+="${PATH_FG}${PATH_BG}${SYMBOL_FOLDER} ${WD} ${COLOR_RESET}${PART_FG}"

        # Expand exit code of the previous command
        PS1+="${RESULT:+${BG_DARKRED}${SYMBOL_PART_NEXT}${FG_LIGHTWHITE}${RESULT} ${COLOR_RESET}${FG_DARKRED}}"

        # Finalize PS1
        PS1+="${SYMBOL_PART_NEXT}${COLOR_RESET}"
    }

    PROMPT_COMMAND=__create_prompt
}

__powerline
unset __powerline
