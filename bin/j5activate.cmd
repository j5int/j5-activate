@echo off
set activate_args=
set "activate_path=%~dp0"
set src_suffix=framework
if "%1"=="-?" goto usage
if "%1"=="/?" goto usage
if "%1"=="-h" goto usage
if "%1"=="/h" goto usage
if "%1"=="--help" goto usage
rem --python3 flag is no longer used and can be removed
rem but I'm leaving it here for "backwards compatibility" with older commits
if "%1"=="--python3" (
    set activate_args=--python3
    shift
)
if "%1"=="--python2" (
    set activate_args=--python2
    shift
)
if "%1"=="--server" (
    set src_suffix=server
    shift
)
set "first_arg=%1"
if "%first_arg:~0,1%"=="-" goto usage
if "%first_arg:~0,1%"=="/" goto usage

if [%1]==[] goto nolabel

set "src_dir=%activate_path%\..\..\j5-%src_suffix%-%1"
if not exist "%src_dir%\j5\src\j5-app.yml" echo Could not find j5-%src_suffix%-%1 >&2 & goto :error
goto :activate

:nolabel

set "src_dir=%activate_path%\..\..\j5-%src_suffix%"
if exist "%src_dir%\j5\src\j5-app.yml" goto :activate

echo Could not find j5-%src_suffix%, searching for alternative locations
set "tmpfile=%tmp%\j5path_%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy unrestricted -File "%activate_path%\find_j5_src.ps1" > "%tmpfile%"
set failure=%errorlevel%
if %failure% neq 0 (
  type "%tmpfile%" >&2
  del "%tmpfile%"
  goto :error
)
set /p src_dir=<"%tmpfile%"
del "%tmpfile%"
set tmpfile=
echo Found source directory at %src_dir%

goto :activate

:activate
call "%src_dir%\j5\src\Scripts\helpers\j5activate.cmd" %* %activate_args%
if %ERRORLEVEL% GEQ 1 goto :error
set src_dir=
goto :end

:usage
@echo syntax j5activate [--python2] [--server] [framework-src-label]
goto :end

:error
set src_dir=
echo j5activate failed >&2
set activate_path=
set activate_args=
set first_arg=
exit /b 1

:end
rem clearing variables
set activate_path=
set activate_args=
set first_arg=
