provider "aws" {
  region = "eu-west-2"
  profile = "personal"
}

provider "aws" {
  alias = "us_east_1"
  region = "us-east-1"
  profile = "personal"
}
