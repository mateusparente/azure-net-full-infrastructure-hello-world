resource "azurerm_api_management_api" "todo_api" {
  name                = local.api_name
  resource_group_name = local.infra_resource_group_name
  api_management_name = local.api_management_service_name
  revision            = "1"
  display_name        = "Todo API"
  path                = local.api_name
  protocols           = ["https"]

  subscription_required = false

  service_url = "http://${kubernetes_service.api.status.0.load_balancer.0.ingress.0.ip}"
    
  import {
    content_format = "openapi+json-link"
    content_value  = "http://${kubernetes_service.api.status.0.load_balancer.0.ingress.0.ip}/swagger/v1/swagger.json"
  }
}

resource "azurerm_api_management_product_api" "test_product" {
  api_name            = azurerm_api_management_api.todo_api.name
  product_id          = "test-product"
  resource_group_name = local.infra_resource_group_name
  api_management_name = local.api_management_service_name
}