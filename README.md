# Projeto Terraform - Provisionamento de Secret no AWS Secrets Manager

Este projeto provisiona um secret no AWS Secrets Manager utilizando Terraform. Ele faz a utilização do SOPS e AWS KMS para gerenciar e proteger dados sensíveis.

## Estrutura do Projeto

- **terrafile.tf**: Arquivo principal que referência o módulo Terraform para criação do secret. Nele, o bloco `data "external"` chama o SOPS para descriptografar o arquivo `secret.json.enc` em tempo de execução.
- **modules/aws-secrets-manager-secrets/**: Módulo Terraform que contém os recursos para provisionar o secret no AWS Secrets Manager.
  - *main.tf*: Define os recursos `aws_secretsmanager_secret` e `aws_secretsmanager_secret_version`.
  - *variables.tf*: Define as variáveis utilizadas (como região, nome do secret e valor do secret).
  - *outputs.tf*: Exporta outputs relevantes (`secret_id` e `secret_arn`).
- **secret.json.enc**: Arquivo contendo os dados sensíveis criptografados utilizando o SOPS e AWS KMS.

## Como Funciona

1. **Criptografia dos Dados Sensíveis**
   - O arquivo `secret.json` contém os dados sensíveis, como credenciais e outros detalhes.
   - Este arquivo é criptografado com SOPS utilizando uma chave AWS KMS. Por exemplo:
     ```bash
     sops --encrypt --kms <sua_arn_aws>> > secret.json.enc
     ```
   - Apenas o arquivo criptografado (`secret.json.enc`) deve ser versionado no repositório, garantindo que os dados sensíveis nunca sejam expostos.

2. **Execução do Terraform**
   - No arquivo [terrafile.tf], o Terraform usa o bloco `data "external"` para executar o comando SOPS que descriptografa o [secret.json.enc] em tempo de execução. Isso garante que o secret seja aplicado apenas para usuários com acesso à chave KMS.
   - O módulo `aws-secrets-manager-secrets` é então chamado para provisionar o secret no AWS Secrets Manager com os dados descriptografados.
   

## Requisitos

- Terraform
- AWS CLI configurado com as permissões necessárias
- SOPS instalado e configurado para utilizar a chave AWS KMS
