#!/bin/bash
set -e

# Check if SECRET_TOKEN is set
if [ -z "$SECRET_TOKEN" ]; then
  echo "$(date): SECRET_TOKEN is not set"
  exit 1
fi

SECRET_TOKEN="$SECRET_TOKEN"

# Define the URL of the backend endpoint
BACKEND_URL="http://digital-nginx:80/cron/five-minutes"

# Make the HTTP request to the backend
if ! curl -X POST "$BACKEND_URL" -H "Authorization: Bearer $SECRET_TOKEN"; then
  echo "$(date): Failed to POST to $BACKEND_URL"
fi
