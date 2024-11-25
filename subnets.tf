resource "aws_subnet" "mysubnet1" {
vpc_id = aws_vpc.abc.id
tags = {
Name = "subnet-1"
}
availability_zone = "us-east-1a"
cidr_block = "10.0.1.0/24"
}


resource "aws_subnet" "mysubnet2" {
vpc_id = aws_vpc.abc.id
tags = {
Name = "subnet-2"
}
availability_zone = "us-east-1b"
cidr_block = "10.0.2.0/24"
}
