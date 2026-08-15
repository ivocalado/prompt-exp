output "instances" {
  description = "Detalhes de cada instancia EC2 do ambiente dev, por bloco."
  value = {
    ec2_01 = {
      id            = aws_instance.ec2_01.id
      name          = aws_instance.ec2_01.tags["Name"]
      instance_type = aws_instance.ec2_01.instance_type
      az            = aws_instance.ec2_01.availability_zone
      private_ip    = aws_instance.ec2_01.private_ip
    }
    ec2_02 = {
      id            = aws_instance.ec2_02.id
      name          = aws_instance.ec2_02.tags["Name"]
      instance_type = aws_instance.ec2_02.instance_type
      az            = aws_instance.ec2_02.availability_zone
      private_ip    = aws_instance.ec2_02.private_ip
    }
    ec2_04 = {
      id            = aws_instance.ec2_04.id
      name          = aws_instance.ec2_04.tags["Name"]
      instance_type = aws_instance.ec2_04.instance_type
      az            = aws_instance.ec2_04.availability_zone
      private_ip    = aws_instance.ec2_04.private_ip
    }
  }
}

output "state_bucket_name" {
  description = "Bucket S3 usado como backend remoto do ambiente prod."
  value       = aws_s3_bucket.tfstate.id
}

output "state_bucket_arn" {
  description = "ARN do bucket de state remoto."
  value       = aws_s3_bucket.tfstate.arn
}
