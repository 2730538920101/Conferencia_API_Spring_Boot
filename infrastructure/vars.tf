variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {}
variable "Conferencia_vpc_cidr" {}
variable "public1" {}
variable "private1" {}
variable "private2" {}
variable "user_ssh" {}
variable "PATH_KEYPAIR" {}
variable "PATH_PUBLIC_KEYPAIR" {}

variable "db_name" {
  description = "Nombre de la base de datos en RDS"
  type        = string
}

variable "db_username" {
  description = "Nombre de usuario administrador de la base de datos"
  type        = string
}

variable "db_password" {
  description = "Contraseña del usuario administrador de la base de datos"
  type        = string
  sensitive   = true
}