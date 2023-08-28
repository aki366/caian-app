FROM ruby:3.0.3

ENV LANG C.UTF-8
ENV TZ Asia/Tokyo

RUN apt-get update && \
    apt-get install -y curl apt-transport-https wget build-essential nodejs && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y yarn

# Install Google Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list \
    && apt-get update -y \
    && apt-get install -y google-chrome-stable

WORKDIR /caian-app

# nginxのerrorページを表示するために、publicディレクトリをマウント
VOLUME /caian-app/public
# nginx socketファイルをマウント
VOLUME /caian-app/tmp

RUN gem install bundler:2.3.0

CMD /bin/sh -c "rm -f tmp/pids/server.pid && bundle exec rails s"
