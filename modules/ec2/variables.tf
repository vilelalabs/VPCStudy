variable "sg-public" {}
variable "subnet-public" {}
variable "subnet-private" {}
variable "igw" {}


variable "ec2_ami_id" {
  # AMI Linux 2023 Free Tier
  default = "ami-07ffe1e45b5441531"
}

variable "ec2_instance_type" {
  # nano -> 1 CPU 500Mb RAM
  default = "t2.nano"
}

variable "key_name" {
  default     = "Iac-primeira"
  type        = string
  description = "The name of the key pair that will be used to access the EC2 instance"
}
