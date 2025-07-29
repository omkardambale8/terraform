resource "aws_iam_role" "cw_agent-role" {
  name="CWAgentRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cloudwatch-attach" {
  role = aws_iam_role.cw_agent-role.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"

}

resource "aws_iam_instance_profile" "cw_agent_profile" {
  name = "CWAgentProfile"
  role= aws_iam_role.cw_agent-role.name
}