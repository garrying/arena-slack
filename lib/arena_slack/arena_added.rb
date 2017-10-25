# frozen_string_literal: true

# Compose message for block adding event along with conditions
class ArenaAddedItem
  def initialize(story, arena_url)
    @story = story
    @arena_url = arena_url
  end

  def block_author
    target = @story.target
    target_slug = '/' + target.slug
    block = @story.item
    if block.has_image? || block._class == 'Text'
      @story.user.slug + target_slug
    else
      target.user.slug + target_slug
    end
  end

  def block_channel_fields
    return unless @story.item._class == 'Channel'
    [{
      title: 'Blocks',
      value: @story.item.length,
      short: true
    }, {
      title: 'Followers',
      value: @story.item.follower_count,
      short: true
    }]
  end

  def block_image
    @story.item.image.original.url if @story.item.has_image?
  end

  def block_text_source
    if @story.item.source
      @story.item.source.url
    else
      @story.item.image.original.url
    end
  end

  def block_text
    if @story.item.has_image?
      @story.item.source.url if block_text_source.include? 'twitter.com'
    elsif @story.item._class == 'Text'
      @story.item.content
    end
  end

  def block_title_link_image
    if @story.item.source
      @story.item.source.url
    else
      @story.item.image.original.url
    end
  end

  def block_title_link_alt
    block = @story.item
    if block._class == 'Channel'
      block.user.slug + '/' + block.slug
    elsif block._class == 'Text'
      'block/' + block.id.to_s
    end
  end

  def block_title_link
    if @story.item.has_image?
      block_title_link_image
    else
      @arena_url + block_title_link_alt
    end
  end

  def block_status_color
    return unless @story.item._class == 'Channel'
    color_setter(@story.item.status)
  end

  def block_title
    if @story.item._class == 'Channel'
      @story.item.title + ', by ' + @story.item.user.full_name
    else
      @story.item.title
    end
  end

  def block
    {
      author_name: 'Connected to ' + @story.target.title,
      author_link: @arena_url + block_author,
      color: block_status_color,
      fields: block_channel_fields,
      image_url: block_image,
      text: block_text,
      title: block_title,
      title_link: block_title_link
    }
  end
end
