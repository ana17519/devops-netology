provider "yandex" {
  cloud_id  = var.yc_id
  token     = var.yc_token
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}
locals {
  cidr_internet = "0.0.0.0/0"
  ip_address    = "192.168.10.254"
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
  route_table_id = yandex_vpc_route_table.route-table-nat.id
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
    ip_address = local.ip_address
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
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
      size     = 50
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_public.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_route_table" "route-table-nat" {
  description = "Route table"
  name        = "route-table-nat"

  network_id = yandex_vpc_network.network.id

  static_route {
    destination_prefix = local.cidr_internet
    next_hop_address   = local.ip_address
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
    user-data = "${file("~/.ssh/cloudconfig")}"
    #    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

#https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/data-proc-nat.tf
#https://cloud.yandex.ru/docs/compute/concepts/vm-metadata

