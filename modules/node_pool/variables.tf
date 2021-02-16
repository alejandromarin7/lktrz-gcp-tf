variable "name" {
  type = string
}

variable "location" {}

variable "node_locations" {
  description = "List of zones in which the node pool's nodes should be located"
  type        = list(string)
  default     = null
}

variable "initial_node_count" {
  description = "Initial number of nodes per zone in the node pool. Needs a lifecycle block to ignore future changes"
}

variable "project" {
  description = "The project in which to hold the components"
  type        = string
}

variable "cluster_name" {
  description = "The name of the cluster, usually used as the output (cluster_name) of the cluster module"
  type        = string
}

variable "max_worker_nodes" {
  description = "Max number of nodes for the autoscaling setup"
  type        = string
}

variable "min_worker_nodes" {
  description = "Min number of nodes for the autoscaling setup"
  type        = string
}

variable "max_surge" {
  description = "Max number of new nodes for nodepool upgrade"
  type        = string
}

variable "max_unavailable" {
  description = "Max number of unavailable nodes during nodepool upgrade"
  type        = string
}

variable "oauth_scopes" {
  description = "Scopes for the oauth of the nodes"
  type        = list(any)
  default = [
    "https://www.googleapis.com/auth/devstorage.read_only",
    "https://www.googleapis.com/auth/logging.write",
    "https://www.googleapis.com/auth/monitoring",
    "https://www.googleapis.com/auth/servicecontrol",
    "https://www.googleapis.com/auth/service.management.readonly",
    "https://www.googleapis.com/auth/trace.append",
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/compute"
  ]
}

variable "image_type" {
  description = "Image used for all nodes of  the node pool, COS/Ubuntu with docker/containerd"
  type        = string
}

variable "machine_type" {
  description = "Machine type for all nodes of the node pool"
  type        = string
}

variable "disk_type" {
  description = "Type of disk used on the instances"
  type        = string
}

variable "disk_size" {
  description = "Size of the disk for all nodes on the node pool"
  type        = string
}

variable "service_account" {
  description = "Service account used for all nodes on the node pools"
  type        = string
}

variable "node_pool_network_tags" {
  description = "Network tags used in all nodes of the cluster"
  type        = list(any)
}

variable "max_pods_per_node" {
  description = "The maximum number of pods per node in this node pool."
  type        = string
  default     = "110"
}

variable "node_pool_labels" {
  type = map(any)
  default = {

  }
}

variable "auto_repair" {
  default = false
}
variable "auto_upgrade" {
  default = false
}

variable "taints" {
  type    = list(any)
  default = []
}
