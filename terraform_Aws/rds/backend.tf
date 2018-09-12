terraform {
  backend "s3" {
    bucket = "prod.psss"
    key    = "prod.psss"
    region = "us-east-2"
  }
}
