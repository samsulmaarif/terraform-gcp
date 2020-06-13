provider "google" {
  version = "3.5.0"

  credentials = file("../nacita-dev-terraform-demo.json")

  project = "nacita-dev"
  region  = "us-central1"
  zone    = "us-central1-c"
}

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

resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      //image = "debian-cloud/debian-9"
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.name
    subnetwork = google_compute_subnetwork.vpc_subnetwork.name
    access_config {
    }
  }
}


