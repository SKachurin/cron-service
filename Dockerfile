# Use Ubuntu as the base image
FROM ubuntu:20.04

# Prevent prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

# Install necessary packages
RUN apt-get update && apt-get install -y \
    cron \
    curl \
    tzdata \
    bash

# Set the timezone
RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure --frontend noninteractive tzdata

# Copy the crontab file and the scripts directory
COPY crontab /etc/cron.d/cronjob
COPY scripts/ /scripts/
RUN chmod +x /scripts/*.sh

# Set permissions for cron job
RUN chmod 0644 /etc/cron.d/cronjob
RUN chown root:root /etc/cron.d/cronjob

# Remove rsyslog installation and configuration
# (Simplify by not using rsyslog to avoid permission issues)
# RUN apt-get install -y rsyslog
# RUN sed -i '/imklog/s/^/#/' /etc/rsyslog.conf \
#     && echo 'cron.* /var/log/cron.log' >> /etc/rsyslog.d/cron.conf

# Create the log file and set permissions
RUN touch /var/log/cron.log
RUN chmod 0666 /var/log/cron.log


# Start cron in the foreground
CMD ["cron", "-f"]
