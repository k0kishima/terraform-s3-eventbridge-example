resource "aws_cloudwatch_event_rule" "s3_put_event_rule" {
  name = "s3-put-event-rule"
  event_pattern = jsonencode({
    "source" : ["aws.s3"],
    "detail-type" : ["Object Created"],
    "detail" : {
      "bucket" : {
        "name" : [aws_s3_bucket.event_receiver_bucket.bucket]
      }
    }
  })
}

resource "aws_cloudwatch_event_target" "s3_put_event_log_target" {
  rule      = aws_cloudwatch_event_rule.s3_put_event_rule.name
  target_id = "cloud-watch-log-target"
  arn       = aws_cloudwatch_log_group.eventbridge_cloud_watch_target_logs.arn
}

resource "aws_cloudwatch_event_target" "s3_put_event_ecs_target" {
  rule      = aws_cloudwatch_event_rule.s3_put_event_rule.name
  target_id = "ecs-task-target"
  arn       = aws_ecs_cluster.event_handler_cluster.arn
  role_arn  = aws_iam_role.eventbridge_role.arn

  input_transformer {
    input_paths = {
      "bucketName" : "$.detail.bucket.name",
      "objectKey" : "$.detail.object.key"
    }
    input_template = <<TEMPLATE
{
  "containerOverrides": [
    {
      "name": "s3-event-handle-task-container",
      "environment": [
        { "name": "BUCKET_NAME", "value": <bucketName> },
        { "name": "OBJECT_KEY", "value": <objectKey> }
      ]
    }
  ]
}
TEMPLATE
  }

  ecs_target {
    task_definition_arn = aws_ecs_task_definition.s3_event_handle_task.arn
    task_count          = 1
    launch_type         = "FARGATE"

    network_configuration {
      subnets          = [aws_subnet.private.id]
      security_groups  = [aws_security_group.ecs_security_group.id]
      assign_public_ip = false
    }
  }
}
