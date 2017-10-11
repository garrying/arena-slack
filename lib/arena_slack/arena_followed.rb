# frozen_string_literal: true

# Compose message for block, channel, and user following event
class ArenaFollowedItem
  def initialize(story, arena_url)
    @story = story
    @arena_url = arena_url
  end

  def block_thumb
    return if @story.item.title
    @story.item.avatar_image.display
  end

  def block_title
    if defined?(@story.item.title)
      @story.item.title + ', by ' + @story.item.user.full_name
    else
      @story.item.full_name
    end
  end

  def block_fields_block_type
    if defined?(@story.item.title)
      'Blocks'
    else
      'Channels'
    end
  end

  def block_fields_block_count
    if defined?(@story.item.title)
      @story.item.length
    else
      @story.item.follower_count
    end
  end

  def block_fields
    followers_count = {
      title: 'Followers',
      value: @story.item.follower_count,
      short: true
    }

    [{
      title: block_fields_block_type,
      value: block_fields_block_count,
      short: true
    }, followers_count]
  end

  def block
    {
      author_name: 'Followed',
      thumb_url: block_thumb,
      title_link: @arena_url + @story.item.slug,
      title: block_title,
      fields: block_fields,
      color: color_setter(@story.item.status)
    }
  end
end
