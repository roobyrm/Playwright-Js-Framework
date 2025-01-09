@echo off
set PGPASSWORD=rppass
psql -h localhost -p 5432 -U rpuser -d reportportal -a -f postgres-init/bgood.sql
set PGPASSWORD=