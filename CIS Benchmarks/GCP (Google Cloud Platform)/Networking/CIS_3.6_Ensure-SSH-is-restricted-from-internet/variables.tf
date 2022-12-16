variable "networkname" {
  type = string
  default = "my-network"  
}

variable "firewallname" {
  type = string
  default = "my-firewall"
}

variable "sourceranges" {
  type = list
  default = [ "0.0.0.0/0" ]
}

variable "Protocol" {
  type = string
  default = "tcp"
}

variable "Ports" {
  type = list
  default = ["22"]
}