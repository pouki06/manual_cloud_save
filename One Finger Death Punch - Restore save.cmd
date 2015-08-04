@echo off

REM the source path of the save file (here is Google Drive which is sync between all my devices)
set source="D:\Google Drive\Perso\save_onefingerpunch\One_Finger_Death_Punch_Save.sav"

REM the destination path of the save file
set destination="%USERPROFILE%\Documents\SavedGames\One Finger Death Punch\Game_Save\Player1\One_Finger_Death_Punch_Save.sav"

REM we retrieve the dates of the files (local and drive)
dir /TW %destination%  | find "/"  > tmp.txt
call :GETDATELOCALSAVE

dir /TW %source%  | find "/"  > tmp.txt
call :GETDATECLOUDSAVE


REM if the date is older, we authorize the copy
if %datecloudsave% leq %datelocalsave% ( echo La date de la sauvegarde locale est plus recente ) else ( xcopy %source% %destination% /D /Y )

del tmp.txt

pause
goto EXIT

:GETDATELOCALSAVE
FOR /F "tokens=1-4 delims=/,: " %%i in (tmp.txt) do set /a datelocalsave=%%k%%j%%i%%l
:EXIT

:GETDATECLOUDSAVE
FOR /F "tokens=1-4 delims=/,: " %%i in (tmp.txt) do set /a datecloudsave=%%k%%j%%i%%l
:EXIT


