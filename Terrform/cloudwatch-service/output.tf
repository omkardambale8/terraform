output "ec2_public_ip" {
  value = aws_instance.monitored_ec2.public_ip
}

output "sns_topic" {
  value = aws_sns_topic.alerts.arn
}
