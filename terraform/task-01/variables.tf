variable "amiid" {
  description = "ami of the image"
  type = string
  default = ""
}
variable "type" {
    description = "instance type of the server"
    type = string
    default = ""
}
variable "keyname" {
    description = "key name of the server"
    type = string
    default = ""
}
