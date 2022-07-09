FactoryBot.define do

  factory :comment do
    association :post
    comment_text { 'Commentのテスト投稿' }
  end
end
