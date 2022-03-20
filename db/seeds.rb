# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# ゲストユーザーをあらかじめ登録しておく
User.create(name: "ゲストユーザー",
  email: "guest@example.com",
  password: "password",
  profile: "ゲストユーザー専用アカウント",
  user_image: "guest_user_icon.png",
  career: "不明")
