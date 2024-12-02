# Use Ubuntu as the base image
FROM ubuntu:20.04

# Suppress interactive prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cron \
    curl \
    tzdata \
    rsyslog \
    bash

# Set the timezone
ENV TZ=UTC
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Copy the crontab file and the scripts directory
COPY crontab /etc/cron.d/cronjob
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/cronjob

# Apply cron job
RUN crontab /etc/cron.d/cronjob

# Ensure cron job is registered
RUN crontab -l

# Configure rsyslog to log cron events
RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
    && echo 'cron.* /var/log/cron.log' >> /etc/rsyslog.d/cron.conf

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Expose the logs to stdout
CMD service rsyslog start && cron && tail -f /var/log/cron.log