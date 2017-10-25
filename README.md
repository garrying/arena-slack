# Are.na Slack Feed
[![Build Status](https://travis-ci.org/garrying/arena-slack.svg?branch=master)](https://travis-ci.org/garrying/arena-slack)

Posting your [Are.na](https://www.are.na/) feed in a Slack channel via webhooks.

![Preview](https://i.imgur.com/rzEP7jY.png)

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Setup

1. Deploy to Heroku, either through the Deploy button or [manually](https://devcenter.heroku.com/articles/getting-started-with-ruby)

2. Get your Slack incoming post URL at `https://<YOURSLACKTEAMNAME>.slack.com/services/new/incoming-webhook`

3. Register a new application on Are.na at [dev.are.na](https://dev.are.na/), and get the `Personal Access Token`

4. In Heroku's app settings, add `ARENA_ACCESS_TOKEN` and `SLACK_POST_URL` to the _Config Variables_

5. Add _Heroku Scheduler_ to the app and `rake` every 10 minutes

## Reference

Uses [Are.na's Ruby interface](https://github.com/aredotna/arena-rb/) and [Slack Notifier](https://github.com/stevenosloan/slack-notifier).

## License

[The MIT License (MIT)](https://github.com/garrying/arena-slack/blob/master/LICENSE)
