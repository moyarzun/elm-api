# syntax=docker/dockerfile:1
FROM ruby:3.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
WORKDIR /usr/src/app
COPY Gemfile /usr/src/app/Gemfile
COPY Gemfile.lock /usr/src/app/Gemfile.lock
RUN bundle install
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
