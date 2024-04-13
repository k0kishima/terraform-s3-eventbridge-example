resource "aws_ecs_cluster" "event_handler_cluster" {
  name = "event-handler-cluster"
}

resource "aws_ecs_task_definition" "s3_event_handle_task" {
  family                   = "s3-event-handle-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_role.arn

  container_definitions = jsonencode([
    {
      name      = "s3-event-handle-task-container"
      image     = "alpine:latest"
      essential = true
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          awslogs-group         = aws_cloudwatch_log_group.eventbridge_ecs_task_target_logs.name
          awslogs-region        = "ap-northeast-1"
          awslogs-stream-prefix = "ecs"
        }
      }
      command = [
        "/bin/sh",
        "-c",
        "echo $BUCKET_NAME && echo $OBJECT_KEY && sleep 60"
      ]
    }
  ])
}
