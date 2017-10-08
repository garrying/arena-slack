# frozen_string_literal: true

# Compose message for block adding event along with conditions
class ArenaAddedItem
  def initialize(story, arena_url)
    @story = story
    @arena_url = arena_url
  end

  def image
    block_source =
      if @story.item.source
        @story.item.source.url
      else
        @story.item.image.original.url
      end
    block_source_link =
      if block_source.include? 'twitter.com'
        @story.item.source.url
      else
        ''
      end
    {
      text: block_source_link,
      author_name: 'Connected to ' + @story.target.title,
      author_link: @arena_url + @story.user.slug + '/' + @story.target.slug,
      title: @story.item.title,
      title_link: block_source,
      image_url: @story.item.image.original.url
    }
  end

  def channel
    {
      author_name: 'Connected to ' + @story.target.title,
      author_link: @arena_url + @story.target.user.slug + '/' + @story.target.slug,
      title: @story.item.title,
      title_link: @arena_url + @story.item.user.slug + '/' + @story.item.slug,
      color: color_setter(@story.item.status),
      fields: [
        {
          title: 'Blocks',
          value: @story.item.length,
          short: true
        },
        {
          title: 'Followers',
          value: @story.item.follower_count,
          short: true
        }
      ]
    }
  end

  def text
    {
      author_name: 'Connected to ' + @story.target.title,
      author_link: @arena_url + @story.user.slug + '/' + @story.target.slug,
      title: @story.item.title,
      title_link: @arena_url + 'block/' + @story.item.id.to_s,
      text: @story.item.content
    }
  end

  def block
    if @story.item.has_image?
      image
    elsif @story.item._class == 'Channel'
      channel
    elsif @story.item._class == 'Text'
      text
    end
  end
end
