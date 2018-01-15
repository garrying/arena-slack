# frozen_string_literal: true

require './lib/arena_slack/api/arena'
require './lib/arena_slack/api/slack'
require './lib/arena_slack/arena_followed'

RSpec.describe 'Arena following event' do
  it 'returns correct channel field lables' do
    story = double('Channel', title: 'Channel Title')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_type
    expect(follow_item).to eq('Blocks')
  end

  it 'returns channel label for users' do
    story = double('Channel')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_type
    expect(follow_item).to eq('Channels')
  end

  it "returns user's name" do
    story = double('User', full_name: 'Firstname Lastname')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_title
    expect(follow_item).to eq('Firstname Lastname')
  end

  it 'returns channel with username' do
    story = double('Channel', title: 'Channel Name')
    allow(story).to receive_message_chain('user.full_name') { 'Username' }
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_title
    expect(follow_item).to eq('Channel Name, by Username')
  end

  it "returns user's avatar" do
    story = double('User')
    allow(story).to receive_message_chain('avatar_image.display') { 'https://www.avatar.com/avatar.jpg' }
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_thumb
    expect(follow_item).to eq('https://www.avatar.com/avatar.jpg')
  end

  it 'returns public channel status color' do
    story = double('Channel', status: 'public', title: 'Channel Title')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_color
    expect(follow_item).to eq('#17ac10')
  end

  it 'returns channel field values' do
    story = double('Channel', length: '100', title: 'Channel Title')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_count
    expect(follow_item).to eq('100')
  end

  it 'returns user field channel count' do
    story = double('User', _class: 'User', follower_count: '20', channel_count: '10')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_count
    expect(follow_item).to eq('10')
  end

  it 'returns user field follower count' do
    story = double('User', _class: 'Other', follower_count: '20', channel_count: '10')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_count
    expect(follow_item).to eq('20')
  end

  it 'returns correct channel link' do
    story = double('Channel', _class: 'Channel', slug: 'block-title')
    allow(story).to receive_message_chain('user.slug') { 'author-slug' }
    add_item = ArenaFollowedItem.new(story, 'https://www.are.na/').block_title_link
    expect(add_item).to eq('https://www.are.na/author-slug/block-title')
  end

  it 'returns correct user link' do
    story = double('User', _class: 'User', slug: 'username-slug')
    add_item = ArenaFollowedItem.new(story, 'https://www.are.na/').block_title_link
    expect(add_item).to eq('https://www.are.na/username-slug')
  end
end
