@echo off
REM https://stackoverflow.com/questions/30629694/make-a-random-string-in-batch

ECHO random [output length (int)] [output mode ("x16", "x10", "abc", "default")]

IF bebra%1==bebra (
	SET "result_len=4"
	ECHO no output length param. default is %result_len%.
) ELSE (
	SET "result_len=%1"
	ECHO random string length will be %result_len%.
)

2>NUL CALL :case_%2
IF ERRORLEVEL 1 CALL :case_default
EXIT /B

:case_default
	ECHO no output mode param/default.
	ECHO mode: default. [A-Z_0-9]
	SET "char_set=abcdefghijklmnopqrstuvwxyz0123456789"
	SET "%char_set_len=36"
	GOTO end_case
:case_x16
	ECHO mode x16. [A-E_0-9]
	SET "char_set=abcde0123456789"
	SET "%char_set_len=16"
	GOTO end_case
:case_x10
	ECHO mode x10. [0-9]
	SET "char_set=0123456789"
	SET "%char_set_len=10"
	GOTO end_case
:case_abc
	ECHO mode abc. [A-Z]
	SET "char_set=abcdefghijklmnopqrstuvwxyz"
	SET "%char_set_len=26"
	GOTO end_case
:end_case
	VER > NUL
	
SETLOCAL ENABLEDELAYEDEXPANSION

SET "result="
FOR /L %%i IN (1,1,%result_len%) DO CALL :add
ECHO %result%
PAUSE
GOTO :eof

:add
SET /a x=%random% %% %char_set_len% 
SET result=%result%!char_set:~%x%,1!
GOTO :eof
