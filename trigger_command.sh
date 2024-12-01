#!/bin/sh

# Define the URL of the backend endpoint
BACKEND_URL="http://digital-backend:10000/cron/trigger-command"

# Secret token retrieved from environment variable
SECRET_TOKEN="$SECRET_TOKEN"

# Make the HTTP request to the backend
curl -X POST "$BACKEND_URL" -H "Authorization: Bearer $SECRET_TOKEN"