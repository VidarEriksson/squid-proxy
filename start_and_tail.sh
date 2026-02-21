#!/usr/bin/env bash
set -euo pipefail

SERVICE="squid"

echo "Starting Squid..."
podman compose up -d --remove-orphans

echo
echo "Following container logs (Ctrl+C to stop; container keeps running):"
echo

podman logs -f "$SERVICE"