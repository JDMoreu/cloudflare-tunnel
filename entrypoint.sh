#!/bin/bash

set -e

# Wait for tunnel login to complete
echo "Please go to the following link and authenticate your tunnel:"
cloudflared tunnel login
echo "Tunnel authentication complete."

# Create tunnel and route
cloudflared tunnel create $NAME
cloudflared tunnel route dns $NAME $hostname

# Configure tunnel credentials
mkdir -p /root/.cloudflared/
echo "tunnel: $(cloudflared tunnel info $NAME | grep -oP 'Your tunnel \K\S+' | awk '{print $1}')" >> /root/.cloudflared/config.yaml && echo "credentials-file: /root/.cloudflared/$(cloudflared tunnel info $NAME | grep -oP 'Your tunnel \K\S+' | awk '{print $1}').json" >> /root/.cloudflared/config.yaml && cat <<EOT >> /root/.cloudflared/config.yaml
ingress:
  - hostname:
    service: $protocol://localhost:$port
    originRequest:
      noTLSVerify: true
EOT

# Start the tunnel
cloudflared tunnel run $NAME
