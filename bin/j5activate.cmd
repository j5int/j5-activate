@echo off
if "%1"=="-?" goto usage
if "%1"=="/?" goto usage
if "%1"=="-h" goto usage
if "%1"=="/h" goto usage

if [%1]==[] goto nolabel

set "src_dir=%~dp0\..\..\j5-framework-%1"
goto :activate

:nolabel

set "src_dir=%~dp0\..\..\j5-framework"
if exist "%src_dir%" goto :activate

set "tmpfile=%tmp%\j5path_%RANDOM%.txt"
powershell -NoProfile -ExecutionPolicy unrestricted -File "%~dp0\find_j5_src.ps1" > "%tmpfile%"
set failure=%errorlevel%
if %failure% neq 0 (
  type "%tmpfile%" >&2
  del "%tmpfile%"
  goto :error
)
set /p src_dir=<"%tmpfile%"
del "%tmpfile%"
echo Found source directory at %src_dir%

goto :activate

:activate
call "%src_dir%\j5\src\Scripts\helpers\j5activate.cmd"
goto :eof

:usage
@echo syntax j5activate [framework-src-label]
goto :eof

:error
exit 1
