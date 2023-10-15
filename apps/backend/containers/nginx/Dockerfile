FROM nginx:1.18.0

# インクルード用のディレクトリ内を削除
RUN rm -f /etc/nginx/conf.d/*

# Nginxの設定ファイルをコンテナにコピー
COPY ./nginx.conf /etc/nginx/conf.d/caian_app.conf

# ヘルスチェックとクリーンアップを追加
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# ヘルスチェックの設定
# HEALTHCHECK --interval=30s --timeout=3s \
#     CMD curl --silent --fail http://localhost/ || exit 1

# ビルド完了後にNginxを起動
CMD ["/usr/sbin/nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]
