resource "aws_acm_certificate" "cif_project_com" {
  domain_name               = "cif-project.com"
  subject_alternative_names = ["www.cif-project.com"]
  validation_method         = "DNS"
}
