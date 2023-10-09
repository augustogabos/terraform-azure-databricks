variable "resource_group_name" {
  description = "RG name"
  type        = string
}

variable "resource_group_location" {
  description = "RG location"
  type        = string
}

variable "cidr_vnet" {
  description = "Cidr block para VNET"
  type        = string
}

variable "cidr_subnet_PAAS" {
  description = "Cidr block para Subnet"
  type        = string
}

variable "cidr_subnet_ADBP" {
  description = "Cidr block para Subnet"
  type        = string
}

variable "cidr_subnet_ADBPP" {
  description = "Cidr block para Subnet"
  type        = string
}

variable "prefix" {
  description = "Env prefix"
  type        = string
}