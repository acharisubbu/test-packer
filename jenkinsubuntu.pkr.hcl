packer {
  required_plugins {
    amazon = {
      version = ">=1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  access_key    = "AKIAW3MEDX7Y35LL7C4U"
  secret_key    = "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"
  ami_name      = "Jenkins1"
  instance_type = "t2.small"
  region        = "ap-south-1"
  source_ami    = "ami-0f58b397bc5c1f2e8"
  ssh_username  = "ubuntu"
}

build {
  name    = "jenkins"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    inline = [
      "sudo apt update -y",
      "sudo apt install openjdk-11-jdk -y",
      "sudo apt install maven wget unzip -y",
      "curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null",
      "echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null",
      "sudo apt-get update -y",
      "sudo apt-get install jenkins -y",
      "sudo ufw enable ",
      "sudo ufw allow 8080/tcp"
      
    ]
  }


}
