resource "aws_iam_role_policy" "beanstalk_policy" {
  name = "beanstalk_policy"
  role = aws_iam_role.role_for_beanstalk.id

  policy = file("${path.module}/policy/policy.json")
}

resource "aws_iam_role" "role_for_beanstalk" {
  name = "beanstalk-role"

  assume_role_policy = file("${path.module}/policy/assume_role_policy.json")

}
