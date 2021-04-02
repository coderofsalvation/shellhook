progressive websocket-enhancement for CLI-scripts, embed logs in UI, tiny (14MB) & unixy

![](https://raw.githubusercontent.com/coderofsalvation/shellhook/master/www/index.gif)

## Install

```bash
$ docker build . -t shellhook
$ docker run -v $(pwd):/shellhook -p 8080:8080 shellhook
```

## Usage

```bash
$ cat bin/helloworld
        #!/bin/bash
        source $(dirname $0)/.shellhook

        # serve curl requests with a logfile
        is_browser && is_curl && run_in_background 

        {
          date && sleep 1s && date && sleep 1s
          set | grep -E '^(HTTP_|HOST|QUERY_STRING|REQUEST|SERVER)'
        } | datify
```

```bash
$ curl localhost:8080/helloworld      # browsers will see a livestream
localhost:8080/log?75                 # curl will be redirected to the log-url
```

```bash
$ curl localhost:8080/log?75
[2021-04-02 11:01:55] Fri Apr  2 11:01:55 UTC 2021
[2021-04-02 11:01:56] Fri Apr  2 11:01:56 UTC 2021
[2021-04-02 11:01:57] HOSTNAME=84532747df33
[2021-04-02 11:01:57] HOSTTYPE=x86_64
[2021-04-02 11:01:57] HTTP_ACCEPT='*/*'
[2021-04-02 11:01:57] HTTP_HOST=localhost:8080
[2021-04-02 11:01:57] HTTP_USER_AGENT=
[2021-04-02 11:01:57] QUERY_STRING=
[2021-04-02 11:01:57] REQUEST_METHOD=GET
[2021-04-02 11:01:57] REQUEST_URI=/helloworld
[2021-04-02 11:01:57] SERVER_NAME=localhost:8080
[2021-04-02 11:01:57] SERVER_PORT=8080
[2021-04-02 11:01:57] SERVER_PROTOCOL=HTTP/1.1
[2021-04-02 11:01:57] SERVER_SOFTWARE='websocketd/0.4.1 (go1.15.7 linux-amd64) --'
^C
```

```bash
$ echo "foobarrr" >> log/75
$ curl localhost:8080/log?75 | tail -n2
[2021-04-02 11:01:57] SERVER_SOFTWARE='websocketd/0.4.1 (go1.15.7 linux-amd64) --'
foobarrr

```
