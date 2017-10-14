# frozen_string_literal: true

# Compose message for block commenting event
class ArenaCommentedItem
  def initialize(story, arena_url)
    @story = story
    @arena_url = arena_url
  end

  def block_title
    if @story.target.has_image? && @story.target.source
      @story.target.title
    elsif @story.target.has_image?
      @story.target.title
    else
      @story.target.content
    end
  end

  def block_thumb
    return unless @story.target.has_image?
    @story.target.image.display.url
  end

  def block_link
    if @story.target.has_image? && @story.target.source
      @story.target.source.url
    else
      @arena_url + 'block/' + @story.target.id.to_s
    end
  end

  def block
    {
      author_name: 'Commented',
      image_url: block_thumb,
      title_link: block_link,
      title: block_title,
      text: @story.item.body
    }
  end
end
