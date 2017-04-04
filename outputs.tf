output "elb_dns_name" {
  value = "${aws_elb.master.dns_name}"
}

output "web_ip" {
  value = "${aws_instance.web.private_ip}"
}

output "web2_ip" {
  value = "${aws_instance.web2.private_ip}"
}

output "web3_ip" {
  value = "${aws_instance.web3.private_ip}"
}

output "drone_ip" {
  value = "${aws_instance.drone.public_ip}"
}
