FROM alpine:3.2

WORKDIR /shellhook

RUN apk --no-cache --update add bash wget curl jq ca-certificates unzip \
  && wget "https://github.com/joewalnes/websocketd/releases/download/v0.4.1/websocketd-0.4.1-linux_amd64.zip" \
  && unzip *.zip \
  && rm *.zip \
  && mv websocketd /bin/. \
  && addgroup -g 1000 shellhook \
  && adduser -D -u 1000 -G shellhook shellhook \
  && rm -rf /var/cache/apk/*

USER shellhook

CMD ["/bin/websocketd","--cgidir=/shellhook/bin","--staticdir=/shellhook/www","--dir=/shellhook/bin","-port","8080","-maxforks","2"]
