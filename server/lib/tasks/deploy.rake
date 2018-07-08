task :setup do
  sh 'bundle install --without test development'
end

task :start do
  sh 'rails server -e production -p 443'
end
