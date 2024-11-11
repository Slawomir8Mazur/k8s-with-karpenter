terraform {
  backend "s3" {
    key = "eks_state"
    # Adjust values below
    bucket = "state-bucket-tf-225989361974"
    region = "eu-west-1"
  }
}