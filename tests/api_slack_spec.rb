# frozen_string_literal: true

require './lib/arena_slack/api/arena'
require './lib/arena_slack/api/slack'

RSpec.describe 'Slack API' do
  it 'returns correct timestamp' do
    @arena_url = 'https://www.are.na/'
    notifier_base = slack_notifier_base(1509322660)
    arena_footer = {
      :footer => 'Are.na',
      :footer_icon => 'https://www.are.na/favicon.ico',
      :ts => 1509322660
    }
    expect(notifier_base).to eq(arena_footer)
  end

  it 'returns purple for private channels' do
    color = color_setter('private')
    expect(color).to eq('#b60202')
  end

  it 'returns grey for everything else' do
    color = color_setter(nil)
    expect(color).to eq('#4b3d67')
  end
end