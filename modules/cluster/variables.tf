variable "project" {
  description = "The project in which to hold the components"
  type        = string
}

variable "region" {
  description = "Name of the region"
  type        = string
}

variable "zones" {
  description = "Zones"
  type        = list(any)
  default = [
    "us-central1-b",
    "us-central1-c",
    "us-central1-f"
  ]
}

variable "cluster_name" {
  description = "cluster_name"
  type        = string
}

variable "master_version" {
  description = "k8s master version"
  type        = string
}

variable "master_authorized_network_cidr_blocks" {
  description = "Networks allowed to access the master endpoint"
  type        = list(any)
  default = [{ cidr_block = "10.0.0.0/8",
             display_name = "example_network" }]
}

variable "network" {
  description = "network"
  type        = string
}

variable "sub_network" {
  description = "sub_network"
  type        = string
}

variable "master_ipv4_cidr_block" {
  description = "IPv4 CIDR range to use for the master network. This should have a netmask of size /28 and should be used in conjunction with the --enable-private-nodes flag."
  type        = string
}

variable "min_worker_nodes" {
  description = "Min number of nodes when using Cluster Autoscaler"
  type        = string
}

variable "max_worker_nodes" {
  description = "Max number of nodes when using Cluster Autoscaler"
  type        = string
}

variable "default_max_pods_per_node" {
  description = "Max num of pods to be scheduled on a node (translates to a CIDR used by routing roules used by kubenet)"
  default     = "110"
}

variable "monitoring_service" {
  description = "Indicates which version of monitoring to use"
  default     = "none"
}

variable "logging_service" {
  description = "Indicates wich version of logging to use"
  default     = "none"
}

/*
metering = {
            network_metering     = "true"
            consumption_metering = "true"
            metering_dataset_id  = "gke_usage_metering"
          }
*/
variable "metering" {
  description = "Map with the necessary attributes to enable metering in the cluster, if is null the metering is disable"
  type        = map(string)
  default     = null
}

variable pods     {}
variable services {}