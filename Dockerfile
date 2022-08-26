FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-mysql-client \
    yarn

# RUN mkdir /Caian_app
# WORKDIR /Caian_app
RUN mkdir /code
WORKDIR /code

# COPY ["<ソース>",... "<送信先>"]
# COPY Gemfile /Caian_app/Gemfile
# COPY Gemfile.lock /Caian_app/Gemfile.lock
COPY Gemfile /code/Gemfile
COPY Gemfile.lock /code/Gemfile.lock
RUN bundle install
RUN gem update --system

# COPY . /Caian_app
COPY docker-compose.yml /code/docker-compose.yml
COPY Dockerfile /code/Dockerfile
