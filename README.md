# AWS Fundamentals

Deploys an EC2 instance with a web server inside its own VPC

## Create Infrastructure

```
terraform init
terraform plan -out="plan.tfplan"
terraform apply "plan.tfplan"
```

## Setup Web Server

`ssh -i mykeypair.pem ec2-user@<public-dns-hostname>`

### Create Filesystem

SSH into the EC2 instance and run the following commands to create the file system on the empty EBS

```
sudo yum install xfsprogs
sudo mkfs -t xfs /dev/xvdh
```

Mount the drive

```
sudo mkdir /web
sudo mount /dev/xvdh /web
```

### Install and Setup Apache

`sudo yum -y install httpd`

Edit the file `sudo vi /etc/httpd/conf/httpd.conf`
Replace `DocumentRoot "/var/www/html"` with `DocumentRoot "/web"`

Start Apache

`sudo service httpd start`

### Create Web Page

```
touch /web/index.html
chmod
```

# Web Server

`http://<public-dns-hostname>/index.html`

# Resources

- [Finding an AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-an-ami-console)
- [Block Device Mapping](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)
- [Shrink Size of an AMI](https://cloudership.com/blog/2017/5/28/shrink-the-size-of-an-ami)
- [EC2 SSH Access](https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f)
- [EC2 Quick Start](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/QuickStartEC2Instance.html)
- [Key Pair Terraform](http://2ninjas1blog.com/terraform-assigning-an-aws-key-pair-to-your-ec2-instance-resource/)
- [Apache EC2](https://docs.aws.amazon.com/efs/latest/ug/wt2-apache-web-server.html)
- [EBS Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html)