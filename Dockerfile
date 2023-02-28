FROM ruby:3.1.2

RUN apt-get update -qq \
  && apt-get install -y nodejs postgresql-client

RUN mkdir /other-mystery-lunch-app
WORKDIR /other-mystery-lunch-app

COPY Gemfile /other-mystery-lunch-app/Gemfile
COPY Gemfile.lock /other-mystery-lunch-app/Gemfile.lock

RUN bundle install

COPY . /other-mystery-lunch-app

EXPOSE 3000

CMD ["bash"]