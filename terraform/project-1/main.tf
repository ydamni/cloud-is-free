terraform {

  required_version = "1.1.8"

  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "4.10.0"

    }
  }

}

# Configure the AWS Provider
provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["~/.aws/credentials"]
  profile                  = "default"
}
