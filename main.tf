resource "aws_launch_template" "mylc" {
image_id = "ami-0166fe664262f664c"
instance_type = "t2.micro"
key_name = "ansible-kp"
network_interfaces {
security_groups = [aws_security_group.sg.id]
}
}

resource "aws_elb" "mylb" {
name = "terraform-lb"
security_groups = [aws_security_group.sg.id]
subnets = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
listener {
instance_port = 8000
instance_protocol = "http"
lb_port = 80
lb_protocol = "http"
}
tags = {
Name = "terraform-elb"
}
}

resource "aws_autoscaling_group" "myasg" {

launch_template {
name = aws_launch_template.mylc.name
version = "$Latest"
}

min_size = 2
max_size = 3
desired_capacity = 2
health_check_type = "EC2"
load_balancers = [aws_elb.mylb.name]
vpc_zone_identifier = [aws_subnet.mysubnet1.id, aws_subnet.mysubnet2.id]
}

