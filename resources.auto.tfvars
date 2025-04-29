agi_execute_server = ({
    name     = "agi_execute"
    flavor_name = "m2.4xlarge"
    image_id = "eca7f6f9-a8ee-47a0-b94c-d2590958eb60"
    key_pair = "felho"
    volume_size = 16
})

agi_execute_network = ({
    name = "bioinfo-baden-net"
    network_subnet_range = "10.1.0.0/24"
})
