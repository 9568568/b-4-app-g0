FROM node:latest
EXPOSE 3000
ENV TZ=Asia/Shanghai
WORKDIR /app
#ADD file.tar.gz /app/
COPY *.* /app/

RUN apt-get update &&\
    apt-get install -y iproute2 apt-utils screen &&\
    npm install -r package.json &&\
    npm install -g pm2 &&\
    dpkg -i /app/cloudflared-linux-amd64.deb &&\
    rm -f /app/cloudflared.deb &&\
    chmod +x web.js status-client

ENTRYPOINT [ "node", "server.js" ]
