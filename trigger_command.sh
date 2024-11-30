#!/bin/sh

# Define the URL of the backend endpoint
BACKEND_URL="http://digital-backend:10000/cron/trigger-command"

# If you use a secret token for security, include it here
SECRET_TOKEN="your_secret_token"

# Make the HTTP request to the backend
curl -X POST "$BACKEND_URL" -H "Authorization: Bearer $SECRET_TOKEN"
