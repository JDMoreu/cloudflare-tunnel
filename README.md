# Contenedor Docker para Cloudflare Tunnel Zero

Este contenedor Docker permite ejecutar un túnel de Cloudflare usando `cloudflared`. Está basado en la imagen de debian y utiliza el archivo binario `cloudflared-linux-amd64.deb` para instalar `cloudflared`.

## Crear imagen

```bash
git clone https://github.com/JDMoreu/cloudflare-tunnel.git
```

```bash
docker build -t cloudflare-tunnel /cloudflare-tunel
```

Tambien puedes descargarla desde dockerhub junto con su documentación: `https://hub.docker.com/r/jdmoreu/cloudflare-tunnel`

## Cómo funciona

El contenedor ejecuta un script `entrypoint.sh` que realiza las siguientes acciones:

1. Solicita la autenticación del túnel.
2. Crea el túnel y configura la ruta DNS.
3. Configura las credenciales del túnel.
4. Inicia el túnel.
