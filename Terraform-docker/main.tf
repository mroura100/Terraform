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

resource "random_string" "random" {
    count = var.container_count
	length = 4
	special = false
	upper = false
}

resource "docker_container" "nodered_container" {
  count = var.container_count
  image = docker_image.nodered_image.latest
  #name  = "nodered"
  name = join("-", ["nodered", random_string.random[count.index].result])
  ports {
    internal = var.int_port
    external = var.ext_port
  }
}









