module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.5.1"

  name = "devops-vpc"
  cidr = "10.0.0.0/24"
  azs  = ["ap-southeast-1a"]

  # Create Subnets
  resource "aws_subnet" "private_subnet" {  
    vpc_id            = aws_vpc.devops_vpc.id  
    cidr_block        = "10.0.0.0/25"  
    tags = {    
      Name = "devops-private-subnet"  
      }
  }
  
  resource "aws_subnet" "public_subnet" {  
    vpc_id            = aws_vpc.devops_vpc.id  
    cidr_block        = "10.0.0.128/25"  
    tags = {    
       Name = "devops-public-subnet"  
       }
  }

  # Create Internet Gateway
  resource "aws_internet_gateway" "igw" {  
    vpc_id = aws_vpc.devops_vpc.id  
    tags = {    
      Name = "devops-igw"  
      }
  }

  # Create NAT Gateway
  resource "aws_nat_gateway" "ngw" {  
    allocation_id = aws_eip.nat_eip.id  
    subnet_id    = aws_subnet.public_subnet.id  
    tags = {    
      Name = "devops-ngw"  
      }
  }

  # Create Elastic IP for NAT Gateway
  resource "aws_eip" "nat_eip" {  
    vpc = true
  }

  tags = {
    Terraform   = "true"
    Environment = "Prod"
  }
}