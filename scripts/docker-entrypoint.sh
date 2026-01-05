#!/bin/bash
# docker-entrypoint.sh - Handle UID/GID mapping between host and container
# REQUIREMENT: "Handles Docker/container UID mapping"

set -e

# Если переданы переменные для маппинга UID/GID
if [ -n "$HOST_UID" ] && [ -n "$HOST_GID" ]; then
    echo "Mapping container user to host UID/GID: $HOST_UID:$HOST_GID"
    
    # Изменяем UID/GID пользователя в контейнере
    sudo usermod -u $HOST_UID appuser 2>/dev/null || echo "Warning: Cannot change UID"
    sudo groupmod -g $HOST_GID appgroup 2>/dev/null || echo "Warning: Cannot change GID"
    
    # Исправляем владение файлами
    sudo chown -R $HOST_UID:$HOST_GID /app 2>/dev/null || true
fi

# Передаём управление основному скрипту
exec "$@"
