## What the project is about

Through this project, you will be able to manage a database and visualize its data with tools installed inside containers.

To better understand, let's redefine what a database and a container are:

- A database is a collection of information organized to be easily added, managed, updated and visualized.
- A container is a lightweight and executable package of software that includes everything needed to run the software.

What should be understood from these definitions for this project is that:

- *A database will be created to store data.* More precisely, the data stored will be that of a **computer store** (customer list, product list, order history...).
- *Containers will store tools that helps to manipulate the data in the database.* More precisely, one container will allow to **add/delete/modify data** in the database, and another container will allow to **visualize the data** to make graphs (ex: graph of the most sold items).

The tools used to **manage a database** (add/delete/modify)  are called **DBMS** (Database Management System); the one used for this project will be *phpMyAdmin*.

> More info on *phpMyAdmin*: https://www.phpmyadmin.net/

The tools used to **visualize data** (graphs) are called **data visualization tools**; the one used for this project will be *Metabase*.

> More info on *Metabase*: https://www.metabase.com/

How to deploy a database and containers on AWS? It's simple:

- The database will be deployed on *Amazon RDS* (Relational Database);
- The containers will be deployed with *ECS* (Elastic Container Service).

The particularity of ECS is that the service needs either Fargate or EC2 in order to run its containers. Here it will be the **EC2 service that will be used because it is part of the Free Tier unlike Fargate**.

Other services will be used (EFS, EBS) but will be detailed later in the project.

Finally, it will be necessary to manage the access to the resources, so that:

- Resources requiring public access are in a public subnet;
- Resources that need to be accessible only internally are in a private subnet.

Once this is done, this is what the project infrastructure will look like:

![Infrastructure](images/infrastructure.png ':size=800')

Now, time to start by first creating the VPC and Subnets that will be used for this project.

### [Create a VPC & Subnets](/projects/project-3/part-2/README.md)