# Advanced Dockerfile with proper UID/GID handling
# Demonstrates security best practices for Permission Auditor

FROM ubuntu:22.04

# Install Python and basic tools
RUN apt-get update && \
    apt-get install -y \
    python3 \
    python3-pip \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user with specific UID/GID
ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd -g ${GROUP_ID} appgroup && \
    useradd -u ${USER_ID} -g ${GROUP_ID} -m -s /bin/bash appuser

# Copy permission auditor
COPY src/auditor.py /usr/local/bin/perm-audit
RUN chmod +x /usr/local/bin/perm-audit

# Create test directory structure with various permissions
RUN mkdir -p /app && \
    mkdir -p /app/data && \
    mkdir -p /app/logs && \
    mkdir -p /app/config

# Set correct ownership
RUN chown -R appuser:appgroup /app

# Set different permissions for demonstration
RUN chmod 755 /app && \
    chmod 700 /app/data && \
    chmod 777 /app/logs && \
    chmod 644 /app/config && \
    touch /app/world_writable.txt && \
    chmod 666 /app/world_writable.txt && \
    touch /app/secure_file.txt && \
    chmod 600 /app/secure_file.txt

# Switch to non-root user
USER appuser
WORKDIR /app

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
    CMD python3 -c "import sys; sys.exit(0)"

# Default command
CMD ["perm-audit", "/app", "-r", "--fix", "--json"]
