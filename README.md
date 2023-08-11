# [Caian](https://caian.link)
https://caian.link


![figure of ER](app/assets/images/top.png)
<br>

## 開発環境の構築手順
1. リポジトリをクローンしたら、トップディレクトリに移動します。
2. 以下のコマンドを実行して、環境構築用のシェルを起動します。このシェルは、コンテナイメージの作成からサービスの立ち上げまでを行います。
```
$./bin/setup_docker.sh
```

## Wiki
開発に関わるドキュメントについては、[wiki](https://github.com/aki366/Caian_app/wiki/Wiki) を参照して下さい。

## 開発実績
<p align="left"> 
  <img alt="Top Langs" height="150px" src="https://github-readme-stats.vercel.app/api/top-langs/?username=aki366&layout=compact&show_icons=true&theme=onedark" />
  <img alt="github stats" height="150px" src="https://github-readme-stats.vercel.app/api?username=aki366&theme=onedark&show_icons=ture" />
</p>

<br>

## 使用技術

### Front-end
- React
- JavaScript
- HTML/CSS

### Back-end
- Ruby (3.0.3)
- Rails (6.1.5)

### Database
- MySQL (8.0.30)

### Infrastructure
- Web Server & Application Server
  - Nginx (1.23.1)
  - Puma (5.6.2)

- AWS Services
  - Route 53
  - VPC
  - ALB
  - ECR
  - ECS (Fargate)
  - RDS
  - S3

### Testing
- RSpec (3.11)
- Jest

### Linting Tools
- RuboCop (1.26.1)

### CI/CD
- GitHub Actions

### Version Control
- Git

### Hosting & Collaboration
- GitHub

### Development Environment
- VScode
- Docker (24.0.5)
- Docker Compose (2.20.2)
- Docker Desktop (4.22.0)

<br>

## 設計

<details>
<summary>ER図</summary>
<br>

![figure of ER](app/assets/images/ERD.png)
</details>

<details>
<summary>インフラ構成図</summary>
<br>

![figure of ER](app/assets/images/Infrastructure_diagram.png)
</details>

<details>
<summary>画面遷移図</summary>
<br>

![画面遷移図](app/assets/images/Screen_transition_diagram.png)
</details>

<br>

## デザイン
### [figma](https://www.figma.com/file/89WqHwRatfXBjokkGxmqq4/original?node-id=0%3A1)

<details>
<summary>ユーザー詳細</summary>
<br>

![figure of ER](app/assets/images/user_show.png)
</details>

<details>
<summary>チーム管理</summary>
<br>

![figure of ER](app/assets/images/team_management.png
)
</details>

<details>
<summary>チームトーク</summary>
<br>

![figure of ER](app/assets/images/team_talk.png
)
</details>

<br>

## サービス概要
当サービスは、チームの実績評価を効果的に行うためのプラットフォームです。メンバーは自らの課題解決の実績を投稿し、リーダーがそれに対してポイントを付与します。各課題はカテゴリ別に分類されるため、チームや個人の強みや向き合うべき課題を明確に可視化することができます。

<details>
<summary>リーダーとは何か？</summary>
<br>
チームを作成したユーザーは、自動的にそのチームのリーダーとしての役割を持ちます。このリーダーの特権として、メンバーが投稿したチケットの承認や評価などの特別なアクションを行うことができます。
<br>
<br>

**リーダーとしての悩み、持っていませんか？**<br>

- 忙しさに追われ、メンバーの日々の活動や努力を正確に評価できていない
- 一貫した評価の基準が欠けており、メンバーに不満が生じている

これらの悩みにCaianが解決策を提供します。

**マネージメントはスマートであるべき、それが当然です。**<br>
<br>
</details>

<details>
<summary>メンバーとは何か？</summary>
<br>
メンバーとは、リーダーからの招待を受けてチームに参加したユーザーを指します。<br>
<br>

**チームの一員として、これらの悩みを感じたことはありませんか？**<br>

- 様々なタスクや改善活動に取り組んでいるものの、その承認プロセスが煩雑
- 実施したタスクや達成した成果を一元管理する方法がない
- 努力や成果をリーダーに効果的に伝える手段が不足している

自分の成果をもっと簡単に、そして明確に管理したいと思っているなら、Caianがその要望を叶えます。

**あなたの日々の努力は、当然のように評価されるべきです。**<br>
<br>
</details>

<details>
<summary>チケットの概要</summary>
<br>
チケットとは、業務の改善や手順の提案など、メンバーが意見や要求をまとめて共有するためのフォーマットです。
<br>
<br>

- メンバーは業務改善の提案や手順作成のアイディアをチケットとして作成・提出します。
- リーダーには、提出されたチケットに対して3段階の評価ポイントを付与し、それに基づいて承認を行う役割があります。
- さらに、評価や承認の際にコメントを付けることで、具体的なフィードバックや意見交換が可能となっています。
<br>
</details>

<details>
<summary>実績評価の仕組み</summary>
<br>
チケットを通じての実績評価は、以下の特徴を持っています<br>
<br>

- メンバーが提出するチケットは自動的に数値データに変換され、グラフとして視覚化されます。これにより、最新の実績を随時確認することができます。
- それぞれのメンバーの実績を統合することで、チーム全体の強みや改善点を一目で理解することが可能です。
</details>

<br>

## 制作背景

<details>
<summary>制作背景について</summary>
<br>
前職でリーダーを経験した際に、メンバーが行った改善活動や問題提起のアウトプット方法が様々で評価する際の数値化などに手間が掛っていました。そのため、せっかくの提案も実績として抜けていたり、透明性が無かったりという経験をしました。<br>
そういった背景から、もっと手軽に適切に、管理、評価できるサービスを提供できないかと考えこのサービスを開発しました。
</details>

<br>

## 機能一覧

<details>
<summary>ユーザー詳細</summary>
<br>

- ユーザー新規登録/編集/削除
- ユーザーアイコン登録/編集/削除
- ログイン/ログアウト/ゲストログイン
- パスワード再設定
<br>
</details>

<details>
<summary>チケット機能</summary>
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
<summary>チケットへのコメント機能</summary>
<br>

- 投稿/編集/削除
- 投稿日時表示
- コメント
<br>
</details>

<details>
<summary>チャット機能</summary>
<br>

- チャンネル
- ダイレクトメッセージ
- メッセージ投稿
- チケットの投稿
<br>
</details>

<details>
<summary>実績の数値化・グラフ化</summary>
<br>

- 投稿数
- 加点
- ポイント（投稿数＋加点）
- ユーザ一覧で実績表示（リーダーのみ表示）
<br>
</details>

<details>
<summary>今後リリース予定の機能</summary>
<br>

- レスポンシブデザイン
- 検索機能
- リマインダー機能
- 通知機能（投稿、更新）
<br>
</details>
