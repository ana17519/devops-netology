provider "yandex" {
  cloud_id  = var.yc_id
  token     = var.yc_token
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "net" {
  name = "net2"
}

resource "yandex_vpc_subnet" "subnet" {
  name           = "subnet2"
  network_id     = yandex_vpc_network.net.id
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = var.yc_zone
}

resource "yandex_compute_instance" "vm" {
  name        = "${"test"}-${count.index}"
  count       = local.count[terraform.workspace]
  hostname    = "${"test"}-${count.index}"
  description = "${"test"}-${count.index}"
  platform_id = local.instant_types[terraform.workspace]
  zone        = var.yc_zone
  folder_id   = var.yc_folder_id

  resources {
    cores         = 2
    memory        = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}


resource "yandex_compute_instance" "vm2" {
  for_each    = local.virtual_machines[terraform.workspace]
  name        = each.key
  description = "${"test"}-${each.value}"
  platform_id = local.instant_types[terraform.workspace]
  zone        = var.yc_zone
  folder_id   = var.yc_folder_id
  lifecycle {
    create_before_destroy = true
  }
  resources {
    cores         = 2
    memory        = 4
    core_fraction = 100
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = 20
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}