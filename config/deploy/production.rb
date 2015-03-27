server "201.76.167.41", user: 'webserver', roles: %w{web app}

set :application, "publimaster-api"

set :scm, :git
set :repo_url, "git@github.com:fmauz/publimaster-api.git"

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 5