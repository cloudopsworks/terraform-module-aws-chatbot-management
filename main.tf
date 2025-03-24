##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

data "aws_chatbot_slack_workspace" "this" {
  for_each = {
    for key, config in var.configs : key => config
    if try(config.slack, null) != null
  }
  slack_team_name = each.value.slack.workspace_name
}

resource "aws_iam_role" "this" {
  for_each = {
    for key, config in var.configs : key => config
  }
  name               = format("%s-%s-chatbot-role", each.key, local.system_name)
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = [
      "sts:AssumeRole"
    ]
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "chatbot.amazonaws.com"
      ]
    }
  }
}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "CloudWatchGet"
    effect = "Allow"
    actions = [
      "cloudwatch:Describe*",
      "cloudwatch:Get*",
      "cloudwatch:List*"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_role_policy" "this" {
  for_each = {
    for key, config in var.configs : key => config
  }
  role   = aws_iam_role.this[each.key].id
  name   = "chatbot-policy"
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy_attachment" "this" {
  for_each = {
    for key, config in var.configs : key => config
  }
  role       = aws_iam_role.this[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/AWSResourceExplorerReadOnlyAccess"
}

resource "aws_chatbot_slack_channel_configuration" "this" {
  for_each = {
    for key, config in var.configs : key => config
    if try(config.slack, null) != null
  }
  configuration_name          = try(each.value.name, "") != "" ? each.value.name : format("%s-%s-slack-chatbot", try(each.value.name_prefix, each.key), local.system_name_short)
  iam_role_arn                = aws_iam_role.this[each.key].arn
  slack_channel_id            = each.value.slack.channel_id
  slack_team_id               = data.aws_chatbot_slack_workspace.this[each.key].slack_team_id
  guardrail_policy_arns       = try(each.value.guardrail_policy_arns, null)
  logging_level               = try(each.value.logging_level, null)
  sns_topic_arns              = try(each.value.sns_topic_arns, null)
  user_authorization_required = try(each.value.user_authorization_required, null)
  tags                        = local.all_tags
}

resource "aws_chatbot_teams_channel_configuration" "this" {
  for_each = {
    for key, config in var.configs : key => config
    if try(config.teams, null) != null
  }
  configuration_name          = try(each.value.name, "") != "" ? each.value.name : format("%s-%s-teams-chatbot", try(each.value.name_prefix, each.key), local.system_name_short)
  channel_id                  = each.value.teams.channel_id
  iam_role_arn                = aws_iam_role.this[each.key].arn
  team_id                     = each.value.teams.team_id
  tenant_id                   = each.value.teams.tenant_id
  team_name                   = each.value.teams.team_name
  guardrail_policy_arns       = try(each.value.guardrail_policy_arns, null)
  logging_level               = try(each.value.logging_level, null)
  sns_topic_arns              = try(each.value.sns_topic_arns, null)
  user_authorization_required = try(each.value.user_authorization_required, null)
  tags                        = local.all_tags
}


