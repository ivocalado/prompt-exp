terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # State remoto no bucket provisionado por terraform/dev.
  # Aplique terraform/dev antes deste ambiente, senao o bucket nao existe.
  #
  # Blocos backend nao aceitam variaveis, entao o perfil AWS nao pode vir de
  # terraform.tfvars como nas demais configuracoes. Ele fica em backend.hcl
  # (fora do git), carregado no init:
  #
  #   terraform init -backend-config=backend.hcl
  #
  # Ver backend.hcl.example.
  backend "s3" {
    bucket       = "prompt-exp-tfstate-226646167425"
    key          = "prod/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true # lock nativo do S3, dispensa tabela DynamoDB
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = "prod"
      ManagedBy   = "terraform"
      Repository  = "prompt-exp"
    }
  }
}
