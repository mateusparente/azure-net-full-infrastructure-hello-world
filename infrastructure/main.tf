locals {
    location            = "UK South"
    name_prefix         = "${var.environment}-infrastructure"
    domain_name         = "sandbox"
    unique_azure_domain = "${var.environment}-${local.domain_name}-mateusparente"
    short_unique_azure_domain = "${var.environment}-${local.domain_name}-mparente"
    
    resource_group_name     = "${local.name_prefix}-rg"
    vnet_name               = "${local.name_prefix}-vnet"
    aks_cluster_name        = "${local.name_prefix}-aks"
    aks_default_pool_name   = "${local.name_prefix}-default-np"
    log_workspace_name      = "${local.name_prefix}-log"
    api_management_service_name = "${local.unique_azure_domain}-apim"
    api_management_service_public_ip_name = "${local.api_management_service_name}-pip"
    security_group_name     = "${local.name_prefix}-nsg"
    key_vault_name          = "${local.short_unique_azure_domain}-kv"
    
    operations_vault_name   = "mng-mateusparente-kv"
    operations_rg_name      = "management-rg"

    apim_prefix = var.environment == "dev" ? "" : "${var.environment}-"
    apim_custom_gateway_domain = "${local.apim_prefix}apis.mateusparente.com"
    apim_custom_developer_domain = "${local.apim_prefix}developers.mateusparente.com"

    tags = {
        environment = var.environment
    }
}

resource "azurerm_resource_group" "infrastructure" {
    name     = local.resource_group_name
    location = local.location
    tags     = local.tags
}

data "azurerm_client_config" "current" {}