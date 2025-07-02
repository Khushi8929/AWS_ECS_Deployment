# modules/vpc/outputs.tf
output "vpc_id" {
  value = aws_vpc.vpc-kp.id
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}
