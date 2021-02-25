resource "google_container_cluster" "gke_cluster" {
  name                      = var.cluster_name
  project                   = var.project
  location                  = var.region
  network                   = var.network
  subnetwork                = var.sub_network
  remove_default_node_pool  = true
  initial_node_count        = 1
  node_locations            = var.zones
  min_master_version        = var.master_version
  default_max_pods_per_node = var.default_max_pods_per_node
  monitoring_service        = var.monitoring_service
  logging_service           = var.logging_service
  addons_config {
    horizontal_pod_autoscaling {
      disabled = false
    }
    http_load_balancing {
      disabled = false
    }
  }
  resource_labels = {
    portworx = "gke"
  }

  master_authorized_networks_config {
    dynamic "cidr_blocks" {
      for_each = var.master_authorized_network_cidr_blocks
      content {
        cidr_block   = lookup(cidr_blocks.value, "cidr_block", null)
        display_name = lookup(cidr_blocks.value, "display_name", null)
      }
    }
  }

  ip_allocation_policy {
    # use_ip_aliases = true # Deprecated as for 3.0.0 google provider
    services_secondary_range_name = "${var.services}"
    cluster_secondary_range_name  = "${var.pods}"
  }
  private_cluster_config {
    master_ipv4_cidr_block  = var.master_ipv4_cidr_block
    enable_private_endpoint = false
    enable_private_nodes    = true
  }

  dynamic "resource_usage_export_config" {
    for_each = var.metering == null ? [] : list(var.metering)
    content {
      enable_network_egress_metering       = resource_usage_export_config.value.network_metering
      enable_resource_consumption_metering = resource_usage_export_config.value.consumption_metering
      bigquery_destination {
        dataset_id = resource_usage_export_config.value.metering_dataset_id
      }
    }
  }
}
