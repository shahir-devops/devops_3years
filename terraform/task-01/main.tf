resource "aws_instance" "name"{
  ami = var.amiid
  instance_type = var.type
  key_name = var.keyname
  tags = var.names
}   
variable "names" {
  type = map(string)
  default = {
    env = "dev"
    app = "prod"
  }
}