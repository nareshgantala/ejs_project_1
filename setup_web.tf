provider "aws" {
  region = "us-east-1"
}

data "aws_instances" "existing_instance" {
  filter {
    name   = "tag:Name"
    values = ["Jenkins"]  # Replace with your EC2 instance Name tag
  }
}

resource "null_resource" "ansible_playbook" {
  provisioner "local-exec" {
    command = <<-EOF
      ansible-playbook -i ${data.aws_instance.existing_instance.public_ip}, setup_ejs.yml -e "ansible_user=centos ansible_password=DevOps321"
    EOF
  }

  depends_on = [data.aws_instance.existing_instance]
}
