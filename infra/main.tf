provider "aws" {
    region = var.aws_region
}

resource "aws_key_pair" "ec2_key" {
  key_name = "visitor-ec2-key"
  public_key = file("${path.module}/ec2_key.pub")
}

resource "aws_instance" "visitor_ec2" {
  ami = var.ubuntu_ami
  instance_type = "t2.micro"
  key_name = aws_key_pair.ec2_key.key_name

  tags = {
    Name = "VisitorCounterApp"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ubuntu"
      private_key = file("${path.module}/ec2_key")
        host = self.public_ip
    }

    inline = [ 
        "sudo apt update",
        "sudo apt install -y docker.io",
        "sudo systemctl enable docker",
        "sudo docker run -d -p 80:3000 ghcr.io/tennis-kumar/visitor-counter-service"
     ]
  }
}

output "instance_ip" {
  value = aws_instance.visitor_ec2.public_ip
}