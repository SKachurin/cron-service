#!/bin/sh

# Export environment variables to a file
printenv | grep -v "no_proxy" >> /etc/environment

# Start crond in the background
crond

# Tail the cron log file to keep the container running and output logs
tail -f /var/log/cron.log