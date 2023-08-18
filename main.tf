resource "aws_instance" "my_vm" {
 ami                       = "ami-00c39f71452c08778"
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
  name               = "test_role4"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

resource "aws_iam_instance_profile" "new_profile" {
  name = "new_profile5"
  role = aws_iam_role.role.name
}
