#!/bin/bash

echo -e "start caian_app setup_docker\n"

# イメージ名とタグを指定
IMAGE_NAME="caian_app"
# caian_app イメージの作成日を取得
CREATION_DATE=$(docker inspect $IMAGE_NAME --format '{{.Created}}' 2>/dev/null)

echo "コンテナイメージの最終更新日を確認します。"
if [ -z "$CREATION_DATE" ]; then
  echo -e "$IMAGE_NAME イメージが存在しないため、イメージを作成します。\n"
  docker compose -f docker-compose.yml build
  if [[ $? != 0 ]]; then
    echo -e "Dockerイメージのビルドに失敗しました。\n"
    exit 1
  fi
else
  # イメージの作成日をUnixタイムスタンプに変換
  CREATION_TIMESTAMP=$(date -jf "%Y-%m-%dT%H:%M:%S" "$CREATION_DATE" +%s)
  # 現在の日付をUnixタイムスタンプに変換
  CURRENT_TIMESTAMP=$(date +%s)
  # 2週間を秒数で計算
  TWO_WEEKS=$((2 * 7 * 24 * 60 * 60))
  # 作成から現在までの経過時間を計算
  ELAPSED_TIME=$(($CURRENT_TIMESTAMP - $CREATION_TIMESTAMP))

  if [ $ELAPSED_TIME -ge $TWO_WEEKS ]; then
    echo -e "イメージが古いため、更新します。\n"
    docker compose -f docker-compose.yml build

    if [[ $? != 0 ]]; then
      echo -e "Dockerイメージのビルドに失敗しました。\n"
      exit 1
    fi
  fi
  echo -e "古いイメージではないため、更新しません。\n"
fi

# Dockerコンテナを起動
docker compose -f docker-compose.yml up -d
echo -e "コンテナを起動しました\n"

# caian_appのセットアップ
echo "caian_appのセットアップを開始します。"

# コンテナ内でのMySQLのデータベース一覧を取得
DATABASES=$(docker-compose -f docker-compose.yml exec -T mysql mysql -u root -e "SHOW DATABASES;" | tr -d "| " | grep -v Database)

# caian_appデータベースの存在確認
if ! echo "$DATABASES" | grep -q "caian_development"; then
  # caian_appが存在しない場合、データベースを作成
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:create
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:migrate
  echo -e "caian_development を作成しました。"
else
  echo -e "caian_development は存在していたため、作成しません。"
fi

# caian_testデータベースの存在確認
if ! echo "$DATABASES" | grep -q "caian_test"; then
  # caian_testが存在しない場合、データベースを作成しマイグレーションを実行
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:create RAILS_ENV=test
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:migrate RAILS_ENV=test
  echo -e "caian_test を作成しました。\n"
else
  echo -e "caian_test は存在していたため、作成しません。\n"
fi
