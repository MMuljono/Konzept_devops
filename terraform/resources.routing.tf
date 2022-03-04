resource "aws_route_table" "to-outside" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public-to-outside" {
  subnet_id = aws_subnet.public.id
  route_table_id = aws_route_table.to-outside.id
}

# NOTE: this effective DISABLED any restrictions and thus the firewall. This is meant
#       for showcasing only and is NOT production-ready. Don;t try this at home!
# DOCS: https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/#check-required-ports
#
resource "aws_security_group" "firewall" {
  vpc_id = aws_vpc.vpc.id

  egress {
    description = "allow-all-outbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "allow-all-inbound"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_lb" "public" {
  name               = "basic-load-balancer"
  load_balancer_type = "network"
  subnets            = [aws_subnet.public.id]

  enable_cross_zone_load_balancing = true
}
resource "aws_lb_listener" "public" {
  for_each = var.ports

  load_balancer_arn = aws_lb.public.arn

  protocol          = "TCP"
  port              = each.value

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.public[each.key].arn
  }
}

resource "aws_lb_target_group" "public" {
  for_each = var.ports

  port        = each.value
  protocol    = "TCP"
  vpc_id      = aws_vpc.vpc.id

  depends_on = [
    aws_lb.public
  ]

  lifecycle {
    create_before_destroy = true
  }
}
