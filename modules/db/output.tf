
output "instance_id" {
    value = aws_db_instance.mysql_db.id
    description = "The ID of the database instance"
}
