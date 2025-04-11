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
  depends_on = [
    aws_db_instance.mysql_rds
  ]
    provisioner "remote-exec" {
    inline = [
      "echo 'Updating the system...'",
      "sudo apt update -y",

      # Instalación de Docker
      "echo 'Installing Docker...'",
      "sudo apt install -y docker.io",
      "sudo systemctl enable docker",
      "sudo systemctl start docker",

      # Añadir el usuario ubuntu al grupo docker
      "echo 'Adding ubuntu user to docker group...'",
      "sudo usermod -aG docker ubuntu",
      "sudo chmod 666 /var/run/docker.sock",

      # Instalación de Docker Compose
      "echo 'Installing Docker Compose...'",
      "sudo curl -L \"https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)\" -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",

      # Instalación del cliente de MySQL
      "echo 'Installing MySQL client from official repo...'",
      "sudo apt-get install -y wget lsb-release gnupg",
      "wget https://dev.mysql.com/get/mysql-apt-config_0.8.24-1_all.deb",
      "sudo DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config_0.8.24-1_all.deb",
      "sudo apt-get update",
      "sudo apt-get install -y mysql-client"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ubuntu"
      private_key = file(var.PATH_KEYPAIR)
    }
  }
  provisioner "file" {
    source      = "${path.module}/../database/init.sql"
    destination = "/home/ubuntu/init.sql"

    connection {
      type        = "ssh"
      host        = aws_instance.ec2_instance.public_ip
      user        = "ubuntu"
      private_key = file(var.PATH_KEYPAIR)
    }
  }
  tags = {
    Name = "Conferencia-Instance"
  }
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
      security_groups  = []
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
      security_groups  = []
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
      security_groups  = []
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
      security_groups  = []
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
      security_groups  = []
      self             = false
      to_port          = 80
    }
  ]
}

