FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    roles { {admin: false, developer: [true, false].sample, customer: [true, false].sample} }
  end

  factory :ticket do
    title { Faker::Quote.famous_last_words }
    description { Faker::Lorem.paragraphs(number: rand(4...10)).join("\n") }
    status { Ticket.statuses.values.sample }
    priority { Ticket.priorities.values.sample }
    user { User.customers.all.sample }
  end
end
