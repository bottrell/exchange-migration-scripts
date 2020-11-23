@ECHO off

systeminfo /s "%1" | findstr /B /C:"Domain"