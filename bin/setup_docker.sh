#!/bin/bash

echo -e "start caian_app setup_docker\n"

IMAGE_NAME="caian_app"
CREATION_DATE=$(docker inspect $IMAGE_NAME --format '{{.Created}}' 2>/dev/null)

echo "コンテナイメージの確認"
if [ -z "$CREATION_DATE" ]; then
  echo " $IMAGE_NAME のイメージが存在していないため、作成しています。"
  docker compose -f docker-compose.yml build
  if [[ $? != 0 ]]; then
    echo -e " Dockerイメージのビルドに失敗しました。\n"
    exit 1
  fi
else
  # イメージの作成日から、ミリ秒部分を切り捨てる
  CREATION_DATE=$(echo "$CREATION_DATE" | cut -d. -f1)
  # イメージの作成日をUnixタイムスタンプに変換
  CREATION_TIMESTAMP=$(date -jf "%Y-%m-%dT%H:%M:%S" "$CREATION_DATE" +%s)
  # 現在の日付をUnixタイムスタンプに変換
  CURRENT_TIMESTAMP=$(date +%s)
  # 2週間を秒数で計算
  TWO_WEEKS=$((2 * 7 * 24 * 60 * 60))
  # 作成から現在までの経過時間を計算
  ELAPSED_TIME=$(($CURRENT_TIMESTAMP - $CREATION_TIMESTAMP))

  if [ $ELAPSED_TIME -ge $TWO_WEEKS ]; then
    echo -e " イメージが古いため、更新します。\n"
    docker compose -f docker-compose.yml build

    if [[ $? != 0 ]]; then
      echo -e " Dockerイメージのビルドに失敗しました。\n"
      exit 1
    fi
  else
    echo -e " 古いイメージではないため、更新しません。\n"
  fi
fi

echo -e "\nコンテナの起動"
docker compose -f docker-compose.yml up -d

echo -e "\nDBのセットアップ確認"

# DB用コンテナの起動状態を確立する
if ! docker compose -f docker-compose.yml logs mysql 2>&1 | grep -q "Ready for start up"; then
  start_time=$(date +%s)
  echo " Waiting for MySQL to be ready..."

  while ! docker compose -f docker-compose.yml logs mysql 2>&1 | grep -q "Ready for start up"; do
    elapsed_time=$(($(date +%s) - start_time))
    echo -ne "  Elapsed time: $elapsed_time sec.\r"
    sleep 1
  done
  echo -e "\n  MySQL is now ready.\n"
fi

# caian-app-1が起動していない場合、コンテナを起動する
if [ "$(docker inspect --format '{{.State.Running}}' caian-app-1)" == "false" ]; then
  echo " caian-app コンテナが停止しているため、起動します。"
  docker start caian-app-1 > /dev/null 2>&1
fi

# データベース一覧を取得
DATABASES=$(docker-compose -f docker-compose.yml exec -T mysql mysql -u root -e "SHOW DATABASES;" | tr -d "| " | grep -v Database)

# 開発環境用DBの確認
if ! echo " $DATABASES" | grep -q "caian_development"; then
  echo "  caian_development が存在していないため、作成しています。"
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:create > /dev/null 2>&1
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:migrate > /dev/null 2>&1
  echo -e "  caian_development を作成しました。"
else
  echo -e "  caian_development は存在していたため、作成しません。"
fi

# テスト用DBの確認
if ! echo "$DATABASES" | grep -q "caian_test"; then
  echo "  caian_test が存在していないため、作成しています。"
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:create RAILS_ENV=test > /dev/null 2>&1
  docker compose -f docker-compose.yml exec -T app bundle exec rails db:migrate RAILS_ENV=test > /dev/null 2>&1
  echo -e "  caian_test を作成しました。\n"
else
  echo -e "  caian_test は存在していたため、作成しません。\n"
fi

echo -e "セットアップが完了しました。\n"
docker ps -a --format "{{.ID}} {{.Names}} {{.Status}}" | awk '{ printf "%-13s %-44s %-50s\n", $1, $2, $3 " " $4 " " $5 " " $6 " " $7 " " $8 " " $9}'
