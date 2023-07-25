FROM ruby:3.0.3

# ruby:3.0.3のバージョンが新しいため、バグによる起動が出来ていない可能性あり
# そのため、手動でサービスを立ち上げるコマンドを設定
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y yarn
RUN apt-get update -qq && apt-get install -y build-essential nodejs

RUN mkdir /caian_app
WORKDIR /caian_app

COPY Gemfile /caian_app/Gemfile
COPY Gemfile.lock /caian_app/Gemfile.lock

RUN bundle install

COPY . /caian_app

# nginxのerrorページを表示するために、publicディレクトリをマウント
VOLUME /caian_app/public
# nginx socketファイルをマウント
VOLUME /caian_app/tmp

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

CMD /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s"
