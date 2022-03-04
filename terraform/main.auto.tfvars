cidr = "192.168.23.0/24"

controlplane = [
  {
    name = "instance1"
    size = "t2.large"
  },
]

nodes = [
  {
    name = "node1"
    size = "t2.large"
  },
  {
    name = "node2"
    size = "t2.large"
  },
]
