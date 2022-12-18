terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"

  backend "s3" {
    endpoint   = "storage.yandexcloud.net"
    bucket     = "testdefault"
    region     = "ru-central1-a"
    key        = "main-infra/terraform.tfstate"
    access_key = "YCAJEb_yGszI67YxlnKuVcrWv"
    secret_key = "YCMOSkHvfbTEFkntLlyacBTPwq0-zG8bTqlfs8X8"

    skip_region_validation      = true
    skip_credentials_validation = true
  }
}