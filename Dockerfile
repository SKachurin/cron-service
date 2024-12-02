# Use Ubuntu as the base image
FROM ubuntu:20.04

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cron \
    curl \
    tzdata

# Set the timezone
ENV TZ=UTC
RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Copy the crontab file and the trigger script
COPY crontab /etc/cron.d/cronjob
COPY trigger_command.sh /trigger_command.sh
RUN chmod +x /trigger_command.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cronjob

# Apply cron job
RUN crontab /etc/cron.d/cronjob

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Expose the logs to stdout
CMD cron && tail -f /var/log/cron.log
