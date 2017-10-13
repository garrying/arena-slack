require './lib/arena_slack/api/arena'
require './lib/arena_slack/api/slack'
require './lib/arena_slack/arena_followed'

RSpec.describe "Arena feed following event" do
  it "returns correct channel field lables" do
    story = double('Channel', :title => 'Channel Title')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_type
    expect(follow_item).to eq('Blocks')
  end

  it "returns user's name" do
    story = double('User', :full_name => 'Firstname Lastname')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_title
    expect(follow_item).to eq('Firstname Lastname')
  end

  it "returns public channel status color" do
    story = double('Channel', :status => 'public', :title => 'Channel Title')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_color
    expect(follow_item).to eq('#17ac10')
  end

  it "returns channel field values" do
    story = double('Channel', :length => '100', :title => 'Channel Title')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_count
    expect(follow_item).to eq('100')
  end

  it "returns user field values" do
    story = double('User', :follower_count => '20')
    follow_item = ArenaFollowedItem.new(story, @arena_url).block_fields_block_count
    expect(follow_item).to eq('20')
  end
end