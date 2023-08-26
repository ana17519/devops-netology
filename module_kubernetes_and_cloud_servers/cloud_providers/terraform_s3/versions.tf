terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

// Creating a static access key
resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = "aje4ofq2hpt96gqf6s7k"
  description        = "static access key for object storage"
}

//https://cloud.yandex.ru/docs/storage/operations/objects/edit-acl
resource "yandex_storage_bucket" "test" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "asuhodola2408"
  acl = "public-read"
}
//https://cloud.yandex.ru/docs/storage/operations/objects/edit-acl
resource "yandex_storage_object" "upload" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket     = "asuhodola2408"
  key = "picture"
  source = "123.jpg"
}

