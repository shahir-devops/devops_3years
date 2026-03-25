variable "region" {
  type        = string
  description = "used to create the resources in a particular region"
  default     = ""
}
variable "cred_profile" {
  type        = string
  description = "credentials used in a particular region"
  default     = ""
}
variable "private_subnets" {
  type        =  list(string)
  description = "private subnets in vpc"
}
variable "public_subnets" {
  type        =  list(string)
  description = "public subnets in vpc"
}
variable "min_size" {
  type        = number
  description = "min number of replicas"
}

variable "max_size" {
  type        = number
  description = "max number of replicas"
}
variable "desired_size" {
  type        = number
  description = "desired number of replicas"
}
variable "instance_type" {
  type        = string
  description = "type of instance used to create"
}
variable "ami_type" {
  type        = string
  description = "ami_id to create cluster"
  default     = ""
}

variable "vpcname" {
  type        = string
  description = "vpc name"
  default     = ""
}

variable "cidr" {
  type        = string
  description = "vpc name"
  default     = ""
}