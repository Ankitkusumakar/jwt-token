FactoryBot.define do
    factory :email, class: "User" do
      username {"yyyyyyy"}
      email {Faker::Internet.free_email}
      password {Faker::Internet.password}
    end
end 