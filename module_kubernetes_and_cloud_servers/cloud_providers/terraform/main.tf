provider "yandex" {
  cloud_id  = var.yc_id
  token     = var.yc_token
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}
locals {
  cidr_internet = "0.0.0.0/0"            # All IPv4 addresses.
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "network" {
  name = "network"
}

resource "yandex_vpc_subnet" "subnet_public" {
  name           = "public"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.10.0/24"]
  zone           = var.yc_zone
}
resource "yandex_vpc_subnet" "subnet_private" {
  name           = "private"
  network_id     = yandex_vpc_network.network.id
  v4_cidr_blocks = ["192.168.20.0/24"]
  zone           = var.yc_zone
}
resource "yandex_compute_instance" "vm_nat" {
  name                      = "nat"
  hostname                  = "nat"
  description               = "nat"
  platform_id               = "standard-v2"
  zone                      = var.yc_zone
  folder_id                 = var.yc_folder_id
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.nat_instance_image_id
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet_public.id
    nat        = true
    ip_address = "192.168.10.254"
  }

  metadata = {
    #    user-data = "${file("~/.ssh/cloudconfig")}"
    user-data : "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n            - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3kPvgxLMByb+TnXKw1B2fYQSnFskEhLAOr5l3SCaSyzddvFrhEBzJVxDvmV2rEoXY1VIHJOx1dMeV+PPWr09/kSKXYTfD1AC32BZ3AMKVgaxR4RCKw1RzwQfManThBGZFTeuPQw0t08itDSWN4O+e7kvW5oK3JTBu1CoTJs5NicbMRfPqgPd98f8HS/n8m0ko4fD1aqHNbXyiO+n5OfRZ421brGlRWL4RzUOij28FJ1zdUaJnNcUEltSmcjS9VvS8+/pkH7vSDOlXByNrW4523DRyJ24bSvXWDG8MfW8cESn7OES5xEz2X+IRXAUe2Inclipy2V3yKJorZGk9HTXq9llQbin6Vh5hTFVrESsD1x++6ZL8iyCq7HP2yzQomAwGldvuumUzwFEsaqfXpSW/H5k1Q3DnQ/BDAcN+r8F+H2FhpmBYKhKjTWJk3wHi74OQKjQpBkTwbgOpF4+yz4Phwxsery9Rqif2kRqp7ccdg67ZO495IOA83Ktoa3OYQeU= anastasiasuhodola@MacBook-Pro-Anastasia.local"
  }
}

resource "yandex_compute_instance" "vm_public" {
  name                      = "public"
  hostname                  = "public"
  platform_id               = "standard-v2"
  zone                      = var.yc_zone
  folder_id                 = var.yc_folder_id
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4

  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-ssd"
      size     = 100
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_public.id
    nat       = true
  }

  metadata = {
    #    user-data = "${file("~/.ssh/cloudconfig")}"
    user-data : "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n            - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3kPvgxLMByb+TnXKw1B2fYQSnFskEhLAOr5l3SCaSyzddvFrhEBzJVxDvmV2rEoXY1VIHJOx1dMeV+PPWr09/kSKXYTfD1AC32BZ3AMKVgaxR4RCKw1RzwQfManThBGZFTeuPQw0t08itDSWN4O+e7kvW5oK3JTBu1CoTJs5NicbMRfPqgPd98f8HS/n8m0ko4fD1aqHNbXyiO+n5OfRZ421brGlRWL4RzUOij28FJ1zdUaJnNcUEltSmcjS9VvS8+/pkH7vSDOlXByNrW4523DRyJ24bSvXWDG8MfW8cESn7OES5xEz2X+IRXAUe2Inclipy2V3yKJorZGk9HTXq9llQbin6Vh5hTFVrESsD1x++6ZL8iyCq7HP2yzQomAwGldvuumUzwFEsaqfXpSW/H5k1Q3DnQ/BDAcN+r8F+H2FhpmBYKhKjTWJk3wHi74OQKjQpBkTwbgOpF4+yz4Phwxsery9Rqif2kRqp7ccdg67ZO495IOA83Ktoa3OYQeU= anastasiasuhodola@MacBook-Pro-Anastasia.local"
  }
}

resource "yandex_vpc_route_table" "route-table-nat" {
  description = "Route table"
  name        = "route-table-nat"

  depends_on = [
    yandex_compute_instance.vm_nat
  ]

  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = local.cidr_internet
    next_hop_address   = yandex_compute_instance.vm_nat.network_interface.0.ip_address
  }
}

resource "yandex_compute_instance" "vm_private" {
  name                      = "private"
  hostname                  = "private"
  platform_id               = "standard-v2"
  zone                      = var.yc_zone
  folder_id                 = var.yc_folder_id
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-ssd"
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_private.id
    nat       = false
  }

  metadata = {
    #    user-data = "${file("~/.ssh/cloudconfig")}"
    user-data : "#cloud-config\nusers:\n  - name: ubuntu\n    groups: sudo\n    shell: /bin/bash\n    sudo: ['ALL=(ALL) NOPASSWD:ALL']\n    ssh-authorized-keys:\n            - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC3kPvgxLMByb+TnXKw1B2fYQSnFskEhLAOr5l3SCaSyzddvFrhEBzJVxDvmV2rEoXY1VIHJOx1dMeV+PPWr09/kSKXYTfD1AC32BZ3AMKVgaxR4RCKw1RzwQfManThBGZFTeuPQw0t08itDSWN4O+e7kvW5oK3JTBu1CoTJs5NicbMRfPqgPd98f8HS/n8m0ko4fD1aqHNbXyiO+n5OfRZ421brGlRWL4RzUOij28FJ1zdUaJnNcUEltSmcjS9VvS8+/pkH7vSDOlXByNrW4523DRyJ24bSvXWDG8MfW8cESn7OES5xEz2X+IRXAUe2Inclipy2V3yKJorZGk9HTXq9llQbin6Vh5hTFVrESsD1x++6ZL8iyCq7HP2yzQomAwGldvuumUzwFEsaqfXpSW/H5k1Q3DnQ/BDAcN+r8F+H2FhpmBYKhKjTWJk3wHi74OQKjQpBkTwbgOpF4+yz4Phwxsery9Rqif2kRqp7ccdg67ZO495IOA83Ktoa3OYQeU= anastasiasuhodola@MacBook-Pro-Anastasia.local"

  }
}

#https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/data-proc-nat.tf