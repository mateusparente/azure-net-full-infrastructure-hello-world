resource "kubernetes_deployment" "api" {
  metadata {
    name = "todo-api"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "todo-api"
      }
    }
    template {
      metadata {
        labels = {
          app = "todo-api"
        }
      }
      spec {
        container {
          image = "mateusparente.azurecr.io/todo-api:latest"
          name  = "todo-api"
          env {
            name  = "ASPNETCORE_ENVIRONMENT"
            value = "Development"
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