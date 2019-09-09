# terraform-visitcounter
a demo of a web page counting visits using terraform on AWS

# Structure

- Flask Node
    - Flask running on port 8080
    - NGINX reverse proxy port 80 to port 8080
- Redis Node

# How to use

Get [Terraform](https://www.terraform.io/downloads.html). First time run, issue `terraform init`

## Create

- Issue `terraform apply`

## Destroy

- Issue `terraform destroy`

## Test

- ToDo

# Roadmap

## ToDo
- [] tests with kitchen

## Done

- [x] Initial commit