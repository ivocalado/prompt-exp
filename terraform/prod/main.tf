data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  filter {
    name   = "default-for-az"
    values = ["true"]
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

# AMI Amazon Linux 2023 resolvida via SSM, evitando fixar um id que expira
# a cada release.
data "aws_ssm_parameter" "al2023" {
  name = "/aws/service/ami-amazon-linux-latest/al2023-ami-kernel-default-x86_64"
}

locals {
  # Mapa AZ -> subnet id. Cada instancia escolhe sua AZ pelo nome, o que
  # deixa o posicionamento explicito e estavel (indices de lista mudariam
  # de significado se a AWS adicionasse uma subnet default).
  subnet_by_az = {
    for s in data.aws_subnet.default : s.availability_zone => s.id
  }
}

###############################################################################
# Instancias EC2 do ambiente prod
#
# Cada instancia tem seu proprio bloco para permitir configuracao individual
# (tipo, disco, AZ, user_data, tags) sem afetar as demais.
#
# Atencao: us-east-1e nao oferece t3.nano. Se for mover alguma instancia para
# essa AZ, troque tambem o instance_type.
###############################################################################

resource "aws_instance" "ec2_01" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.nano"
  subnet_id     = local.subnet_by_az["us-east-1b"]

  metadata_options {
    http_tokens   = "required" # IMDSv2 obrigatorio
    http_endpoint = "enabled"
  }

  tags = {
    Name = "prod-ec2-01"
  }
}

resource "aws_instance" "ec2_02" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.nano"
  subnet_id     = local.subnet_by_az["us-east-1a"]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "prod-ec2-02"
  }
}

resource "aws_instance" "ec2_03" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.nano"
  subnet_id     = local.subnet_by_az["us-east-1f"]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "prod-ec2-03"
  }
}

resource "aws_instance" "ec2_04" {
  ami           = data.aws_ssm_parameter.al2023.value
  instance_type = "t3.nano"
  subnet_id     = local.subnet_by_az["us-east-1c"]

  metadata_options {
    http_tokens   = "required"
    http_endpoint = "enabled"
  }

  tags = {
    Name = "prod-ec2-04"
  }
}

###############################################################################
