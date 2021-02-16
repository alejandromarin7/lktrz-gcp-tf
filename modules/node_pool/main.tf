resource "google_container_node_pool" "worker_nodes" {
  name               = var.name
  node_locations     = var.node_locations
  location           = var.location
  project            = var.project
  cluster            = var.cluster_name
  initial_node_count = var.initial_node_count
  max_pods_per_node  = var.max_pods_per_node
  autoscaling {
    max_node_count = var.max_worker_nodes
    min_node_count = var.min_worker_nodes
  }
  upgrade_settings {
    max_surge       = var.max_surge
    max_unavailable = var.max_unavailable
  }
  node_config {
    oauth_scopes    = var.oauth_scopes
    image_type      = var.image_type
    machine_type    = var.machine_type
    disk_type       = var.disk_type
    disk_size_gb    = var.disk_size
    service_account = var.service_account
    labels          = var.node_pool_labels
    tags            = var.node_pool_network_tags
    taint           = var.taints
  }

  management {
    auto_repair  = var.auto_repair
    auto_upgrade = var.auto_upgrade
  }


  lifecycle {
    ignore_changes = [
      initial_node_count
    ]
  }
}
