FactoryBot.define do

  factory :comment do
    association :post
    comment_text { 'テスト投稿' }
  end
end
