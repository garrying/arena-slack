# frozen_string_literal: true

# Arena API
# See https://dev.are.na/oauth/applications
# A Personal Access Token is required
require 'arena'

Arena.configure do |config|
  # Put into ENV variable
  config.access_token = ENV['ARENA_ACCESS_TOKEN']
end

@arena_feed = Arena.feed
@arena_url = 'https://www.are.na/'
