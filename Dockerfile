FROM node:latest
EXPOSE 3000
ENV TZ=Asia/Shanghai
WORKDIR /app
#ADD file.tar.gz /app/
COPY *.* /app/

RUN apt-get update &&\
    apt-get install -y iproute2 apt-utils screen &&\
    npm install -g npm &&\
    npm cache clean -f  &&\
    npm install -g n  &&\
    n stable
RUN npm install -r package.json &&\
    npm install -g pm2 &&\
    #wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb &&\
    #wget -O cloudflared.deb https://github.com/cloudflare/cloudflared/releases/download/2023.4.1/cloudflared-linux-amd64.deb &&\
    dpkg -i /app/cloudflared-linux-amd64.deb &&\
    rm -f /app/cloudflared.deb &&\
    chmod +x web.js status-client

ENTRYPOINT [ "node", "server.js" ]
