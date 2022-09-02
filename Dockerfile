FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-mysql-client \
    yarn

CMD ["rails", "server", "-b", "0.0.0.0"]

# コンテナ立上げ後に自動で実施できれば効率的
# WORKDIR /code
# RUN bundle install
# RUN gem update --system
