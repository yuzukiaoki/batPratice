
@echo OFF
echo bang
echo hehe
SET A = %1%
SET B = %2%

IF "%2%"=="" (
    GOTO :SECOND
) ELSE (
    GOTO :FIRST
)


:FIRST
ECHO FIRST

:SECOND
ECHO SECOND