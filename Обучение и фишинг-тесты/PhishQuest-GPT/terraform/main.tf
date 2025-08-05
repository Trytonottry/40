provider "aws" { region = "us-east-1" }
resource "aws_ecs_cluster" "pq" { name = "phishquest" }
resource "aws_ecs_service" "api" {
  name            = "api"
  cluster         = aws_ecs_cluster.pq.id
  task_definition = aws_ecs_task_definition.api.arn
  desired_count   = 2
}
resource "aws_rds_instance" "db" {
  identifier = "phishquest"
  engine     = "postgres"
  instance_class = "db.t3.micro"
  allocated_storage = 20
}