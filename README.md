# Contenedor Docker para Cloudflared

Este contenedor Docker permite ejecutar un túnel de Cloudflare usando `cloudflared`. Está basado en la imagen de Alpine Linux y utiliza el archivo binario `cloudflared-linux-arm64.deb` para instalar `cloudflared`.

## Cómo funciona

El contenedor ejecuta un script `entrypoint.sh` que realiza las siguientes acciones:

1. Solicita la autenticación del túnel.
2. Crea el túnel y configura la ruta DNS.
3. Configura las credenciales del túnel.
4. Inicia el túnel.

## Cómo ejecutar el contenedor

Puedes ejecutar el contenedor usando `docker run` o `docker-compose`. A continuación, se muestra un ejemplo de archivo `docker-compose.yml` para la configuración de tu contenedor:

```bash
docker run -d \
  --name cloudflared \
  -e NAME=my_tunnel_name \
  -e hostname=my.hostname.com \
  -e protocol=http \
  -e port=80 \
  -v /root/.cloudflared:/root/.cloudflared \
  -p 80:80 \
  jdmoreu/cloudflare-tunnel-alpine

```

```yaml

version: "3.9"
services:
  cloudflared:
    image: jdmoreu/cloudflare-tunnel-alpine
    ports:
      - "80:80"
    environment:
      - NAME=my_tunnel_name
      - hostname=my.hostname.com
      - protocol=http
      - port=80
    volumes:
      - /root/.cloudflared:/root/.cloudflared

```
Para ejecutar el contenedor con docker-compose, guarda el archivo docker-compose.yml en la misma carpeta que tu Dockerfile, y ejecuta docker-compose up.

## Variables de entorno

El contenedor utiliza las siguientes variables de entorno para configurar el túnel:

- NAME: Nombre del túnel.
- hostname: Hostname del dominio al que apuntará el túnel.
- protocol: Protocolo del servicio local al que se conectará el túnel (por ejemplo, http o https).
- port: Puerto del servicio local al que se conectará el túnel.

No olvides configurar estas variables en el archivo docker-compose.yml o en la línea de comandos docker run antes de ejecutar el contenedor.

## Volumen

El contenedor utiliza un volumen para almacenar las credenciales del túnel y la configuración en `/root/.cloudflared`. Asegúrate de montar este volumen en el host para mantener la configuración entre reinicios del contenedor.
