module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.1"

  /*name        = "web-server"
  description = "Security group for web-server with HTTP ports open"
  vpc_id      = module.vpc.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "ssh-tcp"]
  egress_rules        = ["all-all"] */

  resource "aws_security_group" "web_sg" {
    vpc_id = aws_vpc.devops_vpc.id  
    ingress {    
      from_port   = 80    
      to_port     = 80    
      protocol    = "tcp"    
      cidr_blocks = ["0.0.0.0/0"]  
      }  
    ingress {    
      from_port   = 22    
      to_port     = 22    
      protocol    = "tcp"    
      cidr_blocks = [aws_vpc.devops_vpc.cidr_block]  
      }  
    tags = {    
      Name = "devops-public-sg"  
      }
  }

  resource "aws_security_group" "ansible_sg" {
    vpc_id = aws_vpc.devops_vpc.id  
    ingress {    
      from_port   = 22    
      to_port     = 22    
      protocol    = "tcp"    
      cidr_blocks = [aws_vpc.devops_vpc.cidr_block]
      }  
    tags = {
      Name = "devops-private-sg"  
      }
    }
}