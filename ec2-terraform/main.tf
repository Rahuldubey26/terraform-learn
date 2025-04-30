# Key pair
resource "aws_key_pair" "my_key" {
  key_name   = "terr-key-dev"
  public_key = file("terr-key.pub")

    tags = {
    Name = "terra_sg"
    Environment="dev"
  }
}

# VPC and SG

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "terra_sg" {
  name        = "terra_sg-dev"
  description = "This is sg for ec2 t2.micro"
  vpc_id      = aws_default_vpc.default.id
  # vpc_id      = aws_default_vpc.default.id

  # ingress
  ingress {
    to_port     = 22
    from_port   = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    to_port     = 80
    from_port   = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    to_port     = 0
    from_port   = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terra_sg"
    Environment="dev"
  }
}

# EC2 vm
resource "aws_instance" "terra-server" {
  ami                    = "ami-0e35ddab05955cf57"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = [aws_security_group.terra_sg.id]


  root_block_device {
    volume_type           = "gp3" # General Purpose SSD
    volume_size           = 10    # Size in GB
    delete_on_termination = true
  }


  tags = {
    Name = "terr-server"
    Environment="dev"
  }
}

