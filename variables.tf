variable "region" {
  default     = "us-east-1"
  type        = string
  description = "Region where infrastructure will be deployed"
}
variable "access-key" {
  type        = string
  description = "value of AWS_ACCESS_KEY_ID"
}
variable "secret-key" {
  type        = string
  description = "value of AWS_SECRET_ACCESS_KEY"
}

variable "key_name" {
  type        = string
  description = "The name of the key pair that will be used to access the EC2 instance"
}


variable "my_ip_address" {
  type        = string
  description = "The IP address that will be allowed to access the EC2 instance through SSH"
}
