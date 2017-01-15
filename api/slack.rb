# frozen_string_literal: true
require 'slack-notifier'

# Slack Notifier
# See https://<teamname>.slack.com/services/new/incoming-webhook
# Uses Slack Notifier, https://github.com/stevenosloan/slack-notifier

@slack_notifier = Slack::Notifier.new ENV['SLACK_POST_URL']

def slack_notifier_base(story_timestamp)
  {
    ts: story_timestamp,
    footer: 'Are.na',
    footer_icon: @arena_url + 'favicon.ico'
  }
end

def color_setter(story_status)
  if story_status == 'public'
    '#17ac10'
  elsif story_status == 'private'
    '#b60202'
  else
    '#4b3d67'
  end
end
