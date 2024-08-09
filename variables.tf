variable "bucket" {
  type    = string
  default = "terraform-bucket"
}

variable "region" {
  type    = string
  default = "eu-north-1"
}

variable "key" {
  type    = string
  default = "vpn/terraform.tfstate"
}


variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

variable "project" {
  type    = string
  default = "rds-with-vpn"
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = map(string)
  default = {
    "sb-private-1" = "10.0.1.0/24"
    "sb-private-2" = "10.0.2.0/24"
    "sb-private-3" = "10.0.3.0/24"
  }
}


variable "database" {
  description = "Database configs for the RDS db"
  type        = map(string)
  default = {
    name                       = "rds-postgres-db"
    port                       = 5432
    allocated_storage          = 20
    max_allocated_storage      = 500
    instance_class             = "db.t3.micro"
    storage_type               = "gp2"
    multi_az                   = false
    publicly_accessible        = false
    engine_version             = "14"
    backup_retention_period    = 30
    family                     = "postgres14"
    log_min_duration_statement = "0"
    log_duration               = "1"
    rds_log_retention_period   = "1440"
  }
}


variable "vpn_certificate_arn" {
  type    = string
  default = "arn:aws:acm:eu-north-1:261939820782:certificate/671be842-4294-44d9-8ba9-e08927a43d1d"
}

variable "vpn_client_cidr_block" {
  type    = string
  default = "10.0.4.0/22"
}



