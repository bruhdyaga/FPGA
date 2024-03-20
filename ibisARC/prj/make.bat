REM cretae hard link to drive C with Xilinx on another drive
REM mkdir c:\Xilinx
REM mklink /d c:\Xilinx f:\Xilinx
@echo off
call c:\Xilinx\Vivado\2018.1\settings64.bat
IF ERRORLEVEL 1 GOTO :vivadoWrongPath

SET projName="ibisARC"
IF NOT EXIST %projName% md %projName%
cd %projName%

vivado -source ../make.tcl

exit
:vivadoWrongPath
  rem https://stackoverflow.com/questions/2048509/how-to-echo-with-different-colors-in-the-windows-command-line
  echo [101;93m
  echo Can't find Vivado! Check Vivado default directory path in this batch file.
  echo [0m
  pause