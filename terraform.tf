terraform {
  required_version = "> 1.1.0"

  backend "remote" {
    hostname = "app.terraform.io"
    organization = "my-organization"

    workspaces {
      name = "secure-terraform"
    }
  }
}
