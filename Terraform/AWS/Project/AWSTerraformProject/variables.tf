variable "access_key" {
  default = ""
}

variable "secret_key" {
  default = ""
}

variable "region" {
  default = "us-west-2"
}

variable "location" {
  description = "Respected location with the region"
  type        = "map"

  default = {
    us-east-1      = "US East (N. Virginia)"
    us-east-2      = "US East (Ohio)"
    us-west-1      = "US West (N. California)"
    us-west-2      = "US West (Oregon)"
    ap-east-1      = "Asia Pacific (Hong Kong)"
    ap-south-1     = "Asia Pacific (Mumbai)"
    ap-northeast-3 = "Asia Pacific (Osaka-Local)"
    ap-northeast-2 = "Asia Pacific (Seoul)"
    ap-southeast-1 = "Asia Pacific (Singapore)"
    ap-southeast-2 = "Asia Pacific (Sydney)"
    ap-northeast-1 = "Asia Pacific (Tokyo)"
    ca-central-1   = "Canada (Central)"
    cn-north-1     = "China (Beijing)"
    cn-northwest-1 = "China (Ningxia)"
    eu-central-1   = "EU (Frankfurt)"
    eu-west-1      = "EU (Ireland)"
    eu-west-2      = "EU (London)"
    eu-west-3      = "EU (Paris)"
    eu-north-1     = "EU (Stockholm)"
    me-south-1     = "Middle East (Bahrain)"
    sa-east-1      = "South America (São Paulo)"
    us-gov-east-1  = "AWS GovCloud (US-East)"
    us-gov-west-1  = "AWS GovCloud (US-West)"
  }
}

variable "group_name" {
  description = "name for the group"
  default     = "tl_users_group"
}

variable "policy_name" {
  description = "name for the policy"
  default     = "tl_users_policy"
}

variable "role_name" {
  description = "name for the policy"
  default     = "tl_users_role"
}

variable "username" {
  description = "Desired name for the IAM user"
  default     = "tluser"
}

variable "group_membership_name" {
  default = "tl_users_membership"
}
