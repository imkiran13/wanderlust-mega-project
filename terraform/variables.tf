variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "ap-south-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  default     = "ami-0dee22c13ea7a9a67"
}

variable "instance_type" {
  description = "Instance type for the EC2 instance"
  default     = "t2.large"
}
