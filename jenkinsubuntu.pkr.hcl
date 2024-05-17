packer {
  required_plugins {
    amazon = {
      version = ">=1.2.1"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  access_key    = "AKIA5FTZC462EDGTMU4F"
  secret_key    = "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"
  ami_name      = "Jenkins"
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
