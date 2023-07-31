resource "aws_instance" "ec2-public" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  vpc_security_group_ids      = [var.sg-public.id]
  subnet_id                   = var.subnet-public.id
  associate_public_ip_address = true

  user_data = file("user_data.sh")

  depends_on = [var.igw]

  tags = {
    Name = "ec2-public"
  }
}

resource "aws_instance" "ec2-private" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [var.sg-public.id] # for test - using same sg
  subnet_id              = var.subnet-private.id

  tags = {
    Name = "ec2-private"
  }

}
