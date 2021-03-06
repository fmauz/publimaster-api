set :stage, :production

server "10.0.0.254", user: 'publimaster', roles: %w{web app}

set :application, "publimaster-api"

set :use_sudo, true
set :pty, true

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