
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
  ami_name      = "Rahul-Packer-CWAgent-HCL"
  instance_type = "t3a.small"
  region        = "ap-south-1"
  secret_key    = "${var.secret_key}"
  source_ami    = "ami-0851b76e8b1bce90b"
  ssh_username  = "ubuntu"
  temporary_iam_instance_profile_policy_document {
    Statement {
      Action   = ["ssm:GetParameter"]
      Effect   = "Allow"
      Resource = ["arn:aws:ssm:*:*:parameter/AmazonCloudWatch-*"]
    }
    Version = "2012-10-17"
  }
}

build {
  sources = ["source.amazon-ebs.My_AMI"]

  provisioner "shell" {
    script = "config.sh"
  }

  post-processor "manifest" {
    output = "output.json"
  }
}
