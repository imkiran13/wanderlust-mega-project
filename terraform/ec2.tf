resource "aws_key_pair" "deployer" {
  key_name   = "terra-automate-key"
  public_key = file("C:/Users/Kiran Pawar/terra-key.pub")
}

resource "aws_default_vpc" "default" {

}

resource "aws_security_group" "allow_user_to_connect" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id

  # SSH Port 22
  ingress {
    description = "port 22 allow"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP Port 80
  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS Port 443
  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SonarQube Port 9000
  ingress {
    description = "SonarQube port 9000"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Redis Port 6379
  ingress {
    description = "Redis port 6379"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SMTP Port 25
  ingress {
    description = "SMTP port 25"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SMTPS Port 465
  ingress {
    description = "SMTPS port 465"
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Custom TCP Port 21017
  ingress {
    description = "Custom TCP port 21017"
    from_port   = 21017
    to_port     = 21017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Custom TCP Port Range 3000-10000
  ingress {
    description = "Custom TCP port range 3000-10000"
    from_port   = 3000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Custom TCP Port Range 30000-32767
  ingress {
    description = "Custom TCP port range 30000-32767"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Kubernetes Port 6443
  ingress {
    description = "Kubernetes port 6443"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = " allow all outgoing traffic "
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mysecurity"
  }
}


resource "aws_instance" "testinstance" {
  ami             = var.ami_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.deployer.key_name
  security_groups = [aws_security_group.allow_user_to_connect.name]
  tags = {
    Name = "Automate"
  }
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
}
