terraform {
  backend "azurerm" {}
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.92.0"
    }
    aws = {
      source = "hashicorp/aws"
      version = "5.37.0"
    }
  }
}

provider "azurerm" {
  features{}
}

provider "azurerm" {
  alias = "operations"
  subscription_id = var.operations_subscription_id
  features{}
}

provider "aws" {
  region  = "eu-west-1"
}