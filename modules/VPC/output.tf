
# this is for resources that expect list of subnet ids, like EKS and RDS
output "public_subnet_ids" {
    value = [aws_subnet.public1.id, aws_subnet.public2.id]
}

# individual subnet outputs for resources that expect single subnet id, like EC2
output "vpc_id" {
    value = aws_vpc.custom_vpc.id
}
output "public1_subnet_id" {
    value = aws_subnet.public1.id
}
output "public2_subnet_id" {
    value = aws_subnet.public2.id
}
output "private1_subnet_id" {
    value = aws_subnet.private1.id
}
output "private2_subnet_id" {
    value = aws_subnet.private2.id
}