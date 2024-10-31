resource "aws_instance" "jenkins" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name

  # User data to install Jenkins
  user_data = file("jenkins.sh")

  # Block device mapping for EBS
  root_block_device {
    volume_size = 30
  }

  tags = {
    Name = "Jenkins-server" # Replace with your desired tag name
  }

  security_groups = [aws_security_group.jenkins_sg.name]

  # Provisioner to output the Jenkins password to a known file
  provisioner "remote-exec" {
    inline = [
      "sleep 450", # Wait for Jenkins to start
      "sudo cat /var/lib/jenkins/secrets/initialAdminPassword > /tmp/jenkins_password.txt"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu" # Use the appropriate user for your AMI
      private_key = file("${path.module}/awskey.pem")
      host        = self.public_ip
    }
  }

  # Local-exec provisioner to capture the password locally
  provisioner "local-exec" {
    command = "scp -i ${path.module}/awskey.pem -o StrictHostKeyChecking=no ubuntu@${self.public_ip}:/tmp/jenkins_password.txt ./jenkins_password.txt"

  }
}

