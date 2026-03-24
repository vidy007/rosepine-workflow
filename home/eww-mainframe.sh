STATUS=$(echo $(eww windows | grep mainframe))
if [[ $STATUS =~ "*" ]]; then
	eww close mainframe
else
	eww open mainframe
fi
