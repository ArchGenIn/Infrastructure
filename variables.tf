# Define variables
variable "auth_data" {
  type = object({
    credential_id = string
    credential_secret = string
    auth_url = string
  })
  sensitive = true
}

variable "agi_execute_server" {
  type = object({
    name = string
    flavor_name = string
    image_id = string
    key_pair = string
    volume_size = number
})
}

variable "agi_execute_network" {
  type = object({
    name = string
    network_subnet_range = string
})
}

