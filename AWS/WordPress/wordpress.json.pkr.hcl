
variable "access_key" {
  type      = string
  default   = "${env("ACCESS_KEY")}"
  sensitive = true
}

variable "secret_key" {
  type      = string
  default   = "${env("SECRET_KEY")}"
  sensitive = true
}

source "amazon-ebs" "My_Wordpress" {
  access_key    = "${var.access_key}"
  ami_name      = "Rahul-Packer-WordPress-v1"
  instance_type = "t3a.small"
  region        = "ap-south-1"
  secret_key    = "${var.secret_key}"
  source_ami    = "ami-0851b76e8b1bce90b"
  ssh_username  = "ubuntu"
}

build {
  sources = ["source.amazon-ebs.My_Wordpress"]

  provisioner "shell" {
    script = "config1.sh"
  }

  provisioner "file" {
    destination = "/tmp/"
    source      = "wordpress-nginx-conf"
  }

  provisioner "shell" {
    script = "config2.sh"
  }

  post-processor "manifest" {
    output = "output.json"
  }
}
