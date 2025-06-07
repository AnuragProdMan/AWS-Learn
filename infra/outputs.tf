output "instance_public_ip" {
  value = aws_instance.springboot_instance.public_ip
}
