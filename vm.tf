resource "aws_instance" "krastin-counter-vm-flask" {
  ami = "${data.aws_ami.flask.id}"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = "${aws_network_interface.krastin-counter-flask-int1.id}"
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
  }
  key_name = "krastin-key1"

  tags = {
    Name = "krastin-counter-vm-flask"
  }
}

resource "aws_network_interface" "krastin-counter-flask-int1" {
  subnet_id   = "${aws_subnet.krastin-counter-vpc-subnet-10-100.id}"
  private_ips = ["10.100.0.10"]
  security_groups = ["${aws_security_group.krastin-counter-vpc-sg-permit.id}"]

  depends_on = ["aws_security_group.krastin-counter-vpc-sg-permit", "aws_subnet.krastin-counter-vpc-subnet-10-100"]
}

resource "aws_instance" "krastin-counter-vm-redis" {
  ami = "${data.aws_ami.redis.id}"
  instance_type = "t2.micro"

  network_interface {
    network_interface_id = "${aws_network_interface.krastin-counter-redis-int1.id}"
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  connection {
    type = "ssh"
    user = "ubuntu"
  }
  key_name = "krastin-key1"

  tags = {
    Name = "krastin-counter-vm-redis"
  }
}

resource "aws_network_interface" "krastin-counter-redis-int1" {
  subnet_id   = "${aws_subnet.krastin-counter-vpc-subnet-10-100.id}"
  private_ips = ["10.100.0.11"]
  security_groups = ["${aws_security_group.krastin-counter-vpc-sg-permit.id}"]

  depends_on = ["aws_security_group.krastin-counter-vpc-sg-permit", "aws_subnet.krastin-counter-vpc-subnet-10-100"]
}

output "vm_flask_ssh_target" {
    value = "${aws_instance.krastin-counter-vm-flask.public_ip}"
    description = "IP to SSH into for FLASK VM"
    sensitive = false
}

output "vm_redis_ssh_target" {
    value = "${aws_instance.krastin-counter-vm-redis.public_ip}"
    description = "IP to SSH into for REDIS VM1"
    sensitive = false
}

data "aws_ami" "flask" {
    most_recent = true

    filter {
        name   = "name"
        values = ["krastin-xenial-flask-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["729476260648"] # Canonical
}

data "aws_ami" "redis" {
    most_recent = true

    filter {
        name   = "name"
        values = ["krastin-xenial-redis-*"]
    }

    filter {
        name   = "virtualization-type"
        values = ["hvm"]
    }

    owners = ["729476260648"] # Canonical
}