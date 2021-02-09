
#Place a load balancer for WebApp- front end
resource "aws_elb" "App-load-balancer" {
  name = "Prod-Application-LoadBalancer"
  internal = false
  security_groups = [aws_security_group.alb-security-group.id]
  subnets = [
    data.terraform_remote_state.network-configuration.outputs.public_subnet_1_id,
    data.terraform_remote_state.network-configuration.outputs.public_subnet_2_id
  ]

  listener {
    instance_port = 80
    instance_protocol = "HTTP"
    lb_port = 80
    lb_protocol = "HTTP"
  }

  health_check {
    healthy_threshold = 5
    interval = 30
    target = "HTTP:80/"
    timeout = 10
    unhealthy_threshold = 5
  }
}