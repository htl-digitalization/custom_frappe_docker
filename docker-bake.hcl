variable "FRAPPE_VERSION" {
  default = "version-14"
}

variable "ERPNEXT_VERSION" {
  default = "version-14"
}

variable "REGISTRY_NAME" {
  default = "hieutrluu"
}

variable "BACKEND_IMAGE_NAME" {
  default = "tpp_erpnext_worker"
}

variable "FRONTEND_IMAGE_NAME" {
  default = "tpp_erpnext_nginx"
}

variable "VERSION" {
  default = "latest"
}

group "default" {
    targets = ["backend", "frontend"]
}

target "backend" {
    dockerfile = "images/backend.Dockerfile"
    tags = ["${REGISTRY_NAME}/${BACKEND_IMAGE_NAME}:${VERSION}-develop"]
    args = {
      "ERPNEXT_VERSION" = ERPNEXT_VERSION
    }
}

target "frontend" {
    dockerfile = "images/frontend.Dockerfile"
    tags = ["${REGISTRY_NAME}/${FRONTEND_IMAGE_NAME}:${VERSION}-develop"]
    args = {
      "FRAPPE_VERSION" = FRAPPE_VERSION
      "ERPNEXT_VERSION" = ERPNEXT_VERSION
    }
}
