resource "aws_instance" "us2204" {
  ami           = "ami-097a2df4ac947655f"
  instance_type = "t2.micro"
  vpc_security_group_ids = [
    aws_security_group.us2204-dumb-web.id
  ]

  tags = {
    "Name"            = "us-22.04-dumb-web-on-8080"
    "OS Version"      = "22.04"
    "OS Distribution" = "Ubuntu"

  }

  user_data = <<-EOF
            #!/bin/bash
            echo 'Hi there!' > index.html
            nohup busybox httpd -f -p ${var.server_port} &
            EOF

  user_data_replace_on_change = true
}

resource "aws_security_group" "us2204-dumb-web" {
  name = "us2204-dumb-web"
  ingress {
    from_port = var.server_port
    to_port   = var.server_port
    protocol  = "tcp"
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}
