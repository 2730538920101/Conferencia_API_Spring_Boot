output "server_node_public_ip" {
  value = try(aws_instance.ec2_instance.public_ip, "")
}


output "server_node_private_ip" {
  value = try(aws_instance.ec2_instance.private_ip, "")
}

output "server_node_public_dns" {
  value = try(aws_instance.ec2_instance.public_dns, "")
}

output "rds_endpoint" {
  value = aws_db_instance.mysql_rds.endpoint
}