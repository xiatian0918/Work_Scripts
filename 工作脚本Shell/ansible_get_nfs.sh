 ansible data -m win_shell -a "net use"|egrep "^[0-9]|Unavailable"
