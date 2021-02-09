#public autoscaling group
resource "aws_autoscaling_group" "ec2-app-autoscaling-group" {
  name = "Production-App-AutoScalingGroup"
  vpc_zone_identifier = [
    data.terraform_remote_state.network-configuration.outputs.public_subnet_1_id,
    data.terraform_remote_state.network-configuration.outputs.public_subnet_2_id
  ]

  max_size = var.max_instance_size
  min_size = var.min_instance_size
  launch_configuration = aws_launch_configuration.ec2_public_launch_configuration.name
  health_check_type = "ELB"
  load_balancers = [aws_elb.App-load-balancer.name]

  tag {
    key = "Name"
    propagate_at_launch = false
    value = "App-EC2-Instance"
  }
  tag {
    key = "Type"
    propagate_at_launch = false
    value = "Application"
  }
}