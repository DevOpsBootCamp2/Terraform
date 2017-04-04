data "template_file" "node" {
  template = "${file("${path.module}/Userdata/userdata.sh")}"
}

#data "template_file" "node2" {
#  template = "${file("${path.module}/Userdata/userdata2.sh")}"
#}

data "template_file" "manager" {
  template = "${file("${path.module}/Userdata/manager.sh")}"
}

data "template_file" "drone" {
  template = "${file("${path.module}/Userdata/drone.sh")}"
}

data "aws_ami" "amazon" {
  #  most_recent = true

  #  filter {  #    name   = "name"  #    values = ["amzn-ami-hvm-*"]  #  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name = "image-id"

    #values = ["ami-70edb016"] # amazon based on Fedora
    #values = ["ami-02ace471"] # redhat 7.3
    #values = ["ami-9186a1e2"] # suse
    values = ["ami-405f7226"] # ubuntu
  }

  #  owners = ["137112412989"] # Amazon
}

# These details were found in this command:
# aws ec2 describe-images --owners amazon --filters "Name=virtualization-type, Values=hvm" "Name=image-id, Values=ami-70edb016"

