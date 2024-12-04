#variable "name" {
 # type        = string
 # description = "name tag value"
#}

#variable "tags" {
  #type        = map(any)
  #description = "tags for the vpc module"
#}

#resource "aws_iam_role" "iam_role" {
 # name = join("", [var.name, "-", "iam-role"])

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
 # assume_role_policy = jsonencode({
    #Version = "2012-10-17"
   # Statement = [
      #{
       # Action = "sts:AssumeRole"
       # Effect = "Allow"
       # Sid    = ""
        #Principal = {
         # Service = "ec2.amazonaws.com"
        #}
      #},
    #]
  #})

  #inline_policy{
   # name = join("", [var.name, "-", "iam-policy"])

   # policy = jsonencode({
      #Version = "2012-10-17"
      #Statement = [
       # {
         # Action = [
           # "logs:CreateLogStream",
           # "logs:DescribeLogStreams",
           # "logs:CreateLogGroup",
           # "logs:PutLogEvents"

         # ]
          #Effect   = "Allow"
          #Resource = "*"
        #},
      #]
    #})
  #}

 # tags = var.tags
#}


variable "name" {
  type        = string
  description = "name tag value"
}

variable "tags" {
  type        = map(string)
  description = "tags for the vpc module"
  default     = {}
}

resource "aws_iam_role" "iam_role" {
  name = "${var.name}-iam-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = var.tags

  inline_policy {
    name = "${var.name}-iam-policy"

    policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = [
            "logs:CreateLogStream",
            "logs:DescribeLogStreams",
            "logs:CreateLogGroup",
            "logs:PutLogEvents"
          ]
          Effect   = "Allow"
          Resource = "*"
        },
      ]
    })
  }
}



