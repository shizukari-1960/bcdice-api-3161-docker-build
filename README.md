# BCDice-API
BCDiceを提供するWebAPIサーバー

Modify from original repo [BCDice-API](https://github.com/bcdice/bcdice-api)

## The Auther
酒田　シンジ (@ysakasin)

## What is BCDice

BCDiceは日本のTRPGセッションツールにおいて、デファクトスタンダードとも言えるダイスロールエンジンです。
初めは、Faceless氏によってPerlを用いて作成されました。後に、たいたい竹流氏によってRubyへの移植され、現在までメンテナンスされています。

BCDiceは[どどんとふ](http://www.dodontof.com)をはじめとして、[TRPGオンラインセッションSNS](https://trpgsession.click)や[Onset!](https://github.com/kiridaruma/Onset)においてダイスロールエンジンとして使われています。

## Setup Using .tar in release page
If you wanna run this on Windows, a WSL2 env is required, ensure all requirements to enable it is fulfilled, using docker-desktop might help.

1.load docker image
```
# Linux / Windows with docker desktop
$ docker import <.tar name>.tar <docker image name you want>
```
2.Create docker-compose.yml
```
services:
  bcdice-api:
    image: <docker image name>
    ports:
      - "9292:9292" # left:port for outside connection. right:port inside docker container.
    restart: always
```
3.Enable docker-compose service
```
# Linux / Windows with docker desktop
# at path which docker-compose.yml exist.
$ docker compose up -d
```

4.Connection test
Connect to http://localhost:9292/v2/version
Should shows msg like below:
```{"api":"3.0.0","bcdice":"3.16.1"}```

## Compile your own version docker image
Not that familiar with ruby, so sth unpredictable may happen.

1. clone this repo
2. (OPTIONAL) delete ./bcdice if version got too old, and clone new one from [Bcdice](https://github.com/bcdice/BCDice), remove ./bcdice/.git and ./bcdice/.github.
3. 
```
# at path which Dockerfile exitst.
$ docker build -t <docker image name u want> --no-cache .
```
4.Delopy by using `docker-compose.yml` above mentioned.







