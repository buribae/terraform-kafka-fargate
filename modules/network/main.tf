# Fetch AZs in the current region
data "aws_availability_zones" "available" {}

# -------------------------
# VPC
# -------------------------
resource "aws_vpc" "vpc-msk-fargate" {
  cidr_block = "172.17.0.0/16"
}

# -------------------------
# SUBNET
# -------------------------
resource "aws_subnet" "private" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc-msk-fargate.id
  cidr_block        = cidrsubnet(aws_vpc.vpc-msk-fargate.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.available.names[count.index]
}

# -------------------------
# OUTPUTS
# -------------------------
output "vpc_id" {
  value = aws_vpc.vpc-msk-fargate.id
}

output "subnet_ids" {
  value = flatten([aws_subnet.private.*.id])
}
