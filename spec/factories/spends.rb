FactoryBot.define do
  factory :spend, class: "Spend" do
    account_id { 15 }
    name { "MyString" }
    amount { 2000 }
    spend_date { "2023-04-25" }
    is_active { true }
  end
end
