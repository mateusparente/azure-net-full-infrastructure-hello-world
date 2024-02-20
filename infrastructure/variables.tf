variable "environment" {
    description = "The environment in which the infrastructure is deployed"
    type        = string
    default     = "dev"
}

variable "dns_prefix" {
    description = "The DNS prefix for the AKS cluster"
    type        = string
    default     = "mateusparente"
}

variable "apim_publisher_email" {
    description = "The email address of the API Management service publisher"
    type        = string
    default     = "contato@mateusparente.com.br"
}

variable "apim_publisher_name" {
    description = "The name of the API Management service publisher"
    type        = string
    default     = "Mateus Parente"
}

variable "operations_subscription_id" {
    description = "The subscription ID for the operations resources"
    type        = string
    default     = "bd5ef1a0-a662-47d6-935b-3e9da56a77d8"
}