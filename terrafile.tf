data "external" "decrypted_secret" {
  program = ["sops", "--decrypt", "--output-type", "json", "${path.module}/secret.json.enc"]
}

module "pay2free_secret" {
  source      = "./modules/aws-secrets-manager-secrets"
  region      = "MyRegion"  
  secret_name = "MySecretName"
  
  secret_value = jsonencode(data.external.decrypted_secret.result)
}