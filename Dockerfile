FROM ruby:2.7.1

WORKDIR /code_challenge

COPY . /code_challenge

RUN bundle install

CMD rails server
