resource "aws_eip" "node" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}

resource "aws_eip" "node2" {
  instance = "${aws_instance.web2.id}"
  vpc      = true
}

resource "aws_eip" "node3" {
  instance = "${aws_instance.web3.id}"
  vpc      = true
}
