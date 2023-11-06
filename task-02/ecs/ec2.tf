resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-template"
  image_id      = "ami-053b0d53c279acc90"
  instance_type = "t3.micro"

  key_name               = "aws-test"
  vpc_security_group_ids = [data.terraform_remote_state.vpc.outputs.security_group_id]
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")
}
