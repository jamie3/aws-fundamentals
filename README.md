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

### Install and Setup Apache

1. Install Apache

    `sudo yum -y install httpd`

2. Mount the EBS drive to the Apache document directory

    `sudo mount /dev/xvdh /var/www/html`

3. Change owner of the html directory

    `sudo chown -R ec2-user /var/www/html`

3. Create the Web Page

    `sudo touch /var/www/index.html`

    Copy the content from the `html/index.html` file into the `index.html` on the server

    `scp -i mykeypair.pem html/index.html ec2-user@<public-dns-hostname>:/var/www/html`

4. Start Apache

    `sudo service httpd start`

5. Open the web page

    `http://<public-dns-hostname>`

6. Copy screen shots to server

    Take screen shot of EBS mount volume

    `scp -i mykeypair.pem html/screen-shot1.png ec2-user@<public-dns-hostname>:/var/www/html`

    Take screen shot of index.html residing in the EBS

    `scp -i mykeypair.pem html/screen-shot2.png ec2-user@<public-dns-hostname>:/var/www/html`

# Resources

- [Finding an AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-an-ami-console)
- [Block Device Mapping](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/block-device-mapping-concepts.html)
- [Shrink Size of an AMI](https://cloudership.com/blog/2017/5/28/shrink-the-size-of-an-ami)
- [EC2 SSH Access](https://medium.com/@hmalgewatta/setting-up-an-aws-ec2-instance-with-ssh-access-using-terraform-c336c812322f)
- [EC2 Quick Start](https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/QuickStartEC2Instance.html)
- [Key Pair Terraform](http://2ninjas1blog.com/terraform-assigning-an-aws-key-pair-to-your-ec2-instance-resource/)
- [Apache EC2](https://docs.aws.amazon.com/efs/latest/ug/wt2-apache-web-server.html)
- [EBS Volumes](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/ebs-using-volumes.html)