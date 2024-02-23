resource "kubernetes_deployment" "api" {
  metadata {
    name = local.api_name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = local.api_name
      }
    }
    template {
      metadata {
        labels = {
          app = local.api_name
        }
      }
      spec {
        container {
          image = "mateusparente.azurecr.io/${local.api_name}:${var.release_number}"
          name  = local.api_name
          env {
            name  = "ASPNETCORE_ENVIRONMENT"
            value = var.environment == "dev" ? "Development" : "Production"
          }
          port {
            container_port = 8080
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "api" {
  timeouts {
    create = "5m"
  }
  metadata {
    name = "${kubernetes_deployment.api.spec.0.template.0.metadata.0.labels.app}-service"
    annotations = {
      "service.beta.kubernetes.io/azure-load-balancer-internal" = "true"
    }
  }
  spec {
    selector = {
      app = kubernetes_deployment.api.spec.0.template.0.metadata.0.labels.app
    }
    port {
      port        = 80
      target_port = 8080
    }
    type = "LoadBalancer"
  }
}