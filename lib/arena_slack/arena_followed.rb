# frozen_string_literal: true

# Compose message for block, channel, and user following event
class ArenaFollowedItem
  def initialize(story, arena_url)
    @story = story
    @arena_url = arena_url
  end

  def block_thumb(story)
    return if story.item.title
    story.item.avatar_image.display
  end

  def block_title(story)
    if defined?(story.item.title)
      story.item.title + ', by ' + story.item.user.full_name
    else
      story.item.full_name
    end
  end

  def block_fields(story)
    if defined?(story.item.title)
      [{
        title: 'Blocks',
        value: story.item.length,
        short: true
      }, {
        title: 'Followers',
        value: story.item.follower_count,
        short: true
      }]
    else
      [{
        title: 'Channels',
        value: story.item.channel_count,
        short: true
      }, {
        title: 'Followers',
        value: story.item.follower_count,
        short: true
      }]
    end
  end

  def block
    {
      author_name: 'Followed',
      thumb_url: block_thumb(@story),
      title_link: @arena_url + @story.item.slug,
      title: block_title(@story),
      fields: block_fields(@story),
      color: color_setter(@story.item.status)
    }
  end
end
