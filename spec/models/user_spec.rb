require 'rails_helper'

RSpec.describe "User" do # User モデルについて記述（describe）する
  it "is valid with a name and email" # name と email を保持している
  it "is invalid without a name"      # name が無いと無効である
end