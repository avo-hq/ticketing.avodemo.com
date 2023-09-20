# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# When running `rake assets:precompile`
# 1 - Task `avo:yarn_install` will run first
# 2 - Task `avo:sym_link` will run second
# 3 - Task `assets:precompile` will run third
Rake::Task["assets:precompile"].enhance(["avo:sym_link"])
Rake::Task["avo:sym_link"].enhance(["avo:yarn_install"])
