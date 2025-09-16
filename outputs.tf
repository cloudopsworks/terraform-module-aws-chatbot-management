##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

output "slack_channels" {
  value = {
    for key, config in aws_chatbot_slack_channel_configuration.this : key => {
      arn                = config.chat_configuration_arn
      slack_channel_name = config.slack_channel_name
      slack_team_name    = config.slack_team_name
    }
  }
}

output "teams_channels" {
  value = {
    for key, config in aws_chatbot_teams_channel_configuration.this : key => {
      arn = config.chat_configuration_arn
    }
  }
}