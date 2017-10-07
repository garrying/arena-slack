# frozen_string_literal: true

require_relative 'arena_slack/arena'
require_relative 'arena_slack/slack'

@arena_feed.stories.reverse_each do |story|
  story_ts = DateTime.rfc3339(story.created_at).to_time.to_i
  next unless story_ts > (Time.now - 60 * 10).utc.to_time.to_i
  if story.action == 'added'
    if story.item.has_image?
      block_source =
        if story.item.source
          story.item.source.url
        else
          story.item.image.original.url
        end
      block_source_link =
        if block_source.include? 'twitter.com'
          story.item.source.url
        else
          ''
        end
      slack_note_extend = {
        text: block_source_link,
        author_name: 'Connected to ' + story.target.title,
        author_link: @arena_url + story.user.slug + '/' + story.target.slug,
        title: story.item.title,
        title_link: block_source,
        image_url: story.item.image.original.url
      }
    elsif story.item._class == 'Channel'
      slack_note_extend = {
        author_name: 'Connected to ' + story.target.title,
        author_link: @arena_url + story.target.user.slug + '/' + story.target.slug,
        title: story.item.title,
        title_link: @arena_url + story.item.user.slug + '/' + story.item.slug,
        color: color_setter(story.item.status),
        fields: [
          {
            title: 'Blocks',
            value: story.item.length,
            short: true
          },
          {
            title: 'Followers',
            value: story.item.follower_count,
            short: true
          }
        ]
      }
    elsif story.item._class == 'Text'
      slack_note_extend = {
        author_name: 'Connected to ' + story.target.title,
        author_link: @arena_url + story.user.slug + '/' + story.target.slug,
        title: story.item.title,
        title_link: block_source,
        text: story.item.content
      }
    end
  elsif story.action == 'followed'
    if defined?(story.item.title)
      note_title = story.item.title + ', by ' + story.item.user.full_name
      note_link = @arena_url + story.item.slug
      note_status = color_setter(story.item.status)
      note_fields = [
        {
          title: 'Blocks',
          value: story.item.length,
          short: true
        },
        {
          title: 'Followers',
          value: story.item.follower_count,
          short: true
        }
      ]
    else
      note_title = story.item.full_name
      note_link = @arena_url + story.item.slug
      note_thumb = story.item.avatar_image.display
      note_fields = [
        {
          title: 'Channels',
          value: story.item.channel_count,
          short: true
        },
        {
          title: 'Followers',
          value: story.item.follower_count,
          short: true
        }
      ]
    end
    slack_note_extend = {
      author_name: 'Followed',
      thumb_url: note_thumb,
      title_link: note_link,
      title: note_title,
      fields: note_fields,
      color: note_status
    }
  elsif story.action == 'commented on'
    if story.target.has_image? && story.target.source
      note_thumb = story.target.image.display.url
      note_title = story.target.title
      note_link = story.target.source.url
    elsif story.target.has_image?
      note_link = @arena_url + 'block/' + story.target.id.to_s
      note_title = story.target.title
      note_thumb = story.target.image.display.url
    else
      note_link = @arena_url + 'block/' + story.target.id.to_s
      note_title = story.target.content
    end
    slack_note_extend = {
      author_name: 'Commented',
      image_url: note_thumb,
      title_link: note_link,
      title: note_title,
      text: story.item.body
    }
  end

  slack_attachment = slack_notifier_base(story_ts).merge(slack_note_extend)
  slack_avatar = story.user.avatar_image.display

  @slack_notifier = Slack::Notifier.new ENV['SLACK_POST_URL'], username: story.user.full_name
  @slack_notifier.post icon_url: slack_avatar, attachments: [slack_attachment]
end
