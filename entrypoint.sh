#!/bin/bash
set -e
 
# Remove a potentially pre-existing server.pid for Rails.
rm -f /caian_app/tmp/pids/server.pid

# DBセットアップ
# 初回のみ実行
bundle exec rails db:create RAILS_ENV=production

bundle exec rails db:migrate RAILS_ENV=production
bundle exec rails db:seed RAILS_ENV=production

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
