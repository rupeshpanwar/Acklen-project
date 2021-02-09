data "terraform_remote_state" "network-configuration" {
  config = {
    bucket = var.remote_state_bucket
    key = var.remote_state_key
    region = var.region
  }
  backend = "s3"
}

//
//#find the latest AWS AMI
//data "aws_ami" "launch_configuration_ami" {
//  most_recent = true
//
//  filter {
//    name = "owner-alis"
//    values = ["amazon"]
//  }
//  owners = ["amazon"]
//}
//
//#EC2 instance (public)- launch configuration
//resource "aws_launch_configuration" "ec2_public_launch_configuration" {
//  image_id                    = "ami-047a51fa27710816e"
//  instance_type               = var.ec2_instance_type
//  key_name                    = var.key_pair_name
//  associate_public_ip_address = false
//  iam_instance_profile        = aws_iam_instance_profile.ec2-instance-profile.name
//  security_groups             = [aws_security_group.ec2-public-security-group.id]
//
//  user_data = <<EOF
//    #!/bin/bash
//    yum update -y
//    yum install httpd -y
//    service httpd start
//    chkconfig httpd on
//    export INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
//    echo "<html><body><h1>Hello from Production WebApp at instance <b>"$INSTANCE_ID"</b></h1></body></html>" > /var/www/html/index.html
//  EOF
//}

