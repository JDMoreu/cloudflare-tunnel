# Contenedor Docker para Cloudflare Tunnel Zero

Este contenedor Docker permite ejecutar un túnel de Cloudflare usando `cloudflared`. Está basado en la imagen de debian y utiliza el archivo binario `cloudflared-linux-amd64.deb` para instalar `cloudflared`.

## Crear imagen

```bash

git clone https://github.com/JDMoreu/cloudflare-tunnel.git

docker build -t cloudflare-tunnel /cloudflare-tunel

```

Tambien puedes descargarla desde dockerhub junto con su documentación: `https://hub.docker.com/r/jdmoreu/cloudflare-tunnel`
