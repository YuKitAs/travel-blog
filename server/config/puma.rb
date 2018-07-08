# For more details https://github.com/puma/puma/blob/master/examples/config.rb

# Common configurations
threads_count = ENV.fetch('RAILS_MAX_THREADS'){5}
threads(threads_count, threads_count)

# Environment specified configurations
rails_env = ENV.fetch('RAILS_ENV'){'development'}
environment(rails_env)

if rails_env == 'production'
  ssl_bind('0.0.0.0', '3000',
    key: '/etc/letsencrypt/live/captain-bonbon.de/privkey.pem',
    cert: '/etc/letsencrypt/live/captain-bonbon.de/fullchain.pem')
  daemonize
else
  bind('tcp://0.0.0.0:3000')
end

# Allow puma to be restarted by `rails restart` command.
plugin(:tmp_restart)
