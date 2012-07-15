@echo off
set PATH=%PATH%;"C:\Program Files\PostgreSQL\8.4\bin"
psql -d %1 -f %2 -U fnctlint