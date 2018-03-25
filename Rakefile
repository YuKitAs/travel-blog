task :build do
  Dir.chdir("client") do
    sh "yarn install"
    sh "yarn build"
  end

  sh "mv client/dist/* server/public"

  Dir.chdir("server") do
    sh "bundle install"
  end
end
