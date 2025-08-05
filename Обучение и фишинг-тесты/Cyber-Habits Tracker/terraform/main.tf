provider "aws" { region = "us-east-1" }
resource "aws_ecs_cluster" "cht" { name = "cyber-habits" }
resource "aws_secretsmanager_secret" "slack" {
  name = "slack-bot-token"
}
resource "aws_ecs_service" "bot" {
  name            = "bot"
  cluster         = aws_ecs_cluster.cht.id
  task_definition = aws_ecs_task_definition.bot.arn
  desired_count   = 1
}