## Create a VPC & Subnets

First, in the AWS Management Console, go to *VPC* and create a VPC. A page like this should appear:

![Create VPC Default](images/create-vpc-default.png ':size=700')

In **Resources to create**, select the **VPC, subnets, etc.** field, so that you can also configure the VPC subnets.

Give a **Name tag** to the VPC resources to more easily differentiate them from the other resources of your other VPCs, in this example the **Name tag** is *project3*.

For the rest, leave the default values as they are perfectly suitable for the project.

The first part of the settings should look like this:

![Create VPC Subnets](images/create-vpc-subnets.png ':size=400')

For the next step, choose **2 Availability Zones**. Only one AZ will be needed to complete the project, but in order to create a RDS Database, it is needed to have at least 2 AZ.

> To know why 2 AZ are required for RDS: https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBSubnetGroup.html

Select a **Number of public subnets** to 2, since it will be used to interact with the tools installed in the containers. Do the same for the **Number of private subnets** which will contain only RDS.

Do not add a **NAT Gateway**, as this will be charged (not respecting the Free Tier), and the containers will communicate with the RDS database via an endpoint (unnecessary NAT Gateway).

Do not add an **S3 Gateway** since the S3 service will not be used here.

Enable **DNS hostnames** and **DNS resolution**, an **ESSENTIAL step** for the services to interact with each other (especially EFS).

The second part of the settings should look like this:

![Create VPC Subnets 2](images/create-vpc-subnets-2.png ':size=400')

All that remains is to create the VPC, and wait for its resources to be generated:

![VPC Resources Creation](images/vpc-resources-creation.png ':size=700')

Last step, go to *Subnets*, in order to edit the subnets settings of the **public subnets** of the newly created VPC:

![Edit Public Subnet Settings](images/edit-public-subnet-settings.png ':size=700')

The **auto-assign public IPv4 address** must be enabled at all costs, so that each AWS tool linked to the public subnet automatically gets a public IP:

![Enable Auto Assign](images/enable-auto-assign.png ':size=700')

Do the same for the other public subnet.

The VPC is ready, it is now possible to create the AWS tools, and the first one created will be RDS.

### [Create a RDS MySQL database](/projects/project-3/part-3/README.md)