resource "aws_s3_bucket" "cif_project_com" {
  bucket = "cif-project.com"
}

resource "aws_s3_bucket_acl" "cif_project_com_acl" {
  bucket = aws_s3_bucket.cif_project_com.id
  acl    = "public-read"
}

resource "aws_s3_bucket_website_configuration" "cif_project_com_configuration" {
  bucket = aws_s3_bucket.cif_project_com.bucket

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = aws_s3_bucket.cif_project_com.id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "PublicReadGetObject",
        "Effect" : "Allow",
        "Principal" : "*",
        "Action" : [
          "s3:GetObject"
        ],
        "Resource" : [
          "arn:aws:s3:::cif-project.com/*"
        ]
      }
    ]
  })

}
