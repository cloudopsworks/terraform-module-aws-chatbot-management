##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

## Variable Documentation - YAML format
# configs:
#   <config-id>:
#     name: <config-name> # (Optional) The name of the configuration set
#     name_prefix: <config-name-prefix> # (Optional) The name prefix of the configuration set
#     guardrail_policy_arn: <guardrail-policy-arn> # (Optional) The ARN of the AWS Config rule to monitor the configuration set
#     logging_level: ERROR | INFO | NONE # (Optional) The logging level of the configuration set
#     sns_topic_arns: [<sns-topic-arn>, ...] # (Optional) The list of SNS topic ARNs to which the configuration set will publish events.
#     user_authorization_required: true | false # (Optional) Indicates whether the configuration set requires user authorization for the configuration set to receive events
#     slack: # (Optional) The Slack configuration object if the destination is a Slack Channel
#       workspace_name: "my-slack-workspace"
#       channel_id: "my-slack-channel-id"
#     teams: # (Optional) The Microsoft Teams configuration object if the destination is a Microsoft Teams Channel
#       channel_id: "my-teams-channel-id"
#       team_id: "my-teams-team-id"
#       team_name: "my-teams-team-name" # (Optional)
#       tenant_id: "my-teams-tenant-id"
#
variable "configs" {
  description = "Configuration object describing all the Amazon Q Chatbot configurations"
  type        = any
  default     = {}
}