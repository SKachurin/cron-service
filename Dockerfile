# Use a lightweight base image
FROM alpine:latest

# Install curl and cronie
RUN apk add --no-cache curl tzdata cronie

# Set the working directory
WORKDIR /app

# Copy the crontab file and trigger script
COPY crontab /etc/crontabs/root
COPY trigger_command.sh /trigger_command.sh
RUN chmod +x /trigger_command.sh

# Create /var/log directory
RUN mkdir -p /var/log

# Set the timezone if needed
ENV TZ=UTC

# Set the environment variable for the secret token
ENV SECRET_TOKEN=default_token

# Start crond when the container starts
CMD ["crond", "-f", "-l", "8", "-L", "/var/log/cron.log"]