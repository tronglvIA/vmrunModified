@echo off

set vmrun="Path_to vmrun.exe"
set startvm=none
set suspendvm=none
set snapshotvm=none
set revertToSnapshotvm=none
set deleteSnapshotvm=none


goto GETOPTS

:HELP
type README.md
goto EXIT

:GETOPTS
if "%1"=="" goto MAIN
if "%1"=="/h" goto HELP
set aux=%1
if "%aux:~0,1%"=="/" (
   set nome=%aux:~1,250%
) else (
   set "%nome%=%1"
   set nome=
)
shift
goto GETOPTS

:MAIN
if /I NOT "%startvm%" == "none" goto TURNONVM
if /I NOT "%suspendvm%" == "none" goto SUSPED
if /I NOT "%snapshotvm%" == "none" goto SNAPSHOT
if /I NOT "%revertToSnapshotvm%" == "none" goto REVERTSNAPSHOT
if /I NOT "%deleteSnapshotvm%" == "none" goto DETELESNAPSHOT
goto EXIT

:TURNONVM
%vmrun% -T ws start "%startvm%" && echo [+] Opened %startvm%
goto EXIT

:SUSPED
if /I "%suspendvm%" == "all" (
	for /f "skip=1 delims=" %%i in ('%vmrun% list') DO (	
		echo [+] Suspending %%i
		%vmrun% -T ws suspend "%%i"
	)
) else (
	%vmrun% -T ws suspend "%suspendvm%"
)
goto EXIT

:SNAPSHOT
set /p "snapname=Name's the snapshots: "
echo %date% %time% > snapshotReport.txt
if /I "%snapshotvm%" == "all" (
	for /f "skip=1 delims=" %%i in ('%vmrun% list') DO (	
		echo [+] Snapshot %%i with name %snapname%
		echo [+] Snapshot %%i with name %snapname% >> snapshotReport.txt
		%vmrun% -T ws snapshot "%%i" %snapname%
	)
) else (
	%vmrun% -T ws snapshot "%snapshotvm%" %snapname%
)
goto EXIT

:REVERTSNAPSHOT
set /p "snapname=Name's the snapshots: "
if /I "%revertToSnapshotvm%" == "all" (
	for /f "skip=1 delims=" %%i in ('%vmrun% list') DO (	
		echo [+] Reverting Snapshot %snapname% for %%i
		%vmrun% -T ws revertToSnapshot "%%i" %snapname% msg.autoAnswer = TRUE
		%vmrun% start "%%i"
	)
) else (
	%vmrun% -T ws revertToSnapshot "%revertToSnapshotvm%" %snapname% msg.autoAnswer = TRUE
	%vmrun% start "%revertToSnapshotvm%"
)
goto EXIT


:DETELESNAPSHOT
set /p "snapname=Name's the snapshots: "
if /I "%deleteSnapshotvm%" == "all" (
	for /f "skip=1 delims=" %%i in ('%vmrun% list') DO (	
		echo [+] Deleting Snapshot %snapname% for %%i
		%vmrun% -T ws deleteSnapshot "%%i" %snapname% msg.autoAnswer = TRUE
		%vmrun% start "%%i"
	)
) else (
	%vmrun% -T ws deleteSnapshot "%deleteSnapshotvm%" %snapname% msg.autoAnswer = TRUE
	%vmrun% start "%deleteSnapshotvm%"
)
goto EXIT



:EXIT
echo ========================================================================================================
