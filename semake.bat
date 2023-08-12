@echo off

set lcd=%cd%
cd lua
lua ../main.lua %lcd% %1
