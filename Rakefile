# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

Rails.application.load_tasks

# Avo 4 Tailwind integration: symlink plugin gem paths into tmp/avo/build-assets
# before assets:precompile runs avo:tailwindcss:build (via the Avo engine).
Rake::Task["assets:precompile"].enhance(["avo:sym_link"])
Rake::Task["avo:sym_link"].enhance(["avo:yarn_install"])
