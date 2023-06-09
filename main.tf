resource "aws_instance" "my_vm" {
 ami                       = "ami-04f1014c8adcfa670"
 instance_type             = "t2.micro"
 disable_api_termination   = true
 iam_instance_profile = "${aws_iam_instance_profile.new_profile.name}"

 root_block_device {
   encrypted = true
 }

 tags = {
   Name = "My EC2 instance",
 }

 metadata_options {
    http_endpoint = "disabled"
    http_tokens   = "required"
  }
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "role" {
  name               = "test_role"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_instance_profile" "new_profile" {
  name = "new_profile"
  role = aws_iam_role.role.name
}
