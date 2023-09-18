# create ecs autoscaling target

resource "aws_appautoscaling_target" "ecs_service_autoscaling_target" {
  max_capacity       = var.max_capacity
  min_capacity       = var.min_capacity
  resource_id        = "service/${aws_ecs_cluster.ecs_cluster.name}/${aws_ecs_service.ecs_service.name}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace  = var.service_namespace
}

# ecs autoscaling policy - memory

resource "aws_appautoscaling_policy" "autoscaling_policy_memory" {
  name               = "${var.project_name}_ECS_AutoScaling_Memory_Policy_${var.environment}"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.ecs_service_autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service_autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service_autoscaling_target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_memory_metric_type
    }
    target_value = var.memory_target_value
  }
  depends_on = [aws_appautoscaling_target.ecs_service_autoscaling_target]
}

# ecs autoscaling policy - CPU

resource "aws_appautoscaling_policy" "autoscaling_policy_cpu" {
  name               = "${var.project_name}_ECS_AutoScaling_CPU_Policy_${var.environment}"
  policy_type        = var.policy_type
  resource_id        = aws_appautoscaling_target.ecs_service_autoscaling_target.resource_id
  scalable_dimension = aws_appautoscaling_target.ecs_service_autoscaling_target.scalable_dimension
  service_namespace  = aws_appautoscaling_target.ecs_service_autoscaling_target.service_namespace
  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = var.predefined_cpu_metric_type
    }
    target_value = var.cpu_target_value
  }
  depends_on = [aws_appautoscaling_target.ecs_service_autoscaling_target]
}