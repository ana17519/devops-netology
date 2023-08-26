provider "yandex" {
  cloud_id  = var.yc_id
  token     = var.yc_token
  folder_id = var.yc_folder_id
  zone      = var.yc_zone
}

#https://github.com/yandex-cloud/examples/blob/master/tutorials/terraform/data-proc-nat.tf
#https://cloud.yandex.ru/docs/compute/concepts/vm-metadata

resource "yandex_compute_instance_group" "group1" {
  name                = "ig"
  folder_id           = var.yc_folder_id
  service_account_id  = "aje4ofq2hpt96gqf6s7k" //sa id
  deletion_protection = false //изменила, иначе мешает удалить
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit" //LAMP
        size     = 4
      }
    }
    network_interface {
      network_id = "enpen75nkg6tcgheaiua" //network id
      subnet_ids = ["e9bg5kfsafq13pmu7jas"] //public subnet id
    }
    metadata = {
      user-data = "${file("~/.ssh/cloudconfigone")}"
    }
  }

  health_check {
    tcp_options {
      port = 80
    }
  }
  scale_policy {
    fixed_scale {
      size = 3 //<количество_ВМ_в_группе>
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 1
    max_expansion   = 0 //https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer
  }
  #   load_balancer {
  #    target_group_name        = "target-group"
  #    target_group_description = "load balancer target group"
  #  }
}
//https://cloud.yandex.ru/docs/network-load-balancer/operations/target-group-create
resource "yandex_lb_target_group" "group" {
  name = "group"
  target {
    subnet_id = "e9bg5kfsafq13pmu7jas"
    address   = "192.168.10.30"
  }
  target {
    subnet_id = "e9bg5kfsafq13pmu7jas"
    address   = "192.168.10.12"
  }
  target {
    subnet_id = "e9bg5kfsafq13pmu7jas"
    address   = "192.168.10.25"
  }
}
//https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer
//https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/data-sources/datasource_compute_instance_group
resource "yandex_lb_network_load_balancer" "lb-1" {
  name = "network-load-balancer-1"

  listener {
    name = "network-load-balancer-1-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.group.id

    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
//https://docs.digitalocean.com/tutorials/droplet-cloudinit/
//https://habr.com/ru/articles/574050/