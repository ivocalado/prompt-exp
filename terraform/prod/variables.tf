variable "aws_region" {
  description = "Regiao AWS."
  type        = string
  default     = "us-east-1"
}

# Sem default de proposito: o nome do perfil e informacao de ambiente e nao
# deve ser versionado. Defina em terraform.tfvars (fora do git).
variable "aws_profile" {
  description = "Perfil AWS local usado por este ambiente."
  type        = string
}

# Tipo e disco de cada instancia ficam declarados diretamente no seu bloco
# em main.tf, para permitir configuracao individual sem indirecao.
