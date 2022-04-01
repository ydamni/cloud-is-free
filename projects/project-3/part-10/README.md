## Why using ECS & EC2 instead of EC2 only?

You have probably asked yourself this question during the realization of the project. Why would you want to integrate ECS to EC2 when it would have been enough to install the phpMyAdmin and Metabase tools on an EC2 instance directly?

To understand this, you must first understand the difference between a VM (EC2 instance) and a container (ECS container).

> This video from IBM explains very well the difference between VMs and containers: https://www.youtube.com/watch?v=cjXI-yxqGTI

**Here are the reasons why it is more suitable to use ECS rather than EC2:**

Working with containers allows greater flexibility in deploying resources. A container is deployed from an image, and can be deployed from any computer: there is no concern about hardware incompatibility.

It's much easier to configure your container by filling out a container configuration file (more commonly known as a Dockerfile), where you have less control when installing software on a virtual machine.

Services contained in a container are more quickly and easily deployed and removed.

There is no need to launch a machine that contains 50 services to use only one service at the end, but that it is more intelligent to be able to stop services not used, and be able to launch a service quickly when you want to use it. A huge gain of resources.

During the project, only one type of container was launched, but it is perfectly possible to launch the same type of container multiple times in order to add redundancy. In other words, if a container crashes, another container instantly takes over.

And many other features that were not explored during this project.

**An important point to consider with AWS:**

For this project, the ECS containers were deployed in an EC2 instance in order to respect the Free Tier. Usually, ECS containers are launched on Fargate, allowing to create containers without having to manage resources (Fargate is Serverless). As a result, the billing of Fargate and EC2 are different:
- EC2 follows the **pay as you go** model, i.e. the billing is based on the duration of the instance launch;
- Fargate follows the **pay as you use** model, i.e. billing is based on the resources used (memory/cpu units).

Fargate's billing model is therefore more suitable for container use than EC2, so it is more interesting to use Fargate when using containers.

The important thing to remember is that the use of containers is increasing from day to day, but this will not replace the use of virtual machines. The two are complementary and are most effective when they are used together.

### [And the bill?](/projects/project-3/part-11/README.md)