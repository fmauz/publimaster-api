server "201.76.167.41", user: 'webserver', roles: %w{web app}

set :application, "publimaster-api"

set :scm, :git
set :repo_url, "git@github.com:fmauz/publimaster-api.git"

set :linked_files, %w{config/database.yml config/secrets.yml}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public}

set :keep_releases, 5

namespace :deploy do
  task :finishing do
    on roles(:web), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end
end

namespace :logs do
  desc "tail rails logs" 
  task :tail do
    on roles(:app) do
      execute "tail -f /var/log/apache2/error.log"
    end
  end
end