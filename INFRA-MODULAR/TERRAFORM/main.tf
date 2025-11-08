resource "aws_instance" "ac1-instance" {
  ami                    = var.ami
  instance_type          = "t2.micro"
  security_groups = [aws_security_group.ac1-sg.id]
  subnet_id = aws_subnet.ac1-private-subnet.id
  key_name               = "vockey"
  tags = {
    Name      = "ac1-instance"
    terraform = "True"

  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("/home/luis/AC2/ac2-terraform/llave.pem")
    host        = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [
      "sudo yum install -y httpd ",
      "git clone https://github.com/mauricioamendola/chaos-monkey-app.git",
      "sudo mv chaos-monkey-app/website/* /var/www/html/",
      "sudo systemctl enable httpd",
      "sudo systemctl start httpd",
      
    ]
  }
}
