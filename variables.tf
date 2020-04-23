variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-a"
}

variable "vpc" {
  default = {
    name                    = "test"
    routing                 = "GLOBAL" #GLOBAL|REGIONAL
    auto_create_subnetworks = true
  }

}


variable "secure_rules" {
  type = object({
    protocol = string
    sources  = list(string)
    ports    = list(string)
    }
  )
  default = {
    protocol = "tcp"
    sources  = []
    ports = [
      22,  #ssh
      3389 #rdp
    ]
  }

}


variable "public_rules" {
  type = object({
    protocol = string
    targets  = list(string)
    ports    = list(string)
    }
  )
  default = {
    protocol = "tcp"
    targets = [
      "http-server"
    ]
    ports = [
      80, #http
      443 #https
    ]
  }

}

variable "private_rules" {
  type = object({
    protocol = string
    targets  = list(string)
    sources  = list(string)
    ports    = list(string)
    }
  )
  default = {
    protocol = "tcp"
    targets = [
      "managed-services"
    ]
    sources = [
      "application-server"
    ]
    ports = [
      3306, #MySQL
      2049  #NFS
    ]
  }

}
