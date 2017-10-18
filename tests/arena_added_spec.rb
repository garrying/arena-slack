# frozen_string_literal: true

require './lib/arena_slack/api/arena'
require './lib/arena_slack/api/slack'
require './lib/arena_slack/arena_added'

RSpec.describe 'Arena add event' do
  it 'returns correct block image' do
    story = double('Block')
    allow(story).to receive_message_chain('item.image.original.url') { 'Original Image Link' }
    allow(story).to receive_message_chain('item.has_image?') { true }
    add_item = ArenaAddedItem.new(story, @arena_url).block_image
    expect(add_item).to eq('Original Image Link')
  end
end