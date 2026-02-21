#!/usr/bin/env bash

PROXY="http://localhost:3128"

echo "== Testing proxy connectivity =="

# 1. Basic TCP check
echo -n "Checking if proxy port is open... "
if nc -z localhost 3128 2>/dev/null; then
    echo "OK"
else
    echo "FAILED"
    exit 1
fi

# 2. HTTP test
echo "Testing HTTP request through proxy..."
curl -s -o /dev/null -w "HTTP status: %{http_code}\n" \
    -x "$PROXY" http://example.com || exit 1

# 3. HTTPS test
echo "Testing HTTPS request through proxy..."
curl -s -o /dev/null -w "HTTPS status: %{http_code}\n" \
    -x "$PROXY" https://example.com || exit 1

# 4. Show last 5 squid log lines
echo
echo "Last 5 lines from squid access.log:"
podman exec squid tail -n 5 /var/log/squid/access.log 2>/dev/null || echo "No log access"

echo
echo "Proxy test completed."