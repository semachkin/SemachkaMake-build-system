@echo off
set p=%~dp0
%p%lua\lua %p%main.lua %cd% %1
