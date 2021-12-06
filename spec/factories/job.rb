FactoryBot.define do
  factory :job do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(2) }
    company { Faker::Lorem.word }
    user { create(:user) }
  end
end