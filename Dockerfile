FROM ruby:3.1.2

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client

# RUN apk add --update build-base bash bash-completion libffi-dev tzdata postgresql-client postgresql-dev nodejs npm yarn

RUN mkdir /mystery-lunch-app
WORKDIR /mystery-lunch-app

COPY Gemfile* /mystery-lunch-app/
# COPY Gemfile /mystery-lunch-app/Gemfile
# COPY Gemfile.lock /mystery-lunch-app/Gemfile.lock

RUN gem install bundler -v 2.3.12

RUN bundle install

COPY . /mystery-lunch-app

EXPOSE 3000

CMD ["bash"]