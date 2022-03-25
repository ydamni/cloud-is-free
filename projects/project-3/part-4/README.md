## Deploy a ECS Cluster in EC2

Before starting, it is worth recalling what a ECS Cluster is.

See how AWS defines it:

*An Amazon ECS cluster is a logical grouping of tasks or services. Your tasks and services are run on infrastructure that is registered to a cluster. The infrastructure capacity can be provided by AWS Fargate, which is serverless infrastructure that AWS manages, Amazon EC2 instances that you manage, or an on-premise server or virtual machine (VM) that you manage remotely.*

> https://docs.aws.amazon.com/AmazonECS/latest/developerguide/clusters.html

This definition says enough about how a ECS Cluster works, but one interesting piece of information is worth exploring: **the infrastructure in which the cluster runs**.

#### Which infrastructure for my ECS Cluster

An ECS Cluster can run on three different infrastructures:
- A *EC2* instance;
- In serverless on *Fargate*;
- A remote *VM* outside of AWS.

For this project, the point is to use **AWS services**, especially the **Free Tier services**. It is therefore deduced that:
- The remote VM is not a good solution because it is not an AWS service;
- Fargate, despite its practicality, is not part of the Free Tier;

This leaves the final choice to **use EC2 as the infrastructure that will host the EC2 Cluster**.

#### Create a ECS Cluster

Now it's time to create this ECS Cluster in an EC2 instance, by heading to *ECS*, then selecting **Clusters**:

![ECS Clusters](images/ecs-clusters.png ':size=700')

Now select **Create Cluster**:

![Create Cluster](images/create-cluster.png ':size=800')

Here, there are three choices, but the one you are interested in is **EC2 Linux + Networking**:

![EC2 Linux Networking](images/ec2-linux-networking.png ':size=700')

It's time to settle the cluster. First, add a name to your cluster, here it will be *cluster-project3* :

![Configure Cluster](images/configure-cluster.png ':size=500')

####

:warning: `For the next part "Instance configuration", it is important to remember that what is offered with the Free Tier is 750 hours of use (i.e. 1 month of non-stop operation of an EC2 instance) for the t2.micro model only, as well as 30 GiB of space for EBS.`

Select the **On-Demand** model since in Free Tier the billing will be the same with a **Spot** model (i.e. $0), and this avoids, contrary to the Spot model, having your EC2 instance interrupted.

> More info on Spot instances: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-spot-instances.html

Select an instance type **t2.micro** and a **number of instances at 1**, and for the **EC2 AMI**, leave the default.

For the Root **EBS volume size,** it is possible to allocate up to 30 GiB (Free Tier), so you might as well take advantage of it and allocate it to the instance.

For those who want to enable SSH on their cluster, do as you wish, but for this project, no need to take control of the cluster.

All this gives:

![Instance Configuration](images/instance-configuration.png ':size=600')

Now for the **Networking** part, link the instance to the VPC of the project, and **select the public subnet 1a**, to be in the same AZ as the RDS database.

For the **Auto assign public IP**, the settings made previously on the subnet make it enabled by default, so feel free to leave the field in *Use subnet settings* or in *Enabled*.

Leave the fields related to the **Security groups** by default so that a Security Group specific to the cluster is automatically created.

This gives:

![Networking](images/networking.png ':size=700')

Finally, for the last settings, leave them as default, since they are perfectly suitable for the rest of the project:

![Container Instance IAM](images/container-instance-iam.png ':size=700')

Wait for the creation of the ECS cluster which takes a little less than five minutes:

![Launch Status](images/launch-status.png ':size=800')

The ECS cluster is created and managed by a newly created EC2 instance. Take a look at the EC2 instances:

![New EC2 Instance](images/new-ec2-instance.png ':size=800')

The new EC2 instance is created, and as can be seen from its name, it is an **ECS instance**, in other words an EC2 instance containing an ECS cluster.

The ECS cluster is now created, it is now possible to create containers containing the *phpMyAdmin* and *Metabase* tools.

### [Task Definition for phpMyAdmin DBMS container](/projects/project-3/part-5/README.md)