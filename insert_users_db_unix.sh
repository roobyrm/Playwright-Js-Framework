#!/bin/bash

# Set the PostgreSQL password
export PGPASSWORD='rppass'

# Execute the SQL script
psql -h localhost -p 5432 -U rpuser -d reportportal -a -f postgres-init/bgood.sql

# Unset the password variable for security
unset PGPASSWORD