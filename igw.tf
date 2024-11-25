resource "aws_internet_gateway" "igw" {
vpc_id = aws_vpc.abc.id
tags = {
Name = "MyIGW"
}
}
