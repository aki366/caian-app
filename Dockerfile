FROM ruby:3.0.3

RUN apt-get update -qq && apt-get install -y \
    build-essential \
    libpq-dev \
    nodejs \
    default-mysql-client \
    yarn

RUN mkdir /Caian_app
WORKDIR /Caian_app

COPY Gemfile /Caian_app/Gemfile
COPY Gemfile.lock /Caian_app/Gemfile.lock
RUN bundle install
RUN gem update --system

COPY . /Caian_app

# RUN mkdir -p /tmp/mysql.sock
# RUN mkdir -p tmp/pids

# VOLUME /Caian_app/public
# VOLUME /Caian_app/tmp

# Add a script to be executed every time the container starts.
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]
# EXPOSE 3000
# Configure the main process to run when running the image
# CMD ["rails", "server", "-b", "0.0.0.0"]