# Caian
![figure of ER](app/assets/images/top.png)
<br>
※現在開発中の為、サービスを公開しておりません。

## 開発実績
- 2022/02/01 開発開始
- 2022/08/13 時点(total：964.0h)

<p align="left"> 
  <img alt="Top Langs" height="150px" src="https://github-readme-stats.vercel.app/api/top-langs/?username=aki366&layout=compact&show_icons=true&theme=onedark" />
  <img alt="github stats" height="150px" src="https://github-readme-stats.vercel.app/api?username=aki366&theme=onedark&show_icons=ture" />
</p>

[![trophy](https://github-profile-trophy.vercel.app/?username=aki366&theme=onedark&column=7
)](https://github.com/ryo-ma/github-profile-trophy)

## 設計

### ER図
<details>
<summary>ER図（表示）</summary>

![figure of ER](app/assets/images/ER図.png)
</details>

### インフラ構成図

### 画面設計図

[figma:画面設計図](https://www.figma.com/file/89WqHwRatfXBjokkGxmqq4/original?node-id=0%3A1)

<details>
<summary>ユーザー詳細（表示）</summary>

![figure of ER](app/assets/images/ユーザー詳細.png)
</details>

<details>
<summary>チーム管理（表示）</summary>

![figure of ER](app/assets/images/チーム管理.png
)
</details>

<details>
<summary>チームトーク（表示）</summary>

![figure of ER](app/assets/images/チームトーク.png
)
</details>

### 画面遷移図
<details>
<summary>画面遷移図（表示）</summary>

![画面遷移図](app/assets/images/画面遷移図.png)
</details>

<br>

## Caianとは
### チームリーダーのマネージメントをサポートする
### 実績評価とチケット管理が一つになったSNSサービスです

<br>

## サービス概要
このサービスはチームに所属するメンバーとメンバーが投稿した提案を評価するリーダーで構成されています。

### リーダーとメンバー

<details>
<summary>リーダーとは（表示）</summary>
<br>
チームを新規作成したユーザーは自動でそのチームのリーダーになります。<br>
リーダーは、メンバーが投稿したチケットの承認や評価などの機能が使用できます。<br>
<br>

**あなたはチームのリーダーとしてこんな悩みを抱えていませんか？**<br>

- メンバーの日々の頑張りを評価に反映したいが、忙しくて把握できない<br>
- 定量的な評価がされず不満を抱いているメンバーがいる<br>

もっとメンバーの日頃の成果を評価したい、マネージメントに集中したい!<br>
そんな思いにCaianは答えます<br>

**マネージメントをもっとスマートに、当たり前に**<br>
<br>
</details>

<details>
<summary>メンバーとは（表示）</summary>
<br>
リーダーから招待されてチームに所属したユーザーのこと<br>
<br>

**あなたはチームの一員としてこんな悩みを抱えていませんか？**<br>

- 日々、タスクや改善活動をしているが、承認フローが面倒<br>
- 自分が行ったタスクや成果を一元管理できていない<br>
- 日々の成果をリーダーにアピールできていない<br>

もっとスマートに自分の成果を管理したい!<br>
そんな思いにCaianは答えます。<br>

**あなたの努力は努力せずに評価されます。**<br>
<br>
</details>

### 主要サービス
<details>
<summary>チケット管理（表示）</summary>
<br>

- 日々のちょっとした業務改善や手順作成の連絡と承認を1つのチケットで管理できます。
- リーダーはメンバーが作成したチケットに３段階の評価ポイントを付けて承認するだけです。
- コメントを添えてフィードバックすることも可能です。
<br>
</details>

<details>
<summary>実績評価（表示）</summary>
<br>

- メンバーが投稿したチケットは自動で数値化、グラフ化され、いつでも最新の実績を把握することができます。
- メンバーごとの実績をマージしてチームの強みと弱みを視覚的に把握できます。
<br>
</details>

<details>
<summary>SNS機能（表示）</summary>
<br>

- メンバー同士でメッセージを交換することも可能です。
- 提案された投稿やコメントにメンバー同士で『いいね！』を付けることができます。
<br>
</details>

<br>

## サービス開始の流れ
<details>
<summary>ユーザー登録 簡単1ステップ（表示）</summary>
<br>

- あなたは所属するチームのリーダーから招待を受け取りメンバーになるだけ。
- あなたがリーダーとなって、自由にチームを作りメンバーを招待することも可能です。
- 役職や細かい権限の設定は不要。リーダーかメンバーだけです。
</details>

<br>

## 制作背景

<details>
<summary>制作背景について（表示）</summary>
<br>
前職でリーダーを経験した際に、メンバーが行った改善活動や問題提起のアウトプット方法が様々で評価する際の数値化などに手間が掛っていました。そのため、せっかくの提案も実績として抜けていたり、透明性が無かったりという経験をしました。<br>
そういった背景から、もっと手軽に適切に、管理、評価できるサービスを提供できないかと考えこのサービスを開発しました。
</details>

<br>

## 使用技術
※1　実装予定
### フロントエンド
- HTML/CSS
- JavaScript
- chart.js　※1
- Vue.js　※1
- Vuetify　※1
- Nuxt.js　※1

### バックエンド
- Ruby 3.0.3
- Ruby on Rails 6.1.4.3
- MySQL 8.0.30

### インフラ
- Heroku
- Nginx/Puma
- AWS(VPC/EC2/RDS/ALB/S3/ACM/Route53)　※1
- ECS（Fargate）　※1

### テスト
- RSpec
- Jest

### 解析ツール
- RuboCop

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
<br>

- ユーザー新規登録/編集/削除
- ユーザーアイコン登録/編集/削除
- ログイン/ログアウト/ゲストログイン
- パスワード再設定
<br>
</details>

<details>
<summary>チケット（表示）</summary>
<br>

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
<br>
</details>

<details>
<summary>チケットへのコメント（表示）</summary>
<br>

- 投稿/編集/削除
- 投稿日時表示
- コメント
<br>
</details>

<details>
<summary>チャット機能（表示）</summary>
<br>

- チャンネル
- ダイレクトメッセージ
- メッセージ投稿
- チケットの投稿
<br>
</details>

<details>
<summary>実績の数値化・グラフ化（表示）</summary>
<br>

- 投稿数
- 加点
- ポイント（投稿数＋加点）
- ユーザ一覧で実績表示（リーダーのみ表示）
<br>
</details>

<details>
<summary>その他（表示）</summary>
<br>

- 検索機能
- レスポンシブデザイン
＜以下余裕があれば実装＞
- リマインダー機能
- 通知機能（投稿、更新）
<br>
</details>
