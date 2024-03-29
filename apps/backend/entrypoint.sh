#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /caian_app/tmp/pids/server.pid

echo "開発用DBの作成"
bundle exec rails db:create
bundle exec rails db:migrate

echo -e "\nテスト用DBの作成"
bundle exec rails db:create RAILS_ENV=test
bundle exec rails db:migrate RAILS_ENV=test

bundle exec rails db:seed

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
