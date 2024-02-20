data "aws_route53_zone" "mateusparente" {
  name = "mateusparente.com"
}

resource "aws_route53_record" "apis" {
  zone_id = data.aws_route53_zone.mateusparente.zone_id
  name    = local.apim_custom_gateway_domain
  type    = "CNAME"
  ttl     = 300
  records = ["${azurerm_api_management.infra.name}.azure-api.net"]
  depends_on = [
    azurerm_api_management_custom_domain.sandbox
  ]
}

resource "aws_route53_record" "developer_portal" {
  zone_id = data.aws_route53_zone.mateusparente.zone_id
  name    = local.apim_custom_developer_domain
  type    = "CNAME"
  ttl     = 300
  records = ["${azurerm_api_management.infra.name}.developer.azure-api.net"]
  depends_on = [
    azurerm_api_management_custom_domain.sandbox
  ]
}