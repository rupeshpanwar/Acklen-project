```
#Acklen-Devops-Project

Please find below solution to deploy the infra as a code

Part1 # 
Part 1 # Basic Networking components
A. Create project directory
B. Create Git repo and do first commit
C. Create a bucket and DynamoDB
D. Create config file(Provider) and remote state config(S3)
E. Create VPC
F. Create public subnet
G. Create public route table
H. Now Create internet gateway and bind with public route table to allow public access

```
```
A. Create project directory

#step to create directory structure
 mkdir Acklen-Devops-Project
 cd Acklen-Devops-Project
 mkdir infrastructure   
 mkdir instances    

#initialise the git and commit initial setup
git init  
echo "#Acklen-Devops-Project" >> README.md
```
```
#create .gitignore file
Touch .gitignore
#login into gitignore.io and generate the code for terraform and add the same in 
#.gitignore file to add this file under project directory, now directory structure would look like below
￼

#run below command for initial commit 
Git add .
Git status 
git commit -m "first commit: “directory structure

B. Create Git repo
￼

#now add a remote origin and push the code
git branch -M main
git remote add origin https://github.com/rupeshpanwar/Acklen-Devops-Aws.git
git push -u origin main



C. Create a S3 bucket to host “tfstate” file

 1. Create S3 bucket
 2. Create Dynamodb table
￼
￼

D.  Create config file(Provider) and remote state config(S3)
Note # to input the region / S3 bucket details where we will store tfstate file

#create provider.tf file 
touch provider.tf 

#mention below code and save
provider "aws" {
  region = "us-east-1"
}

#create backend.tf, having remote storage and table information
terraform {
  backend "s3" {
    #Code for uploading .tfstate to Remote s3 bucket
    #Name of s3 bucket you created
    bucket = "terraform-remote-state-09-02-2021"
    key    = "acklenstate.tfstate"
    region = "us-east-1"
    #you have to mention keys here , it wont work if you put in providers.tf - open bug with terraform
    secret_key  = “secret_key”
    access_key = “access”_key”

    # Code to lock the remote .tfstate
    #To lock the remote state file in S3 bucket , create a dynamodb table
    # and create a primary key 'LockID'
    dynamodb_table = "statelock_table_dynamo"
  }
}



#now initialise terraform to initialise the backend, provider plugins provisioner
Cd infrastructure
Terraform init

# here now , how it looks like
￼

#add backend.tf to .gitignore , now let us commit the latest changes
Git status
Git add .
Git commit -m "initialize the backend"
Git push

E. Create VPC with cidr 10.0.0.0/16
Note # we would be using variables wherever possible to have
 # flexibility during run time and output file to look into result and #consume in required components
    
#create 4 files , vpc.tf , variables.tf and output.tf
Touch vpc.tf
Touch variables.tf
Touch output.tf
Touch production.tfvars

# let us code for vpc.tf 
resource "aws_vpc" "production-vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = "Production-VPC"
  }
}

#code for variables.tf
variable "vpc_cidr" {
  default = "10.0.0.0/16"
  description = "production vpc cidr"
}

#code for output.tf
output "vpc_id" {
  value = aws_vpc.production-vpc.id
}

#code for production.tfvars
vpc_cidr = "10.0.0.0/16"


#let us run terraform cmd to commit the changes
Terraform init

 terraform plan --var-file="production.tfvars" # to look for what resources will be created

# eg
Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vpc_id = (known after apply)

#once above command return expected information and no #validation issue 

Terraform apply  --var-file="production.tfvars —auto-approve

#here is the result looks like
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

vpc_id = "vpc-0d281766fd63fbfab"

#Console output
￼

#commit the changes to git
   git status
   git add .
   git commit -m "Create VPC"
   git push


F. Create public subnets

#create subnets.tf file

Touch subnets.tf

#code for subnet creation

resource "aws_subnet" "public-subnets" {
  count = length(var.public_subnet_cidr)
  vpc_id     = aws_vpc.production-vpc.id
  cidr_block = element(var.public_subnet_cidr,count.index)
  availability_zone = element(var.availability_zone,count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = element(var.public_subnet_names,count.index)
  }
  depends_on = [aws_vpc.production-vpc]
}



#here are the vars for subnets
variable "public_subnet_cidr" {
  type = list(string)
}

variable "availability_zone" {
  type = list(string)
}

variable "public_subnet_names" {
  type = list(string)
}

#here are the varfile to be produced during run time
vpc_cidr = "10.0.0.0/16"
public_subnet_cidr = ["10.0.1.0/24","10.0.2.0/24"]
public_subnet_names = ["Public-Subnet-1a","Public-Subnet-1b"]
availability_zone = ["us-east-1a","us-east-1b"]


#let us run the terraform cmd

#plan
 terraform plan --var-file="production.tfvars"

#apply
 terraform apply --var-file="production.tfvars" —auto-approve

#Console output
￼

￼

#commit the changes to git
   git status
   git add .
   git commit -m “Create subnets”
   git push



G. Create public route table

#Create routteable.tf 
Touch routetable.tf

#code for route table
resource "aws_route_table" "public-route-table1" {
  vpc_id = aws_vpc.production-vpc.id
  tags = {
    Name = "Public-Route-Table-Subnet-1"
  }
}
resource "aws_route_table_association" "public-subnet-1-associate" {
  route_table_id = aws_route_table.public-route-table1.id
  subnet_id = aws_subnet.public-subnets[0].id
}

resource "aws_route_table" "public-route-table2" {
  vpc_id = aws_vpc.production-vpc.id
  tags = {
    Name = "Public-Route-Table-Subnet-2"
  }
}
resource "aws_route_table_association" "public-subnet-2-associate" {
  route_table_id = aws_route_table.public-route-table2.id
  subnet_id = aws_subnet.public-subnets[1].id
}


#implement the changes

 terraform plan --var-file="production.tfvars"
 terraform apply --var-file="production.tfvars" --auto-approve

#console output
￼
￼


#commit the changes to git
   git status
   git add .
   git commit -m “Create Route Tables”
   git push


H. Now Create internet gateway and bind with public route table to allow public access

#create new file igw.tf 
Touch igw.tf

#code for igw.tf
#Resource mapping from public subnet to internet
#create internet gateway
resource "aws_internet_gateway" "production-igw" {
  vpc_id = aws_vpc.production-vpc.id

  tags = {
    Name = "Production-IGW"
  }
}

#create route for public subnet
resource "aws_route" "public-internet-gw-route-public-subnet1" {
  route_table_id = aws_route_table.public-route-table1.id
  gateway_id = aws_internet_gateway.production-igw.id
  destination_cidr_block = "0.0.0.0/0"
}
resource "aws_route" "public-internet-gw-route-public-subnet2" {
  route_table_id = aws_route_table.public-route-table2.id
  gateway_id = aws_internet_gateway.production-igw.id
  destination_cidr_block = "0.0.0.0/0"
}



#implement the changes

 terraform plan --var-file="production.tfvars"
 terraform apply --var-file="production.tfvars" --auto-approve

#console output

#commit the changes to git
   git status
   git add .
   git commit -m “Create igw,mapped public subnets”
   git push

￼```
￼
￼
