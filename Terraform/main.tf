###MASTER CONFIG
##VRSION TERRAFORM
terraform {
    required_version = "1.3.7"
}
##Provider
provider "google"{
    credentials = file("C:\\GIT\\Pirate_project2\\Terraform\\prod-svc-creds.json")
    project     = "pirate-project-374313"
    region      = "europe-west6"
}
###VM BUILD
resource "google_compute_instance""app"{
    name = "test1"
    machine_type = "e2-micro"
    zone = "europe-west6-a"

###IMAGE FOR DEPLOE
    boot_disk {
        initialize_params {
            image = "test-na-mugika"
            }
    }

### TAGS FOR VM
    tags = ["webserver","externalssh"]

###NETWORK CONFIG
    network_interface {
        network = "default"
            access_config {}
    }  
    
##USER SSH KEY
    metadata = {
        ssh-keys = "admin:${file("~/.ssh/id_rsa.pub")}"
    }
    connection {
        type        = "ssh"
        user        = "admin"
        host        = "google_compute_instance.this.network_interface.0.access_config.0.nat_ip" 
        agent       = false
        private_key = "${file("~/.ssh/id_rsa")}"
  }

### SCRIPTS IN TO VM
    provisioner "remote-exec" {
                script = "test_site.sh"
    }

}

###FIREWALL
resource "google_compute_firewall" "firewall" {
    name    = "externalssh"
    network = "default"
    allow {
        protocol = "tcp"
        ports    = ["22"]
    }
    source_ranges = ["0.0.0.0/0"] 
    target_tags   = ["externalssh"]
}
resource "google_compute_firewall" "webserverrule" {
    name    = "webserver"
    network = "default"
    allow {
        protocol = "tcp"
        ports    = ["80","443"]
    }
    source_ranges = ["0.0.0.0/0"] 
    target_tags   = ["webserver"]
}

