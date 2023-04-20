resource "aws_instance" "my_vm" {
 ami                       = "ami-04f1014c8adcfa670"
 instance_type             = "t2.micro"

 tags = {
   Name = "My EC2 instance",
 }
}
