@echo off
echo Clean the project and all project files? Close this window or press anykey to clean project files.
pause

rem   ## clean Vivado project files ##
rd .\.Xil               /s /q
rd .\cometicus          /s /q
del vivado*.*           /s /q /f
