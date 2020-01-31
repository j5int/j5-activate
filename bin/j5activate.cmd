@echo off
set activate_args=
set "activate_path=%~dp0"
if "%1"=="-?" goto usage
if "%1"=="/?" goto usage
if "%1"=="-h" goto usage
if "%1"=="/h" goto usage
if "%1"=="--help" goto usage
if "%1"=="--python3" (
    set activate_args=--python3
    shift
)

if [%1]==[] goto nolabel

set "src_dir=%activate_path%\..\..\j5-framework-%1"
if not exist "%src_dir%" echo Could not find j5-framework-%1 >&2 & goto :error
goto :activate

:nolabel

set "src_dir=%activate_path%\..\..\j5-framework"
if exist "%src_dir%" goto :activate

echo Could not find j5-framework, searching for alternative locations
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
@echo syntax j5activate [--python3] [framework-src-label]
goto :end

:error
set src_dir=
echo j5activate failed >&2
set activate_path=
set activate_args=
exit /b 1

:end
rem clearing variables
set activate_path=
set activate_args=
