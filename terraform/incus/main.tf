resource "incus_network" "this" {
  name = "dev-net"

  config = {
    "ipv4.address" = var.network_ipv4_cidr
    "ipv4.nat"     = "true"
    "ipv6.address" = var.network_ipv6_cidr
    "ipv6.nat"     = "true"
  }
}

resource "incus_storage_pool" "this" {
  name   = "linstor-pool"
  driver = "lvm"
}

resource "incus_storage_volume" "this" {
  name         = "vol1"
  pool         = incus_storage_pool.this.name
  content_type = "block"
  config = {
    "size" = var.volume_size
  }
}

resource "incus_profile" "this" {
  name = "profile1"

  config = {
    "limits.cpu" = var.cpu_count
  }

  device {
    name = "disk"
    type = "disk"

    properties = {
      pool = incus_storage_pool.this.name
      path = "/"
    }
  }

  device {
    name = "eth1"
    type = "nic"

    properties = {
      "network" = incus_network.this.name
      "name"    = "eth1"
    }

  }
}

resource "incus_instance" "this" {
  count    = var.instance_count
  name     = "${var.instance_name}${var.instance_count > 1 ? "-${count.index + 1}" : ""}"
  image    = var.image
  type     = "virtual-machine"
  profiles = [incus_profile.this.name]

  config = {
    "limits.cpu"    = var.cpu_count
    "limits.memory" = var.memory_count
  }

  #NOTE(wncslln): improve this block to accept more disks as input
  dynamic "device" {
    for_each = [1]

    content {
      type = "disk"
      name = "disk1"

      properties = {
        pool   = incus_storage_pool.this.name
        source = incus_storage_volume.this.name
      }
    }
  }

  lifecycle {
    ignore_changes = [running]
  }
}
