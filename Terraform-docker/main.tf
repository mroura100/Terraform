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
    count = 3
	length = 4
	special = false
	upper = false
}

resource "docker_container" "nodered_container" {
  count = 3
  image = docker_image.nodered_image.latest
  #name  = "nodered"
  name = join("-", ["nodered", random_string.random[count.index].result])
  ports {
    internal = 1880
    #external = 1880
  }
}

#resource "docker_container" "nodered_container2" {
#  image = docker_image.nodered_image.latest
  #name  = "nodered"
 # name = join("-", ["nodered", random_string.random[count.index].result])
 # ports {
 #   internal = 1880
  #  external = 1880
  #}
#}


output "IP-Address" {
    #value = join(":", [docker_container.nodered_container1.ip_address, docker_container.nodered_container1.ports[0].external])
    #value = join(":", flatten([docker_container.nodered_container[*].ip_address, docker_container.nodered_container[*].ports[0].external]))
    value = [for i in docker_container.nodered_container[*]: join(".", [i.ip_address],i.ports[*]["external"])]
    description = "The IP Adress and port of the container"
}

output "Container-name" {
    value = docker_container.nodered_container[*].name
    description = "The Name of the container"
}

#output "IP-Address2" {
 #   value = join(":", [docker_container.nodered_container2.ip_address, docker_container.nodered_container2.ports[0].external])
  #  description = "The IP Adress and port of the container"
#}

#output "Container-name2" {
   # value = docker_container.nodered_container2.name
   # description = "The Name of the container"
#}




