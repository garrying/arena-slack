# frozen_string_literal: true

require_relative 'arena_slack/arena'
require_relative 'arena_slack/slack'
require_relative 'arena_slack/arena_added'
require_relative 'arena_slack/arena_followed'
require_relative 'arena_slack/arena_commented'

@arena_feed.stories.reverse_each do |story|
  story_ts = DateTime.rfc3339(story.created_at).to_time.to_i
  next unless story_ts > (Time.now - 60 * 10).utc.to_time.to_i
  if story.action == 'added'
    slack_note_extend = ArenaAddedItem.new(story, @arena_url).block
  elsif story.action == 'followed'
    slack_note_extend = ArenaFollowedItem.new(story, @arena_url).block
  elsif story.action == 'commented on'
    slack_note_extend = ArenaCommentedItem.new(story, @arena_url).block
  end

  slack_attachment = slack_notifier_base(story_ts).merge(slack_note_extend)
  slack_avatar = story.user.avatar_image.display

  @slack_notifier = Slack::Notifier.new ENV['SLACK_POST_URL'], username: story.user.full_name
  @slack_notifier.post icon_url: slack_avatar, attachments: [slack_attachment]
end
