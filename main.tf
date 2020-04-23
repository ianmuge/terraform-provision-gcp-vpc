data "external" "GCP_CREDENTIALS" {
  program = ["/bin/bash", "-c", "echo \"{\\\"project\\\":\\\"$GCP_PROJECT\\\",\\\"region\\\":\\\"$GCP_REGION\\\",\\\"credentials\\\":\\\"$GCP_SERVICE_ACCOUNT_FILE\\\"}\""]

}
provider "google" {
  region      = "${data.external.GCP_CREDENTIALS.result.region}"
  project     = "${data.external.GCP_CREDENTIALS.result.project}"
  credentials = "${file("${data.external.GCP_CREDENTIALS.result.credentials}")}"
}
data "http" "myip" {
  url = "https://api.ipify.org?format=json"
  request_headers = {
    Accept = "application/json"
  }
}
resource "google_compute_network" "vpc" {
  name                    = "${var.vpc.name}"
  description             = "${var.vpc.name} network"
  auto_create_subnetworks = "${var.vpc.auto_create_subnetworks}"
  routing_mode            = "${var.vpc.routing}"

}

resource "google_compute_firewall" "secure_rules" {
  depends_on = [
    google_compute_network.vpc
  ]

  name          = "${var.vpc.name}-secure-rules"
  network       = "${var.vpc.name}"
  description   = "${var.vpc.name} secure rules"
  source_ranges = concat(["${jsondecode(data.http.myip.body).ip}/32"], "${var.secure_rules.sources}")
  allow {
    protocol = "${var.secure_rules.protocol}"
    ports    = "${var.secure_rules.ports}"
  }

}
resource "google_compute_firewall" "private_rules" {
  depends_on = [
    google_compute_network.vpc
  ]

  name        = "${var.vpc.name}-private-rules"
  network     = "${var.vpc.name}"
  description = "${var.vpc.name} private rules"
  target_tags = "${var.private_rules.targets}"
  source_tags = "${var.private_rules.sources}"
  allow {
    protocol = "${var.private_rules.protocol}"
    ports    = "${var.private_rules.ports}"
  }

}

resource "google_compute_firewall" "public_rules" {
  depends_on = [
    google_compute_network.vpc
  ]
  
  name        = "${var.vpc.name}-public-rules"
  network     = "${var.vpc.name}"
  description = "${var.vpc.name} public rules"
  target_tags = "${var.public_rules.targets}"
  allow {
    protocol = "${var.public_rules.protocol}"
    ports    = "${var.public_rules.ports}"
  }
}