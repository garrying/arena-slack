# Are.na Slack Feed

Posting your [Are.na](https://www.are.na/) feed in a Slack channel via webhooks.

![Preview](https://i.imgur.com/rzEP7jY.png)

## Setup

1. Get your Slack incoming post URL (`SLACK_POST_URL`) at `https://<YOURSLACKTEAMNAME>.slack.com/services/new/incoming-webhook`

2. Register a new application on Are.na at [dev.are.na](https://dev.are.na/), and get the `Personal Access Token` (`ARENA_ACCESS_TOKEN`)

3. Add `ARENA_ACCESS_TOKEN` and `SLACK_POST_URL` environment variables

4. Run `rake` every 10 minutes

## Reference

Uses [Are.na's Ruby interface](https://github.com/aredotna/arena-rb/) and [Slack Notifier](https://github.com/stevenosloan/slack-notifier).

## License

[The MIT License (MIT)](https://github.com/garrying/arena-slack/blob/master/LICENSE)
