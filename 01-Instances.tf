resource "aws_instance" "web" {
  count                       = "1"
  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "${var.instance_size}"
  associate_public_ip_address = "true"
  security_groups             = ["${aws_security_group.node.name}"] # This parameter is submitted as a [list] even if only 1 reference
  key_name                    = "${var.key_name}"

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "${var.ssh_user}"
      private_key = "${file("${var.ssh_key_path}")}"
    }

    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates  curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce=17.03.0~ce-0~ubuntu-xenial",
      "sudo docker swarm init",
      "sudo docker swarm join-token --quiet worker > /home/ubuntu/token",
    ]
  }

  tags {
    Name = "${var.instance_name}-1"
  }
}

resource "aws_instance" "web2" {
  count                       = "1"
  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "${var.instance_size}"
  associate_public_ip_address = "true"
  security_groups             = ["${aws_security_group.node.name}"] # This parameter is submitted as a [list] even if only 1 reference
  key_name                    = "${var.key_name}"

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${file("${var.ssh_key_path}")}"
  }

  provisioner "file" {
    source      = "${var.ssh_key_path}"
    destination = "/home/ubuntu/test.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates  curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce=17.03.0~ce-0~ubuntu-xenial",
      "sudo chmod 400 /home/ubuntu/test.pem",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/ubuntu/test.pem ubuntu@${aws_instance.web.private_ip}:/home/ubuntu/token .",
      "sudo docker swarm join --token $(cat /home/ubuntu/token) ${aws_instance.web.private_ip}:2377",
    ]
  }

  tags {
    Name = "${var.instance_name}-2"
  }
}

resource "aws_instance" "web3" {
  count                       = "1"
  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "${var.instance_size}"
  associate_public_ip_address = "true"
  security_groups             = ["${aws_security_group.node.name}"] # This parameter is submitted as a [list] even if only 1 reference
  key_name                    = "${var.key_name}"

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${file("${var.ssh_key_path}")}"
  }

  provisioner "file" {
    source      = "${var.ssh_key_path}"
    destination = "/home/ubuntu/test.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y apt-transport-https ca-certificates  curl software-properties-common",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
      "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
      "sudo apt-get update",
      "sudo apt-get install -y docker-ce=17.03.0~ce-0~ubuntu-xenial",
      "sudo chmod 400 /home/ubuntu/test.pem",
      "sudo scp -o StrictHostKeyChecking=no -o NoHostAuthenticationForLocalhost=yes -o UserKnownHostsFile=/dev/null -i /home/ubuntu/test.pem ubuntu@${aws_instance.web.private_ip}:/home/ubuntu/token .",
      "sudo docker swarm join --token $(cat /home/ubuntu/token) ${aws_instance.web.private_ip}:2377",
    ]
  }

  tags {
    Name = "${var.instance_name}-3"
  }
}

resource "aws_instance" "drone" {
  count                       = "1"
  ami                         = "${data.aws_ami.amazon.id}"
  instance_type               = "${var.instance_size}"
  associate_public_ip_address = "true"
  user_data                   = "${data.template_file.drone.rendered}"
  security_groups             = ["${aws_security_group.node.name}"]    # This parameter is submitted as a [list] even if only 1 reference
  key_name                    = "${var.key_name}"

  connection {
    type        = "ssh"
    user        = "${var.ssh_user}"
    private_key = "${file("${var.ssh_key_path}")}"
  }
  
  provisioner "file" {
    source      = "Userdata/docker-compose.yml"
    destination = "/home/ubuntu/docker-compose.yml"
  }

  provisioner "file" {
    source      = "Userdata/bash_profile"
    destination = "/home/ubuntu/.bash_profile"
  }

  provisioner "remote-exec" {
    inline = [
     "sudo apt-get update",
     "sudo apt-get install -y apt-transport-https ca-certificates  curl software-properties-common",
     "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -",
     "sudo add-apt-repository \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\"",
     "sudo apt-get update",
     "sudo apt-get install -y docker-ce=17.03.0~ce-0~ubuntu-xenial",
     "usermod -aG docker ubuntu",
     "su - ubuntu -c \"docker-compose up -d\" ",
     ]
  }


  tags {
    Name = "Drone-host"
  }
}
