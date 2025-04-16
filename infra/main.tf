provider "aws" {
    region = var.aws_region
}

resource "aws_key_pair" "ec2_key" {
  key_name = "visitor-ec2-key"
  public_key = file("${path.module}/ec2_key.pub")
}

resource "aws_security_group" "visitor_sg" {
  name = "visitor-sg"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  
}

resource "aws_instance" "visitor_ec2" {
  ami = var.ubuntu_ami
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [ aws_security_group.visitor_sg.id ]
  associate_public_ip_address = true

  tags = {
    Name = "VisitorCounterApp"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/ec2_key")
      host = self.public_ip
      timeout = "5m"
    }

    inline = [ 
        "sudo apt update",
        "sudo apt install -y docker.io",
        "sudo systemctl enable docker",
        "sudo systemctl start docker",
        "sudo docker run -d -p 80:3000 ghcr.io/tennis-kumar/visitor-counter-service:latest"
     ]
  }
}

output "instance_ip" {
  value = aws_instance.visitor_ec2.public_ip
}