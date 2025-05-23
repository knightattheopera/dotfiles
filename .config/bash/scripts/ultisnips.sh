#!/usr/bin/env bash
# change current course latex notes directory
function switch-course-snippets {
	if [ "$#" -eq 2 ]
	then
		local latex_notes_path=$HOME/latex-notes/$1/$2
		if [ -d $latex_notes_path ]
		then
			ln -sfn $latex_notes_path/ultisnips/$2.snippets ~/.vim/ultisnips-snippets/tex/current
			cd $latex_notes_path
		else
			echo "course or semester not found"
			echo "Usage: switch-notes <semester-code> <course-code>"
		fi
	else
		echo "Usage: switch-notes <semester-code> <course-code>"
	fi
}
