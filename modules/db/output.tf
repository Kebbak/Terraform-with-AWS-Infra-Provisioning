output "instance_id" { 
    value = aws_instance.db.id 
    description = "The ID of the database instance"
}
