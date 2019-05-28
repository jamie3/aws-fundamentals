resource "aws_ebs_volume" "ebs" {
  availability_zone = "${local.zone}"
  size              = 1
  type              = "gp2"

  tags = "${local.tags}"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.ebs.id}"
  instance_id = "${aws_instance.web.id}"
}

# Use the following aws command to find the AMI image id
# aws ec2 describe-images --owners amazon --filters 'Name=name,Values=amzn-ami-hvm-????.??.?.????????-x86_64-gp2' 'Name=state,Values=available' --output json | jq -r '.Images | sort_by(.CreationDate) | last(.[]).ImageId'
resource "aws_instance" "web" {
  ami               = "${local.ami}"
  instance_type     = "${local.instance_type}"
  availability_zone = "${local.zone}"
  key_name          = "${local.key_name}"

  vpc_security_group_ids = ["${aws_security_group.sg.id}"]
  subnet_id              = "${aws_subnet.subnet.id}"
  private_ip = "${local.private_ip}"
  tags        = "${local.tags}"
  volume_tags = "${local.tags}"
}
