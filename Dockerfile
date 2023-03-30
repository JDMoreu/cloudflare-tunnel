FROM alpine:latest

RUN apk add --no-cache wget && \
    wget -q https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-arm64.deb && \
    rm cloudflared-linux-arm64.deb

WORKDIR /app

COPY entrypoint.sh /app
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]
