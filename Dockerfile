FROM ruby:3.0.1-alpine as os

ARG BUILD_PACKAGES="build-base g++ gcc make git"
RUN gem install bundler:2.2.15 && \
    bundle config --global --jobs `expr $(grep processor /proc/cpuinfo | wc -l) - 1` && \
    bundle config build.nokogiri --use-system-libraries && \
    apk update && \
    apk add --update --no-cache libxslt-dev ${BUILD_PACKAGES} less nodejs \
    yarn nginx tzdata curl openssl tar



FROM os as gems

COPY Gemfile .
COPY Gemfile.lock .
COPY package.json .

RUN bundle install && \
    apk del build-base g++ gcc make git && \
    rm -r /var/cache/apk/*



FROM gems

ARG PORT=3000

ENV TZ America/Sao_Paulo
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV APP_PATH /app

WORKDIR $APP_PATH
EXPOSE $PORT

COPY . $APP_PATH

RUN yarn install
RUN bundle exec rails webpacker:install

CMD ["./scripts/web.sh"]
