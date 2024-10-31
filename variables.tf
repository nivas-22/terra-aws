variable "access_key" {
  description = "AWS Access Key"
  type        = string
}

variable "secret_key" {
  description = "AWS Secret Key"
  type        = string
}

variable "region" {
  description = "AWS region"
  type        = string
}
variable "instance_type" {
  description = "EC2 Instance type"
  default     = "t2.medium"
}

variable "ami" {
  description = "AMI for Ubuntu 22.04"
  default     = "ami-09b0a86a2c84101e1" # This is an example AMI ID; check for the latest in your region
}

variable "key_name" {
  description = "Key name for SSH into EC2"
  default     = "awskey"
}
