@echo off
if "%1"=="-?" goto usage
if "%1"=="/?" goto usage
if "%1"=="-h" goto usage
if "%1"=="/h" goto usage

if [%1]==[] goto nolabel

call "%~dp0\..\..\j5-framework-%1\j5\src\Scripts\helpers\j5activate.cmd"

goto :eof

:nolabel

call "%~dp0\..\..\j5-framework\j5\src\Scripts\helpers\j5activate.cmd"

goto :eof

:usage
@echo syntax j5activate [framework-src-label]