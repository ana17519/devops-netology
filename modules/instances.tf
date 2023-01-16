module "vm" {
  source = "../modules/instance"
  yc_folder_id = var.yc_folder_id
  yc_id = var.yc_id
  yc_token = var.yc_token
  yc_zone = var.yc_zone
}
