resource "aws_cloudwatch_log_group" "eventbridge_cloud_watch_target_logs" {
  name = "/aws/eventbridge/target-cloud-watch"
}

resource "aws_cloudwatch_log_group" "eventbridge_ecs_task_target_logs" {
  name = "/aws/eventbridge/target-ecs-task-logs"
}
