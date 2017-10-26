# frozen_string_literal: true

# Compose message for block, channel, and user following event
class ArenaFollowedItem
  def initialize(story, arena_url)
    @story = story
    @arena_url = arena_url
  end

  def block_thumb
    return if defined?(@story.title)
    @story.avatar_image.display
  end

  def block_title
    if defined?(@story.title)
      @story.title + ', by ' + @story.user.full_name
    else
      @story.full_name
    end
  end

  def block_fields_block_type
    if defined?(@story.title)
      'Blocks'
    else
      'Channels'
    end
  end

  def block_fields_block_count
    if defined?(@story.title)
      @story.length
    else
      @story.follower_count
    end
  end

  def block_fields
    followers_count = {
      title: 'Followers',
      value: @story.follower_count,
      short: true
    }

    [{
      title: block_fields_block_type,
      value: block_fields_block_count,
      short: true
    }, followers_count]
  end

  def block_color
    color_setter(@story.status) if defined?(@story.title)
  end

  def block_title_link
    if @story._class == 'Channel'
      @arena_url + @story.user.slug + '/' + @story.slug
    else
      @arena_url + @story.slug
    end
  end

  def block
    {
      author_name: 'Followed',
      thumb_url: block_thumb,
      title_link: block_title_link,
      title: block_title,
      fields: block_fields,
      color: block_color
    }
  end
end
