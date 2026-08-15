terraform {
  required_version = ">= 1.5"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # Ambiente dev mantem o state em disco. E este ambiente que provisiona
  # o bucket usado como backend remoto do ambiente prod, entao ele nao
  # pode depender desse bucket para existir.
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile

  default_tags {
    tags = {
      Environment = "dev"
      ManagedBy   = "terraform"
      Repository  = "prompt-exp"
    }
  }
}
