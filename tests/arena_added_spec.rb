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

  it 'returns correct block source link' do
    story = double('Block')
    allow(story).to receive_message_chain('item.source') { true }
    allow(story).to receive_message_chain('item.source.url') { 'Source Link' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_text_source
    expect(add_item).to eq('Source Link')
  end

  it 'returns correct block channel link' do
    story = double('Block')
    allow(story).to receive_message_chain('item._class') { 'Channel' }
    allow(story).to receive_message_chain('item.user.slug') { 'userslug' }
    allow(story).to receive_message_chain('item.slug') { 'channelslug' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title_link_alt
    expect(add_item).to eq('userslug/channelslug')
  end

  it 'returns correct channel status color' do
    story = double('Block')
    allow(story).to receive_message_chain('item._class') { 'Channel' }
    allow(story).to receive_message_chain('item.status') { 'public' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_status_color
    expect(add_item).to eq('#17ac10')
  end

  it 'returns correct block title' do
    story = double('Block')
    allow(story).to receive_message_chain('item._class') { 'Channel' }
    allow(story).to receive_message_chain('item.title') { 'Channel Title' }
    allow(story).to receive_message_chain('item.user.full_name') { 'Author Name' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title
    expect(add_item).to eq('Channel Title, by Author Name')
  end
end