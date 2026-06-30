STATUS=$(echo $(eww active-windows))
if [[ $STATUS == "" ]]; then
	eww open mainframe
else
	eww close mainframe
fi
