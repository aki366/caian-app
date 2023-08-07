FactoryBot.define do
  factory :member do
    association :team
    # team_id { 1 }
    # user_id { 1 }
  end
end
