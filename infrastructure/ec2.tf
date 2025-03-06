resource "aws_key_pair" "Conferencia-key" {
  key_name   = "Conferencia"
  public_key = file("${var.PATH_PUBLIC_KEYPAIR}")
}

resource "aws_instance" "ec2_instance" {
  ami                    = "ami-053b0d53c279acc90"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.Conferencia-key.key_name
  vpc_security_group_ids = [aws_security_group.Conferencia-instances-sg.id]
  subnet_id              = aws_subnet.PublicS1.id
}

resource "aws_security_group" "Conferencia-instances-sg" {
  vpc_id = aws_vpc.Conferencia_VPC.id
  name   = "Conferencia_instances-sg"
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = [aws_security_group.Conferencia-instances-sg.id]
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [aws_security_group.Conferencia-instances-sg.id]
      self             = false
      to_port          = 22
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 3306
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [aws_security_group.Conferencia-instances-sg.id]
      self             = false
      to_port          = 3306
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 8080
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [aws_security_group.Conferencia-instances-sg.id]
      self             = false
      to_port          = 8080
    },
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = [aws_security_group.Conferencia-instances-sg.id]
      self             = false
      to_port          = 80
    }
  ]
}