terraform {
  backend "s3" {
    #Code for uploading .tfstate to Remote s3 bucket
    #Name of s3 bucket you created
    bucket = "terraform-remote-state-09-02-2021"
    key    = "acklenstate.tfstate"
    region = "us-east-1"
    #you have to mention keys here , it wont work if you put in providers.tf - open bug with terraform
    secret_key  = "AlAwmvlciOON8eM9eMbN6cxi7UoT8XXs1ze1M4ud"
    access_key = "AKIA2EAYPSKUCUG3XBEB"

    # Code to lock the remote .tfstate
    #To lock the remote state file in S3 bucket , create a dynamodb table
    # and create a primary key 'LockID'
    dynamodb_table = "statelock_table_dynamo"
  }
}