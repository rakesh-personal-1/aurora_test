
###ALARM CPU###

resource "aws_cloudwatch_metric_alarm" "aurora_cpu" {

  alarm_name          = "ACUtilizationAlarm-${var.rds_set_cluster_identifier}"
  alarm_description   = "Aurora CPU alarm for 1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 15
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = var.acu_period
  statistic           = "Average"
  threshold           = 90
  dimensions = {
    DBInstanceIdentifier = "auroracluster2"
  }

}
