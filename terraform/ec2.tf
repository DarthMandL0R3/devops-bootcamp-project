module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.5"

/*ami                         = "ami-00d8fc944fb171e29"
  name                        = "node-${each.key}"
  instance_type               = "t3.micro"
  subnet_id                   = module.vpc.public_subnets[0]
  vpc_security_group_ids      = [module.security_group.security_group_id]
  associate_public_ip_address = true */

  resource "aws_instance" "web_server" {  
    ami           = "ami-00d8fc944fb171e29"  
    instance_type = "t3.micro"  
    subnet_id     = aws_subnet.public_subnet.id  
    security_groups = [aws_security_group.web_sg.name]  
    tags = {    
      Name = "WebServer"  
      }
    }

  resource "aws_instance" "ansible_controller" {  
    ami           = "ami-00d8fc944fb171e29"
    instance_type = "t3.micro"  
    subnet_id     = aws_subnet.private_subnet.id  
    security_groups = [aws_security_group.ansible_sg.name]  
    tags = {    
      Name = "AnsibleController"  
      }
  }

  resource "aws_instance" "monitoring_server" {  
    ami           = "ami-00d8fc944fb171e29" 
    instance_type = "t3.micro"  
    subnet_id     = aws_subnet.private_subnet.id  
    security_groups = [aws_security_group.ansible_sg.name]  
    tags = {    
      Name = "MonitoringServer"  
      }
  }

  key_name = aws_key_pair.ansible.key_name
}
