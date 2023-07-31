
resource "aws_vpc" "vpc" {
  cidr_block                       = "10.0.0.0/16"
  assign_generated_ipv6_cidr_block = true

  tags = {
    Name = "vpc-study"
  }

}

data "aws_availability_zones" "available" {
  state = "available"
}

# SUBNETS

resource "aws_subnet" "subnet-public" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = data.aws_availability_zones.available.names[0]
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "sn-pub-10_0_1_0"
  }
}

resource "aws_subnet" "subnet-private" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = data.aws_availability_zones.available.names[1]
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "sn-priv-10_0_2_0"
  }
}

# INTERNET GATEWAY

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw-vpc-study"
  }
}

# ROUTE TABLES

resource "aws_route_table" "rt-public" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "rt-pub-vpc-study"
  }
}

# ROUTE TABLE ASSOCIATIONS

resource "aws_route_table_association" "rta-public" {
  subnet_id      = aws_subnet.subnet-public.id
  route_table_id = aws_route_table.rt-public.id
}

# SECURITY GROUPS

resource "aws_security_group" "sg-public" {
  vpc_id      = aws_vpc.vpc.id
  name        = "sg_public"
  description = "Allow HTTP,HTTPS, SSH inbound traffic  and all outbound traffic"

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.my_ip_address}/32"]
  }

  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "sg-private" {
  vpc_id      = aws_vpc.vpc.id
  name        = "sg_private"
  description = "Allow inbound traffic from same VPC instance and all outbound traffic"

  ingress {
    description = "VPC Allow"
    from_port   = 22
    to_port     = 22
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    description = "All traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }


}
