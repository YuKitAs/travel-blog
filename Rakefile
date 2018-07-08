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
    sh 'rm -rf spec'
    sh 'rm -rf .gitignore'
    sh 'rm -rf .rspec'
    sh 'rm -rf .rubocop.yml'
    sh 'rm -rf log/*'
    sh 'rm -rf tmp/*'
  end
end

task :package do
  if File.exist?('build') && File.exist?('travel-blog.tar.gz') && File.ctime('build') < File.ctime('travel-blog.tar.gz')
    abort('Package is up-to-date')
  end

  Dir.chdir('build') do
    sh 'tar czf ../travel-blog.tar.gz .'
  end
end
