require 'version_bumper'

desc "Build Project"
task :build => :coffee do
  
end

desc "Coffeescript compile"
task :coffee do
  sh 'coffee -c -o lib/ src/'
end

desc "Run chat example"
task :chat => :build do
  sh 'node examples/chat/app.js'
end
