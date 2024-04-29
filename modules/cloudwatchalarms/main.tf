
###ALARM CPU###

resource "aws_cloudwatch_metric_alarm" "aurora_cpu" {

  alarm_name          = "CPUUtilizationAlarm-1"
  alarm_description   = "Aurora CPU alarm for 1"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 15
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 90
  dimensions = {
    DBInstanceIdentifier = "auroracluster2"
  }

}
