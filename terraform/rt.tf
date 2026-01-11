# Create Route Tables
resource "aws_route_table" "public_route" {  
    vpc_id = aws_vpc.devops_vpc.id  
    route {    
        cidr_block = "0.0.0.0/0"    
        gateway_id = aws_internet_gateway.igw.id  
    }  
    tags = {    
        Name = "devops-public-route"  
    }    
}

resource "aws_route_table" "private_route" {  
    vpc_id = aws_vpc.devops_vpc.id  
    route {    
        cidr_block = "0.0.0.0/0"    
        nat_gateway_id = aws_nat_gateway.ngw.id  
    }  
    tags = {    
        Name = "devops-private-route"  
    }    
}

# Associate Route Tables with Subnets
resource "aws_route_table_association" "public_association" {
    subnet_id      = aws_subnet.public_subnet.id  
    route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table_association" "private_association" {  
    subnet_id      = aws_subnet.private_subnet.id  
    route_table_id = aws_route_table.private_route.id
}