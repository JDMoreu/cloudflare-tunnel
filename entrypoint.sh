#!/bin/bash

set -e

if [ ! -f /root/.cloudflared/config.yaml ]; then
    # Authenticate tunnel
    cloudflared tunnel login && echo "Tunnel authentication complete."

    # Create tunnel and route
    cloudflared tunnel create $NAME
    cloudflared tunnel route dns $NAME $hostname

    # Configure tunnel credentials
    info=$(cloudflared tunnel info $NAME | grep -oP 'Your tunnel \K\S+' | awk '{print $1}')
    mkdir -p /root/.cloudflared/
    echo -e "tunnel: $info\ncredentials-file: /root/.cloudflared/$info.json\ningress:\n  - hostname:\n    service: $protocol://localhost:$port\n    originRequest:\n      noTLSVerify: true" | sed 's/^/  /' > /root/.cloudflared/config.yaml
fi

# Start the tunnel
cloudflared tunnel run $NAME
