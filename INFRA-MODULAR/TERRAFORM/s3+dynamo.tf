
terraform {
  backend "s3" {
    bucket         = "obligatorio-terraform-state"   # Nombre del bucket S3 
    key            = "global/s3/terraform.tfstate"   # Ruta dentro del bucket
    region         = "us-east-1"                     # Región donde está el bucket
    dynamodb_table = "terraform-lock"                # Tabla DynamoDB para locking
    encrypt        = true                             # Encriptar el estado en S3
  }
}
