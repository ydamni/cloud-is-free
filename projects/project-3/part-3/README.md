## Create a RDS MySQL database

First, in the AWS Management Console, go to *RDS* and select **Create database**:

![Create Database](images/create-database.png ':size=500')

Choose the **Standard create** method, in order to have more control over the creation of the database, and select MySQL, which will be the database type used for this project:

![Database MySQL](images/database-mysql.png ':size=600')

For the **Template**, AWS has thought of us, and offers a **Free tier Template**, select it:

![Template Free Tier](images/template-free-tier.png ':size=600')

For the settings, insert the **DB Instance identifier** of your choice, for this example it will be *rds-mysql-project3*.

For the **Credentials**, fill in the username and password of your choice, for this example the username will be *admin*, and the password will be a secret of course:

![Database Settings](images/database-settings.png ':size=600')

No need to do anything for the **DB instance class**, the Free Tier Template has selected the right instance for you.
On the other hand for storage, I advise you to disable the **storage autoscaling** since the maximum space offered with the Free Tier for RDS is 20GiB, so you should avoid going beyond the 20GiB already allocated:

![Instance Class Storage](images/instance-class-storage.png ':size=600')

When it comes to **Connectivity**, that's where the VPC comes in. Select the newly created VPC, and let the **DB Subnet Group** be created since there is none by default for this new VPC.

Deny public access, so that RDS is in a private subnet, and therefore not publicly accessible.

For the **VPC Security Group**, leave the default settings, so that the Security Group associated with the RDS database is the default one of the VPC.

Finally, select preferably the first AZ **1a** of your region, in this example *us-east-1a*:

![Connectivity](images/connectivity.png ':size=600')

Technically speaking, there is no difference between the AZs, but symbolically, everything that will be done on this project will be done on AZ 1a.

For **Database authentication**, leave the authentication by password, in order to connect with the credentials previously filled in:

![Database Authentication](images/database-authentication.png ':size=600')

Expand the **Additional configuration** window, and only the **Backup** part will have to be modified, since I advise you to disable the **automated backup**.

> The Free Tier offers 20GiB of storage dedicated to RDS backup; this backup space will be used up very quickly after a few weeks. And it is not crucial to back up this database since the stored data is not important at all.

For the rest, leave the default settings which are totally fine for the project:

![Additional Configuration](images/additional-configuration.png ':size=600')

![Additional Configuration 2](images/additional-configuration-2.png ':size=600')

All that remains is to validate the RDS database creation. This one takes about ten minutes before being ready for use. So during this time, it is worth deploying an *ECS Cluster* on EC2.

### [Deploy a ECS Cluster in EC2](/projects/project-3/part-4/README.md)