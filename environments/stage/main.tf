locals {
  //project = "my-project"
  project = "igneous-sweep-305822"
  region  = "us-central1"
}

resource "google_project_service" "local_project" {
  project = local.project
  service = "container.googleapis.com"

  disable_dependent_services = true
}

# Start the application cluster
module "application_cluster" {
  source = "../../modules/cluster"
  depends_on = [ google_project_service.local_project ]

  cluster_name   = "stage"
  master_version = "1.17.15-gke.800"
  project        = local.project
  services       = var.services
  pods           = var.pods
  //network        = "projects/host-project-302822/global/networks/shared-vpc"
  //sub_network    = "projects/host-project-302822/regions/us-central1/subnetworks/st-${var.index}-stage"
  network        = var.network
  sub_network    = var.subnet

  region         = local.region
  zones = [
    "${local.region}-b",
    "${local.region}-c",
    "${local.region}-f"
  ]
  master_ipv4_cidr_block    = "192.168.1.0/28"
  max_worker_nodes          = "1"
  min_worker_nodes          = "1"
  default_max_pods_per_node = "64"
  monitoring_service        = "monitoring.googleapis.com/kubernetes"
  logging_service           = "logging.googleapis.com/kubernetes"
}

resource "google_service_account" "k8s" {
  account_id = "edge-case-${var.STUDENT_1ST_NAME}-${var.STUDENT_LAST_NAME}"
  project    = local.project
}

module "application_nodepool_workers_np" {
  //about this module https://gitlab.com/DigitalOnUs/krollege-devops/-/blob/master/02%20-%20GCP/01-GKE.md firts exercise 
  source = "../../modules/node_pool"

  name               = "workers"
  project            = local.project
  location           = local.region
  cluster_name       = module.application_cluster.cluster_name
  max_worker_nodes   = "1"
  min_worker_nodes   = "1"
  initial_node_count = "1"

  max_surge              = "0"
  max_unavailable        = "1"
  image_type             = "UBUNTU"
  machine_type           = "n1-standard-4"
  disk_type              = "pd-ssd"
  disk_size              = "50"
  service_account        = google_service_account.k8s.email
  node_pool_network_tags = []
  node_pool_labels = {
    "dou/student-name" : "${var.STUDENT_1ST_NAME}_${var.STUDENT_LAST_NAME}"
  }
  node_locations = [
    "us-central1-a"
  ]
}