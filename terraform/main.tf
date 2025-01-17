module "instance" {
  source = "./incus"

  instance_name     = "linstor"
  network_ipv4_cidr = "192.0.2.1/24"
  network_ipv6_cidr = "2002::1234:abcd:ffff:c0a8:101/64"

  volume_size = "2GiB"
}
