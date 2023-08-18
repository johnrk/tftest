resource "aws_instance" "my_vm" {
 ami                       = "ami-00c39f71452c08778"
 instance_type             = "t2.micro"

 tags = {
   Name = "My EC2 instance",
 }
}
