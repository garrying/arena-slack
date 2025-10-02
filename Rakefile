# frozen_string_literal: true

task default: [:check]

task :check do
  timestamp = (Time.now - 60 * 10).utc.to_i
  ruby './lib/arena_slack.rb', timestamp.to_s
end

task :console do
  sh 'irb -rubygems -I lib -r ./lib/arena_slack.rb'
end

task :test do
  sh 'rspec tests --color --format doc'
end
