#!/bin/bash
set -e

# This runs at container startup, so $SECRET_TOKEN is set from `docker run -e SECRET_TOKEN=...`
echo "SECRET_TOKEN=${SECRET_TOKEN}" > /env.sh
chmod +x /env.sh

# Now start cron in foreground
exec cron -f