# AVO_ADMIN_PASSWORD=secret bin/rails db:seed
# AVO_ADMIN_PASSWORD=secret bin/rails db:seed:replant

def progress_params(total:, title:)
  {
    total: total,
    format: "\e[32m%t : %B %p%% %c/%C [ %a ]\e[0m",
    progress_mark: "=",
    length: 90,
    starting_at: 0,
    title: " #{title}",
    title_width: 20,
    throttle_rate: 0.01,
    remainder_mark: "."
  }
end

# ---------------------------------- USERS ---------------------------------- #
all_roles = User::ROLES.map { |k, v| [k, true] }.to_h

super_users = [
  {
    name: "Adrian Marin",
    email: "adrian@adrianthedev.com",
    password: (ENV["AVO_ADMIN_PASSWORD"] || :secret),
  },
  {
    name: "Paul Bob",
    email: "paul.ionut.bob@gmail.com",
    password: (ENV["AVO_ADMIN_PASSWORD"] || :secret),
  },
]

developers_number = 3
customers_number = 5

users_progress_bar = ProgressBar.create(
  progress_params(total: super_users.size + developers_number + customers_number + 1, title: "Creating users")
)

customers_number.times do
  FactoryBot.create(:user, roles: { admin: false, developer: false, customer: true })
  users_progress_bar.increment
end

developers_number.times do
  FactoryBot.create(:user, roles: { admin: false, developer: true, customer: false })
  users_progress_bar.increment
end

super_users.reverse.each do |user|
  FactoryBot.create(:user, name: user[:name], email: user[:email], roles: all_roles, password: user[:password])
  users_progress_bar.increment
end

User.create(
  name: "Avo Cado",
  email: "avo@cado.com",
  password: (ENV["AVO_ADMIN_PASSWORD"] || :secret),
  roles: all_roles,
  settings: { tutorial: true }
)
users_progress_bar.increment

# ---------------------------------- TICKETS --------------------------------- #
tickets_number = 10

tickets_progress_bar = ProgressBar.create(
  progress_params(total: tickets_number, title: "Creating tickets")
)

tickets_number.times do
  FactoryBot.create(:ticket)
  tickets_progress_bar.increment
end