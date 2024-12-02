# Use Ubuntu as the base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cron \
    curl \
    tzdata \
    bash

# Set the timezone
ENV TZ=UTC
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the crontab file and the scripts directory
COPY crontab /etc/cron.d/cronjob
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cronjob

# Apply cron job
RUN crontab /etc/cron.d/cronjob

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Expose the logs to stdout
CMD ["cron", "-f", "-L", "/var/log/cron.log"]
