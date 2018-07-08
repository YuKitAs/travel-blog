task :build do
  sh 'rm -rf build'
  sh 'cp -r server build'

  Dir.chdir('client') do
    sh 'yarn install'
    sh 'yarn build'
  end

  sh 'mkdir build/public'
  sh 'mv client/dist/* build/public'

  Dir.chdir('build') do
    sh 'bundle install'
  end
end

task package: :build do
  abort 'Git repository not clean. Please commit and push.' unless system('git diff --exit-code')
end
