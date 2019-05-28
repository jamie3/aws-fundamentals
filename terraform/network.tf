resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.vpc.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags = "${local.tags}"
}

resource "aws_route_table_association" "rt_association" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${local.tags}"
}

resource "aws_eip" "eip" {
  instance = "${aws_instance.web.id}"
  vpc      = true

  associate_with_private_ip = "${local.private_ip}"
  depends_on                = ["aws_internet_gateway.gw"]

  tags = "${local.tags}"
}

resource "aws_vpc" "vpc" {
  cidr_block           = "${local.vpc_cidr}"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = "${local.tags}"
}

resource "aws_subnet" "subnet" {
  vpc_id                  = "${aws_vpc.vpc.id}"
  cidr_block              = "${local.subnet_cidr}"
  availability_zone       = "${local.zone}"
  map_public_ip_on_launch = true

  tags = "${local.tags}"
}
