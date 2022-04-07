# Project 3 - Database and Containers

> Managing and Visualizing a RDS database using ECS containers

## Cloud tools used
#### AWS
- VPC & Subnets
- RDS
- EC2 & EBS
- ECS
- EFS

#### Container
- Docker

#### Docker images
- phpMyAdmin
- Metabase

## Conditions of the Free Tier
-	*VPC & Subnets:*
    -   Free (see: https://aws.amazon.com/en/vpc/pricing/)
-	*RDS:*
    -   750 Hours per month of db.t2.micro database usage
    -   20 GB of General Purpose (SSD) database storage
    -   20 GB of storage for database backups and DB Snapshots
-	*EC2:*
    -   750 hours per month of t2.micro instance usage
-   *EBS:*
    -   30 GB of Amazon EBS: any combination of General Purpose (SSD) or Magnetic
    -   1 GB of snapshot storage
-	*ECS:*
    -   Used in EC2, so relies on EC2 billing.
-	*EFS:*
    -   5 GB of storage


## Costs

#### **$0**

This project will only be using tools supported by the Free Tier.

___

## Table of contents

[1. What the project is about](/projects/project-3/part-1/README.md)

[2. Create a VPC & Subnets](/projects/project-3/part-2/README.md)

[3. Create a RDS MySQL database](/projects/project-3/part-3/README.md)

[4. Deploy a ECS Cluster in EC2](/projects/project-3/part-4/README.md)

[5. Task Definition for phpMyAdmin DBMS container](/projects/project-3/part-5/README.md)

[6. Task Definition for Metabase visualization tool container](/projects/project-3/part-6/README.md)

[7. Add EFS to Metabase container](/projects/project-3/part-7/README.md)

[8. Create database structure with phpMyAdmin](/projects/project-3/part-8/README.md)

[9. Create dashboards with Metabase](/projects/project-3/part-9/README.md)

[10. Why using ECS & EC2 instead of EC2 only?](/projects/project-3/part-10/README.md)

[11. And the bill?](/projects/project-3/part-11/README.md)