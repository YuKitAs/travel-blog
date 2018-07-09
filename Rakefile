task 'build' do
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

task 'package' => 'build' do
  sh 'rm -rf travel-blog.tar.gz'

  Dir.chdir('build') do
    sh 'tar czf ../travel-blog.tar.gz .'
  end
end

task 'upload' => 'package' do
  host = ENV['host']
  sh "scp travel-blog.tar.gz #{host}:travel-blog-#{Time.now.strftime('%Y%m%d%H%M%S')}.tar.gz"
end
