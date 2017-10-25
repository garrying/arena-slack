# frozen_string_literal: true

task default: [:check]

task :check do
  ruby './lib/arena_slack.rb'
end

task :console do
  sh 'irb -rubygems -I lib -r ./lib/arena_slack.rb'
end

task :test do
  sh 'rspec tests --color --format doc'
end
