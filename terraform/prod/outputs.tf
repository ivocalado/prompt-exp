output "instances" {
  description = "Detalhes de cada instancia EC2 do ambiente prod, por bloco."
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
    ec2_03 = {
      id            = aws_instance.ec2_03.id
      name          = aws_instance.ec2_03.tags["Name"]
      instance_type = aws_instance.ec2_03.instance_type
      az            = aws_instance.ec2_03.availability_zone
      private_ip    = aws_instance.ec2_03.private_ip
    }
  }
}
