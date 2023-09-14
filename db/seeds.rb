# AVO_ADMIN_PASSWORD=secret bin/rails db:seed

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
users = [
  {
    first_name: "Adrian",
    last_name: "Marin",
    email: "adrian@adrianthedev.com"
  },
  {
    first_name: "Paul",
    last_name: "Bob",
    email: "paul.ionut.bob@gmail.com"
  },
]

random_users_number = 2

users_progress_bar = ProgressBar.create(
  progress_params(total: users.size + random_users_number + 1, title: "Creating users")
)

random_users_number.times do
  FactoryBot.create(:user)
  users_progress_bar.increment
end

users.each do |user|
  FactoryBot.create(:user)
  users_progress_bar.increment
end

User.create(
  name: "Avo Cado",
  email: "avo@cado.com",
  password: (ENV["AVO_ADMIN_PASSWORD"] || :secret),
  roles: {
    admin: true,
    manager: false,
  }
)
users_progress_bar.increment
