provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}


resource "aws_instance" "exch_web_server" {
  ami               = "ami-053b0d53c279acc90"
  instance_type     = "t2.micro"
  availability_zone = "us-east-1a"
  key_name          = "exchange_keys"

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.exch_interface.id
  }

  user_data = <<-EOF
            #! /bin/bash
            sudo apt update -y
            sudo apt install apache2 -y
            sudo systemctl start apache2
            sudo bash -c 'Welcome to the exchange server"
            cd /home/ubuntu
            sudo mkdir python-json-env
            cd python-json-env
            sudo touch exchange.json

            EOF
}
