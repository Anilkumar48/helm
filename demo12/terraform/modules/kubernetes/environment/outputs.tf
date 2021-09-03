locals {
    tpg_k8_namespace = kubernetes_namespace.tpg.metadata[0].name
}