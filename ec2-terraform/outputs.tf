output "aws_ec2_instance_key" {
  value = aws_key_pair.my_key.key_name
}

output "aws_security_group" {
  value = aws_security_group.terra_sg.id
}

output "aws_ec2_instance_public_ip" {
  value = aws_instance.terra-server.public_dns
}