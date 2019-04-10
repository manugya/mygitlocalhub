
#VPC Creation
resource "aws_vpc" "manuvpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags {
    Name = "mainmanuvpc"
  }
}


#Subnet Creation
resource "aws_subnet" "manugyapublicsub" {
  vpc_id     = "${aws_vpc.manuvpc.id}"
  cidr_block = "10.0.1.0/24"

  tags {
    Name = "Mainmanusubnet1"
  }

 }
 
  
  #Subnet Creation
resource "aws_subnet" "manugyaprivatesub" {
  vpc_id     = "${aws_vpc.manuvpc.id}"
  cidr_block = "10.0.2.0/24"

  tags {
    Name = "Mainmanusubnet2"
  }
}

#Creation of application host

resource "aws_instance" "manugya-604990-app" {
    ami = "ami-a9d09ed1"
    instance_type = "t2.micro"
	disable_api_termination = true
	subnet_id = "${aws_subnet.manugyaprivatesub.id}"
	key_name= "manugya_604990"
    vpc_security_group_ids = ["${aws_security_group.manugyamainvpc.id}"]
	root_block_device {
		volume_type="gp2"
		volume_size="30"
	}
    tags {
        Name = "manugyaApplication"
    }
}