task :build do
  sh "rm -rf server/public/static server/public/index.html"

  Dir.chdir("client") do
    sh "yarn install"
    sh "yarn build"
  end

  sh "mv client/dist/* server/public"

  Dir.chdir("server") do
    sh "bundle install"
  end
end
