FactoryBot.define do
  factory :logo_design, class: "logo_design" do
    account_id { "3" }
    filesize { "123" }
    filename { "s.png" }
    is_active { false }
  end
end
