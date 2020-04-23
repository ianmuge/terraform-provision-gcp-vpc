output "exec_outputs" {
  value = "${data.external.GCP_CREDENTIALS.result}"
}

output "vpc" {
  value = "${google_compute_network.vpc.id}"
}

output "public_rules" {
  value = "${google_compute_firewall.public_rules.id}"
}
output "private_rules" {
  value = "${google_compute_firewall.private_rules.id}"
}
output "secure_rules" {
  value = "${google_compute_firewall.secure_rules.id}"
}