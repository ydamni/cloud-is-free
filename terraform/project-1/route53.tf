resource "aws_route53_zone" "cif_project_com" {
  name    = "cif-project.com"
  comment = ""
}

resource "aws_route53_record" "domain" {
  name    = "cif-project.com"
  zone_id = aws_route53_zone.cif_project_com.id
  type    = "A"
  alias {
    name                   = aws_s3_bucket.cif_project_com.website_domain
    zone_id                = aws_s3_bucket.cif_project_com.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www_domain" {
  name    = "www.cif-project.com"
  zone_id = aws_route53_zone.cif_project_com.id
  type    = "A"
  alias {
    name                   = aws_s3_bucket.cif_project_com.website_domain
    zone_id                = aws_s3_bucket.cif_project_com.hosted_zone_id
    evaluate_target_health = false
  }
}


resource "aws_route53_record" "cif_project_com" {
  for_each = {
    for dvo in aws_acm_certificate.cif_project_com.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.cif_project_com.zone_id
}

resource "aws_acm_certificate_validation" "cif_project_com" {
  certificate_arn         = aws_acm_certificate.cif_project_com.arn
  validation_record_fqdns = [for record in aws_route53_record.cif_project_com : record.fqdn]
}
