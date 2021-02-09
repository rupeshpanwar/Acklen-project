#create Public SG to connect to internet
resource "aws_security_group" "ec2-public-security-group" {
  name = "EC2-Public-SG"
  description = "ssh , Internet reaching access for Ec2 instances"
  vpc_id = data.terraform_remote_state.network-configuration.outputs.vpc_id
  ingress {
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["132.154.18.55/32"]
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

