resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "vpc_subnetwork" {
  ip_cidr_range            = "10.4.4.0/24"
  name                     = "terraform-subnet"
  network                  = google_compute_network.vpc_network.name
  private_ip_google_access = "false"
}

resource "google_compute_address" "vm_ip_static" {
  name = "ip-static-terraform"
}

