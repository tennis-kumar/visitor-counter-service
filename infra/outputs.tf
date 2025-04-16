output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.visitor_ec2.public_ip
}

output "ec2_ssh_command" {
  description = "SSH command to connect to the EC2 instance"
  value       = "ssh -i ec2_key ubuntu@${aws_instance.visitor_ec2.public_ip}"
}
