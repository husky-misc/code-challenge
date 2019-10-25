FROM ruby:2.6.3-alpine
LABEL maintainer="mail@cadu.dev"

ARG bundle_without
ARG rails_env="development"

RUN apk add --update --no-cache \
    openssl \
    tar \
    build-base \
    tzdata \
    postgresql-dev \
    postgresql-client \
  && mkdir -p /var/app

ENV BUNDLE_JOBS=4 RAILS_ENV=${rails_env} BUNDLE_WITHOUT=${bundle_without} RAILS_LOG_TO_STDOUT=true SECRET_KEY_BASE=dumb

COPY . /var/app
WORKDIR /var/app

RUN gem install bundler
RUN bundle install \
 && rm -rf /usr/local/bundle/cache/*.gem \
 && find /usr/local/bundle/gems/ -name "*.c" -delete \
 && find /usr/local/bundle/gems/ -name "*.o" -delete

WORKDIR /var/app

EXPOSE 3000

CMD bin/rails s -b 0.0.0.0
