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
