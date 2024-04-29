module "cloudwatch_alarms" {
  source = "../../../modules/cloudwatch_alarms"

  cluster_name = auroracluster1
  environment  = dev
  evaluation_periods = 500
}