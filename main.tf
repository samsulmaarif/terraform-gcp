provider "google" {
  version = "3.5.0"

  credentials = file("../nacita-dev-terraform-demo.json")

  project = var.project
  region  = var.region
  zone    = var.zone
}

# New resource for the storage bucket our application will use.
resource "google_storage_bucket" "example_bucket" {
  name     = "klim-terraform-demo"
  location = "US"

  website {
    main_page_suffix = "index.html"
    not_found_page   = "404.html"
  }
}


resource "google_compute_instance" "vm_instance" {

  depends_on = [google_storage_bucket.example_bucket]

  name         = "terraform-instance"
  machine_type = "f1-micro"
  tags         = ["klim-web"]

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
      nat_ip = google_compute_address.vm_ip_static.address
    }
  }
}

