# Set ENV before using this file
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


source "amazon-ebs" "My_AMI" {
  access_key    = "${var.access_key}"
  ami_name      = "Rahul-Packer-Nginx-vHCL"  #Name of new AMI
  instance_type = "t3a.small"
  region        = "ap-south-1"
  secret_key    = "${var.secret_key}"
  source_ami    = "ami-0851b76e8b1bce90b" #source AMI Name
  ssh_username  = "ubuntu" #User to ssh in Build instance
}

# A build block invokes sources and runs provisioning steps on them.
build {
  sources = ["source.amazon-ebs.My_AMI"]

  provisioner "shell" {     #Shell script type provisioner to specify cmds
    script = "config.sh"
  }

  provisioner "file" {     ##File provisioner to copy files from local to remote
    destination = "/tmp/"
    source      = "index.html"
  }

  provisioner "shell" {     #Shell Inline type provisioner to specify cmds
    inline = ["sudo cp /tmp/index.html /var/www/html/"]
  }

  post-processor "manifest" {  #Contains info about artifacts
    output = "output.json"
  }
}
