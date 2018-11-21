FactoryBot.define do
  factory :comment do
    user
    movie
    content { Faker::Lorem.sentence(2) }
  end
end
