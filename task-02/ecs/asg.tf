resource "aws_autoscaling_group" "ecs_asg" {
  vpc_zone_identifier = [data.terraform_remote_state.vpc.outputs.subnet1_id, data.terraform_remote_state.vpc.outputs.subnet2_id]
  desired_capacity    = 1
  max_size            = 3
  min_size            = 1

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
