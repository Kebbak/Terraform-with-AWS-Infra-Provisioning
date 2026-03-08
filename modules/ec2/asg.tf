resource "aws_launch_template" "web_lt" {
  name_prefix   = "webserver-"
  image_id      = var.ec2_ami
  instance_type = var.instance_type
  key_name      = var.key_name
  vpc_security_group_ids = [var.security_group_id]
  user_data = filebase64("${path.module}/user_data.sh")
  iam_instance_profile {
    name = aws_iam_instance_profile.my_instance_profile.name
  }
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "webserver-asg"
    }
  }
}

resource "aws_autoscaling_group" "web_asg" {
  name                      = "webserver-asg"
  min_size                  = 2
  max_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = [var.subnet_id]
  health_check_type         = "ELB"
  health_check_grace_period = 300
  target_group_arns         = var.target_group_arns
  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }
  tag {
    key                 = "Name"
    value               = "webserver-asg"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
