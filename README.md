<p align="left"> 
  <img alt="Top Langs" height="150px" src="https://github-readme-stats.vercel.app/api/top-langs/?username=aki366&layout=compact&show_icons=true&theme=onedark" />
  <img alt="github stats" height="150px" src="https://github-readme-stats.vercel.app/api?username=aki366&theme=onedark&show_icons=ture" />
</p>

[![trophy](https://github-profile-trophy.vercel.app/?username=aki366&theme=onedark&column=7
)](https://github.com/ryo-ma/github-profile-trophy)

# 設計

## ER図
![figure of ER](app/assets/images/ER図.png)

## インフラ構成図

## 画面設計図
[figma:画面設計図](https://www.figma.com/file/89WqHwRatfXBjokkGxmqq4/original?node-id=0%3A1)

## 画面遷移図
![figure of ER](app/assets/images/画面遷移図.png)

<br>

# Caian
※現在開発中の為、サービスを公開しておりません。

<br>

## Caianとは
### チームリーダーのマネージメントをサポートする
### 実績評価とチケット管理が一つになったSNSサービスです

<br>

## サービス概要

### リーダー

<details>
<summary>リーダーとは（表示）</summary>

あなたはチームのリーダー<br>
定期的にメンバーの実績評価をしなくてはいけません。 <br>
あなたはメンバーの実績や成果物を把握していますか？ <br>
目標に対する成果だけではなく、日々の頑張りを評価に反映出来ていますか？ <br>
その評価は定量的に評価できていますか？ <br>
あなたの評価に不満を抱いているメンバーはいませんか？ <br>

もっとメンバーの日頃の成果を評価したい、マネージメントに集中したい。 <br>
そんな思いにCaianは答えます。<br>
**あなたやメンバーの努力は努力せずに評価されます。** <br> 

</details>

### メンバー

<details>
<summary>メンバーとは（表示）</summary>

あなたはチームの一員<br>
日々目の前のタスクや小さな問題に気づいては改善を繰り返しています。 <br>
そんなあなたは自分のタスクや成果を覚えていますか？ <br>
リーダーに成果をアピールできていますか？ <br>

もっとスマートに自分の成果を管理したい。 <br>
そんな思いにCaianは答えます。 <br>
**あなたの努力は努力せずに評価されます。** <br>

</details>

<br>

<details>
<summary>チケット管理・実績評価・SNS機能（表示）</summary>

### 1.  チケット管理
- 日々のちょっとした業務改善や手順作成の連絡と承認を1つのチケットで管理できます。
- リーダーはメンバーが作成したチケットに３段階の評価ポイントを付けて承認するだけです。
- コメントを添えてフィードバックすることも可能です。
### 2.  実績評価
- メンバーが投稿したチケットは自動で数値化、グラフ化され、いつでも最新の実績を把握することができます。
- メンバーごとの実績をマージしてチームの強みと弱みを視覚的に把握できます。
### 3.  SNS機能
- メンバー同士でメッセージを交換することも可能です。
- 提案された投稿やコメントにメンバー同士で『いいね！』を付けることができます。

</details>

<br>

## サービス開始の流れ
<details>
<summary>ユーザー登録 簡単1ステップ（表示）</summary>

- あなたは所属するチームのリーダーから招待を受け取りメンバーになるだけ。
- あなたがリーダーとなって、自由にチームを作りメンバーを招待することも可能です。
- 役職や細かい権限の設定は不要。リーダーかメンバーだけです。

</details>

<br>

## 制作背景

<details>
<summary>制作背景について（表示）</summary>
前職でリーダーを経験した際に、メンバーが行った改善活動や問題提起のアウトプット方法が様々で評価する際の数値化などに手間が掛っていました。そのため、せっかくの提案も実績として抜けていたり、透明性が無かったりという経験をしました。 <br>
そういった背景から、もっと手軽に適切に、管理、評価できるサービスを提供できないかと考えこのサービスを開発しました。

</details>

<br>

## 使用技術
### フロントエンド
- HTML/CSS
- JavaScript
- chart.js(第2段階で実装予定)
- Vue.js(第3段階で実装予定)
- Vuetify(第3段階で実装予定)
- Nuxt.js(+αで実装予定)

### バックエンド
- Ruby 3.0.3
- Ruby on Rails 6.1.4.3
- MySQL 8.0.27

### インフラ
- Heroku
- Nginx/Puma（将来の大量同時アクセスを想定）
- AWS(VPC/EC2/RDS/ALB/S3/ACM/Route53/ECS)(第3段階で実装予定)
- ECS（Fargate）(第3段階で実装予定)

### テスト
- RSpec
- Jest

### 解析ツール
- RuboCop（第１段階）

### CI/CD
- CircleCI
- Capistrano

### バージョン管理
- Git/GitHub

### 開発環境
- VScode
- Docker/docker-compose

## 機能一覧

<details>
<summary>ユーザー（表示）</summary>

### ユーザー
- ユーザー新規登録/編集/削除
- ユーザーアイコン登録/編集/削除
- ログイン/ログアウト/ゲストログイン
- パスワード再設定
</details>

<details>
<summary>チケット（表示）</summary>

### チケット
- 投稿/編集/削除
- 一覧表示、詳細表示
- 画像複数登録
- 投稿日時表示
- 投稿者
- ステータス
- カテゴリ
- 件名
- 内容
- いいね
- チケットとコメントを同一画面で表示
- チケット内容の表示（トップ画面に簡易表示、一覧表示、詳細表示、ソート機能）
</details>

<details>
<summary>チケットへのコメント（表示）</summary>

### チケットへのコメント
- 投稿/編集/削除
- 投稿日時表示
- コメント
</details>

<details>
<summary>チャット機能（表示）</summary>

### チャット機能
- チャンネル
- ダイレクトメッセージ
- メッセージ投稿
- チケットの投稿
</details>

<details>
<summary>実績の数値化・グラフ化（表示）</summary>

### 実績の数値化・グラフ化
- 投稿数
- 加点
- ポイント（投稿数＋加点）
- ユーザ一覧で実績表示（リーダーのみ表示）
</details>

<details>
<summary>その他（表示）</summary>

### その他
- 検索機能
- レスポンシブデザイン
＜以下余裕があれば実装＞
- リマインダー機能
- 通知機能（投稿、更新）
</details>
