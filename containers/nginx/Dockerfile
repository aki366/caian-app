FROM nginx:1.18.0

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# COPY public-data /caian_app/public
# COPY tmp-data /caian_app/tmp

# Nginxの設定ファイルをコンテナにコピー
# ADD /containers/nginx/nginx.conf /etc/nginx/conf.d/caian_app.conf
ADD nginx.conf /etc/nginx/conf.d/caian_app.conf

# for health check
RUN apt-get update && apt-get install -y curl


# ビルド完了後にNginxを起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf
