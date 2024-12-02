# Use a lightweight base image
FROM alpine:latest

# Install curl and dcron
RUN apk add --no-cache curl tzdata dcron

# Set the working directory
WORKDIR /app

# Copy the crontab file and trigger script
COPY crontab /etc/crontabs/root
COPY trigger_command.sh /trigger_command.sh
RUN chmod +x /trigger_command.sh

# Set the timezone if needed
ENV TZ=UTC

# Set the environment variable for the secret token
# This will be overridden by the environment variable from the environment
ENV SECRET_TOKEN=default_token

# Start dcron when the container starts
#CMD ["crond", "-f"]

# Start dcron with debug logging
CMD ["crond", "-f", "-l", "8"]