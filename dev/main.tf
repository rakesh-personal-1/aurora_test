module "cloudwatch_alarms" {
  source = "../modules/cloudwatchalarms"

  rds_set_cluster_identifier = var.cluster_identifier
  acu_period                 = var.acu_period

}