module "alb" {
  source       = "./modules/alb"
  alb_endpoint = "${var.project_name}.${var.hosted_zone}"
  hosted_zone  = var.hosted_zone
  project_name = var.project_name
  subnets_ids  = module.vpc.public_subnet_ids
  vpc_id       = module.vpc.vpc_id
}

module "rds" {
  source                = "./modules/rds"
  db_name               = "${var.project_name}database"
  subnet_ids            = module.vpc.public_subnet_ids
  vpc_id                = module.vpc.vpc_id
  allowed_sg_connection = [module.ecs.service_sg]
}

module "asg" {
  source       = "./modules/asg"
  subnets      = module.vpc.private_subnet_ids
  cluster_name = "${var.project_name}-cluster"
  vpc_id       = module.vpc.vpc_id
  alb_sg       = module.alb.alb_sg
  task_port    = var.task_port
  project_name = var.project_name
}

module "vpc" {
  source               = "./modules/vpc"
  availability_zones   = var.availability_zones
  vpc_name             = var.project_name
  vpc_cidr             = var.vpc_cidr
  environment          = var.environment
  subnet_public_cidrs  = var.subnet_public_cidrs
  subnet_private_cidrs = var.subnet_private_cidrs
}

module "ecs" {
  source                     = "./modules/ecs"
  cluster_name               = "${var.project_name}-cluster"
  ecs_service_name           = "${var.project_name}-service"
  project_name               = var.project_name
  task_name                  = var.task_name
  task_image                 = var.container_image
  task_memory                = var.task_memory
  task_cpu                   = var.task_cpu
  task_port                  = var.task_port
  vpc_id                     = module.vpc.vpc_id
  cluster_listener           = module.alb.listener_arn
  alb_sg                     = module.alb.alb_sg
  region                     = var.region
  subnets                    = module.vpc.private_subnet_ids
  allowed_sg_connection      = [module.alb.alb_sg]
  env                        = var.environment
  db_host                    = module.rds.db_host
  db_name                    = module.rds.db_name
  sm_db_user_secret_name     = module.rds.rds_secrets_manager_username_id
  sm_db_password_secret_name = module.rds.rds_secrets_manager_password_id
  asg_arn                    = module.asg.asg_arn
  tg_arn                     = module.asg.tg_arn
}
