# frozen_string_literal: true

task default: [:check]

task :check do
  ruby 'main.rb'
end

task :console do
  sh 'irb -rubygems -I lib -r ./main.rb'
end
