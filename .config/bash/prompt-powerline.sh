#!/usr/bin/env bash

# Inspiration: https://github.com/z4ziggy/bash-powerline-ng

# maximum number of directories displayed by the prompt
__ps1_max_length=5

function __powerline {

	function __create_prompt {

		# Colors
		local FG_VOID="\[\e[38;5;232m\]"
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

		# These are the colors of the terminal theme
		local FG_PALETTE_00="\[\e[30m\]"
		local FG_PALETTE_01="\[\e[31m\]"
		local FG_PALETTE_02="\[\e[32m\]"
		local FG_PALETTE_03="\[\e[33m\]"
		local FG_PALETTE_04="\[\e[34m\]"
		local FG_PALETTE_05="\[\e[35m\]"
		local FG_PALETTE_06="\[\e[36m\]"
		local FG_PALETTE_07="\[\e[37m\]"
		local FG_PALETTE_08="\[\e[01;30m\]"
		local FG_PALETTE_09="\[\e[01;31m\]"
		local FG_PALETTE_10="\[\e[01;32m\]"
		local FG_PALETTE_11="\[\e[01;33m\]"
		local FG_PALETTE_12="\[\e[01;34m\]"
		local FG_PALETTE_13="\[\e[01;35m\]"
		local FG_PALETTE_14="\[\e[01;36m\]"
		local FG_PALETTE_15="\[\e[01;37m\]"

		local BG_PALETTE_00="\[\e[40m\]"
		local BG_PALETTE_01="\[\e[41m\]"
		local BG_PALETTE_02="\[\e[42m\]"
		local BG_PALETTE_03="\[\e[43m\]"
		local BG_PALETTE_04="\[\e[44m\]"
		local BG_PALETTE_05="\[\e[45m\]"
		local BG_PALETTE_06="\[\e[46m\]"
		local BG_PALETTE_07="\[\e[47m\]"

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

		# Base color scheme
		local INFO_BG=${BG_PALETTE_00}
		local INFO_FG=${FG_PALETTE_12}

		local INFO_END_FG=${FG_PALETTE_08}

		local PATH_BG=${BG_PALETTE_04}
		local PATH_FG=${FG_PALETTE_08}

		local PATH_END_FG=${FG_PALETTE_12}

		# Check if PWD is writable and set color accordingly
		if [ ! -w "${PWD}" ]; then
			PATH_FG=${FG_PALETTE_09}
		fi

		# Check for root
		if [[ $EUID -eq 0 ]]; then
			PATH_BG=${BG_PALETTE_01}
			PATH_FG=${FG_PALETTE_07}
			PATH_END_FG=${FG_PALETTE_09}
		fi

		# Parse path
		local WD
		if [[ "${PWD}" == ${HOME}* ]]
		then
			# Save the head of the working directory and remove it from the variable
			local WD_HEAD="${PATH_FG}${SYMBOL_HOME_PATH}"
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
					WD_TAIL="${WD_TAIL} ${PATH_FG}${SYMBOL_PATH_NEXT}${PATH_FG} ${d}"
				done
			done <<< "$WD"
			WD="${WD_HEAD}${WD_TAIL}"
		else
			[[ "$PWD" != "/" ]] && WD=${PWD//\// ${PATH_FG}${SYMBOL_PATH_NEXT}${PATH_FG} }
			WD=${PATH_FG}${SYMBOL_ROOT_PATH}${WD}
		fi

		# FIXME beware of code injection. The PS1 variable is automatically expanded, so if a directory name contains
		# shell code, it will be executed when the prompt is drawn. This is mainly an issue with prompts that display
		# git branch names, but it could be an issue here too.
		# For the issues with git branch names, see https://github.com/njhartwell/pw3nage and 
		# https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324

		# FIXME it seems that the PS1 variable shouldn't really be set during the execution of the function
		# instead, it could be better to set some other global variables that are then used by the PS1 variable

		# Add time and host name
		PS1="${INFO_BG}${INFO_FG} \A ${INFO_FG}${SYMBOL_PATH_NEXT}${INFO_FG} \h "

		# Close time and host name
		PS1+="${PATH_BG}${INFO_END_FG}${SYMBOL_PART_NEXT}"

		# Add working directory
		PS1+="${PATH_FG}${PATH_BG} ${WD} ${COLOR_RESET}${PATH_END_FG}"

		# Expand exit code of the previous command
		PS1+="${RESULT:+${BG_DARKRED}${SYMBOL_PART_NEXT}${FG_LIGHTWHITE}${RESULT} ${COLOR_RESET}${FG_DARKRED}}"

		# Finalize PS1
		PS1+="${SYMBOL_PART_NEXT}${COLOR_RESET}"
	}

	PROMPT_COMMAND="__create_prompt${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline
