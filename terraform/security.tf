resource "aws_security_group" "sg" {
  vpc_id = "${aws_vpc.vpc.id}"

  tags = "${local.tags}"
}

resource "aws_security_group_rule" "allow_ssh" {
  type      = "ingress"
  from_port = 22
  to_port   = 22
  protocol  = "tcp"

  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_blocks = [
    "0.0.0.0/0",
  ] # add a CIDR block here

  #prefix_list_ids = ["pl-12c4e678"]

  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "allow_http" {
  type      = "ingress"
  from_port = 80
  to_port   = 80
  protocol  = "tcp"

  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_blocks = [
    "0.0.0.0/0",
  ] # add a CIDR block here

  #prefix_list_ids = ["pl-12c4e678"]

  security_group_id = "${aws_security_group.sg.id}"
}

resource "aws_security_group_rule" "allow_outbound_all" {
  type      = "egress"
  from_port = 0
  to_port   = 0
  protocol  = "-1"

  # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
  cidr_blocks = ["0.0.0.0/0"]

  #prefix_list_ids = ["pl-12c4e678"]

  security_group_id = "${aws_security_group.sg.id}"
}
