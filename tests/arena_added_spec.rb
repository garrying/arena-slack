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

  it 'returns correct block image url' do
    story = double('Block')
    allow(story).to receive_message_chain('item.source') { false }
    allow(story).to receive_message_chain('item.image.original.url') { 'Original Source Link' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_text_source
    expect(add_item).to eq('Original Source Link')
  end

  it 'returns correct block channel link' do
    story = double('Block')
    allow(story).to receive_message_chain('item._class') { 'Channel' }
    allow(story).to receive_message_chain('item.user.slug') { 'userslug' }
    allow(story).to receive_message_chain('item.slug') { 'channelslug' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title_link_alt
    expect(add_item).to eq('userslug/channelslug')
  end

  it 'returns correct text block link' do
    story = double('Block')
    allow(story).to receive_message_chain('item._class') { 'Text' }
    allow(story).to receive_message_chain('item.id') { '1234' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title_link_alt
    expect(add_item).to eq('block/1234')
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

  it 'returns plain block title' do
    story = double('Block')
    allow(story).to receive_message_chain('item._class') { 'Block' }
    allow(story).to receive_message_chain('item.title') { 'Block Title' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title
    expect(add_item).to eq('Block Title')
  end

  it 'returns block source link' do
    story = double('Block')
    allow(story).to receive_message_chain('item.source') { true }
    allow(story).to receive_message_chain('item.source.url') { 'Source Link' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title_link_image
    expect(add_item).to eq('Source Link')
  end

  it 'returns block original source link' do
    story = double('Block')
    allow(story).to receive_message_chain('item.source') { false }
    allow(story).to receive_message_chain('item.image.original.url') { 'Original Source Link' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title_link_image
    expect(add_item).to eq('Original Source Link')
  end

  it 'returns block link if tweet' do
    story = double('Block')
    allow(story).to receive_message_chain('item.has_image?') { true }
    allow(story).to receive_message_chain('item.source.url') { 'https://twitter.com/handle' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_text
    expect(add_item).to eq('https://twitter.com/handle')
  end

  it 'returns block link if tweet' do
    story = double('Block')
    allow(story).to receive_message_chain('item.has_image?') { false }
    allow(story).to receive_message_chain('item._class') { 'Text' }
    allow(story).to receive_message_chain('item.content') { 'Block Text Content' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_text
    expect(add_item).to eq('Block Text Content')
  end

  it 'returns block title link' do
    story = double('Block')
    allow(story).to receive_message_chain('item.has_image?') { false }
    allow(story).to receive_message_chain('item.image.original.url') { 'Original Source Link' }
    allow(story).to receive_message_chain('item._class') { 'Channel' }
    allow(story).to receive_message_chain('item.user.slug') { 'userslug' }
    allow(story).to receive_message_chain('item.slug') { 'channelslug' }
    add_item = ArenaAddedItem.new(story, 'https://www.are.na/').block_title_link
    expect(add_item).to eq('https://www.are.na/userslug/channelslug')
  end

  it 'returns block title image link' do
    story = double('Block')
    allow(story).to receive_message_chain('item.has_image?') { true }
    allow(story).to receive_message_chain('item.source') { true }
    allow(story).to receive_message_chain('item.source.url') { 'Source Link' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_title_link
    expect(add_item).to eq('Source Link')
  end

  it 'returns text block author' do
    story = double('Block')
    allow(story).to receive_message_chain('target') { true }
    allow(story).to receive_message_chain('target.slug') { 'target-slug' }
    allow(story).to receive_message_chain('item.has_image?') { true }
    allow(story).to receive_message_chain('item._class') { 'Text' }
    allow(story).to receive_message_chain('user.slug') { 'author-slug' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_author
    expect(add_item).to eq('author-slug/target-slug')
  end

  it 'returns image block author' do
    story = double('Block')
    allow(story).to receive_message_chain('target') { true }
    allow(story).to receive_message_chain('target.slug') { 'target-slug' }
    allow(story).to receive_message_chain('item.has_image?') { false }
    allow(story).to receive_message_chain('item._class') { 'Block' }
    allow(story).to receive_message_chain('target.user.slug') { 'target-author-slug' }
    add_item = ArenaAddedItem.new(story, @arena_url).block_author
    expect(add_item).to eq('target-author-slug/target-slug')
  end

  it 'returns channel fields' do
    story = double('Channel')
    allow(story).to receive_message_chain('item._class') { 'Channel' }
    allow(story).to receive_message_chain('item.length') { 100 }
    allow(story).to receive_message_chain('item.follower_count') { 500 }
    add_item = ArenaAddedItem.new(story, @arena_url).block_channel_fields
    array = [{
      title: 'Blocks',
      value: 100,
      short: true
    }, {
      title: 'Followers',
      value: 500,
      short: true
    }]
    expect(add_item).to eq(array)
  end
end