provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "eks_vpc" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "eks_subnet_1" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "eks_subnet_2" {
  vpc_id     = aws_vpc.eks_vpc.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_eks_cluster" "eks_cluster" {
  name     = "billing-app-cluster"
  role_arn = aws_iam_role.eks_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.eks_subnet_1.id, aws_subnet.eks_subnet_2.id]
  }
}

resource "aws_iam_role" "eks_role" {
  name = "eksClusterRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Effect = "Allow"
      }
    ]
  })
}
