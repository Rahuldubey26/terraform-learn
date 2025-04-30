# resource "aws_vpc" "main" {
#   cidr_block       = "10.0.0.0/16"
#   instance_tenancy = "default"

#   tags = {
#     Name = "vpc"
#   }
# }

# resource "aws_subnet" "main" {
#   vpc_id     = aws_vpc.main.id
#   cidr_block = "10.0.1.0/24"
#   map_public_ip_on_launch=true
#   tags = {
#     Name = "Public-Subnet"
#   }
# }

# resource "aws_internet_gateway" "igw" {
#   vpc_id = aws_vpc.main.id

#   tags = {
#     Name = "IGW"
#   }
# }

# resource "aws_route_table" "rt" {
#   vpc_id = aws_vpc.main.id

#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.igw.id
#   }

#   tags = {
#     Name = "route_table"
#   }
# }

# resource "aws_route_table_association" "a" {
#   subnet_id      = aws_subnet.main.id
#   route_table_id = aws_route_table.rt.id
# }

module "vpc" {

  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 4.0"

  name            = local.name
  cidr            = local.vpc_cidr
  azs             = local.azs
  public_subnets  = local.public_subnets
  private_subnets = local.private_subnets
  intra_subnets   = local.intra_subnets

  enable_nat_gateway = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
  tags = { 
    Terraform = "true"
    env= "dev"
  }

}
