variable "index" {
    default = "01"
}

variable "STUDENT_1ST_NAME" {}
variable "STUDENT_LAST_NAME" {}
variable "network" {
    default = "projects/igneous-sweep-305822/global/networks/default"     
}
variable "subnet" {
    default = "projects/igneous-sweep-305822/regions/us-central1/subnetworks/default"
}

variable services {}
variable pods {}