terraform {
  # Specifies the minimum required version of Terraform.
  required_version = ">= 1.3"

  required_providers {
    google = {
      source = "hashicorp/google"
      # Specifies the required version of the Google Cloud provider.
      version = ">= 4.53.0"
    }
  }
}
