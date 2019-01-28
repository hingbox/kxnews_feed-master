FROM python:3.6.3-alpine3.4

RUN mkdir -p ./.pip && touch pip.conf

RUN echo "http://mirrors.aliyun.com/alpine/v3.4/main/" | tee /etc/apk/repositories
RUN echo " [global]\ntrusted-host=mirrors.aliyun.com\nindex-url=http://mirrors.aliyun.com/pypi/simple" | tee ./.pip/pip.conf

WORKDIR /app

ADD ./requirements.txt ./requirements.txt

RUN apk add --update \
    bash \
    mysql-dev \
    build-base \
    libxml2-dev \
    libxslt-dev \
  && pip install -r requirements.txt \
  && rm -rf /var/cache/apk/*

ADD ./ ./
