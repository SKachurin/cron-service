#!/bin/bash

# Define the URL of the backend endpoint
BACKEND_URL="http://digital-backend/cron/trigger-command"

# Secret token retrieved from environment variable
SECRET_TOKEN="$SECRET_TOKEN"

# Log the time and action
echo "$(date): Attempting to POST to $BACKEND_URL"

# Make the HTTP request to the backend
curl -X POST "$BACKEND_URL" -H "Authorization: Bearer $SECRET_TOKEN"