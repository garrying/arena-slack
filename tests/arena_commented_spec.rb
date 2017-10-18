# frozen_string_literal: true

require './lib/arena_slack/api/arena'
require './lib/arena_slack/api/slack'
require './lib/arena_slack/arena_commented'

RSpec.describe 'Arena comment event' do
  it 'returns a block title for image blocks' do
    story = double('Block')
    allow(story).to receive_message_chain('target.has_image?') { true }
    allow(story).to receive_message_chain('target.source') { 'Block Source' }
    allow(story).to receive_message_chain('target.title') { 'Block Title' }
    allow(story).to receive_message_chain('target.content') { 'Block Content' }
    comment_item = ArenaCommentedItem.new(story, @arena_url).block_title
    expect(comment_item).to eq('Block Title')
  end

  it 'returns target content for everything else' do
    story = double('Block')
    allow(story).to receive_message_chain('target.has_image?') { false }
    allow(story).to receive_message_chain('target.source') { nil }
    allow(story).to receive_message_chain('target.content') { 'Block Content' }
    comment_item = ArenaCommentedItem.new(story, @arena_url).block_title
    expect(comment_item).to eq('Block Content')
  end

  it 'returns a block thumbnail' do
    story = double('Block')
    allow(story).to receive_message_chain('target.has_image?') { true }
    allow(story).to receive_message_chain('target.image.display.url') { 'Image Link' }
    comment_item = ArenaCommentedItem.new(story, @arena_url).block_thumb
    expect(comment_item).to eq('Image Link')
  end

  it 'returns a link to commented block' do
    story = double('Block')
    allow(story).to receive_message_chain('target.has_image?') { false }
    allow(story).to receive_message_chain('target.id') { 100 }
    comment_item = ArenaCommentedItem.new(story, 'https://www.are.na/').block_link
    expect(comment_item).to eq('https://www.are.na/block/100')
  end
end
