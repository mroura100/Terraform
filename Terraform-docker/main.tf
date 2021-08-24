terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nodered_image" {
  name = "nodered/node-red:latest"
}

resource "docker_container" "nodered_container" {
  image = docker_image.nodered_image.latest
  name  = "nodered"
  ports {
    internal = 1880
    external = 1880
  }
}

output "IP-Address" {
    value = docker_container.nodered_container.ip_address
    description = "The IP Adress of the container"
}

output "Container-name" {
    value = docker_container.nodered_container.name
    description = "The Name of the container"
}


