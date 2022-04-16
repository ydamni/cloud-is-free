# Project-1

Terraform files for Project 1 on https://cloudisfree.com

## Cost estimate

```

 Name                                                             Monthly Qty  Unit                    Monthly Cost

 aws_cloudfront_distribution.s3_distribution
 ├─ Invalidation requests (first 1k)                        Monthly cost depends on usage: $0.00 per paths
 └─ US, Mexico, Canada
    ├─ Data transfer out to internet (first 10TB)           Monthly cost depends on usage: $0.085 per GB
    ├─ Data transfer out to origin                          Monthly cost depends on usage: $0.02 per GB
    ├─ HTTP requests                                        Monthly cost depends on usage: $0.0075 per 10k requests
    └─ HTTPS requests                                       Monthly cost depends on usage: $0.01 per 10k requests

 aws_route53_record.cif_project_com["cif-project.com"]
 ├─ Standard queries (first 1B)                             Monthly cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                Monthly cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                              Monthly cost depends on usage: $0.70 per 1M queries

 aws_route53_record.cif_project_com["www.cif-project.com"]
 ├─ Standard queries (first 1B)                             Monthly cost depends on usage: $0.40 per 1M queries
 ├─ Latency based routing queries (first 1B)                Monthly cost depends on usage: $0.60 per 1M queries
 └─ Geo DNS queries (first 1B)                              Monthly cost depends on usage: $0.70 per 1M queries

 aws_route53_zone.cif_project_com
 └─ Hosted zone                                                             1  months                         $0.50

 aws_s3_bucket.cif_project_com
 └─ Standard
    ├─ Storage                                              Monthly cost depends on usage: $0.023 per GB
    ├─ PUT, COPY, POST, LIST requests                       Monthly cost depends on usage: $0.005 per 1k requests
    ├─ GET, SELECT, and all other requests                  Monthly cost depends on usage: $0.0004 per 1k requests
    ├─ Select data scanned                                  Monthly cost depends on usage: $0.002 per GB
    └─ Select data returned                                 Monthly cost depends on usage: $0.0007 per GB

 OVERALL TOTAL                                                                                                $0.50
──────────────────────────────────
12 cloud resources were detected:
∙ 5 were estimated, 2 of which include usage-based costs, see https://infracost.io/usage-file
∙ 6 were free:
  ∙ 2 x aws_route53_record
  ∙ 1 x aws_acm_certificate
  ∙ 1 x aws_acm_certificate_validation
  ∙ 1 x aws_s3_bucket_acl
  ∙ 1 x aws_s3_bucket_policy
∙ 1 is not supported yet, see https://infracost.io/requested-resources:
  ∙ 1 x aws_s3_bucket_website_configuration
```