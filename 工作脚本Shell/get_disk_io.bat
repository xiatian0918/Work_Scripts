@echo off
start  "wumin" "C:\Windows\System32\cmd.exe" 
python C:\get_disk.py
taskkill /f /im cmd.exe
exit