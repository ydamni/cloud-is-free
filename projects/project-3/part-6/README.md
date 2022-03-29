## Task Definition for Metabase visualization tool container

Just like phpMyAdmin, create a Task Definition for Metabase:

![Create Task Definition](images/create-task-definition.png ':size=800')

Select the **EC2 launch type**:

![Launch Type EC2](images/launch-type-ec2.png ':size=800')

Give a name to the task definition, here it will be *td-metabase*, and as for phpMyAdmin, the **Task role** will remain on *None* and the **Network mode** on *default*:

![Configure Task Container](images/configure-task-container.png ':size=600')

The **Task execution IAM role** will remain on *None* :

![Task Execution Role](images/task-execution-role.png ':size=700')

As previously calculated, the size provided to the Metabase container will be 800 MiB in memory and 800 CPU units:

![Task Size](images/task-size.png ':size=700')

That's enough for the task settings, now you have to configure the container by clicking on **Add container**:

![Add Container](images/add-container.png ':size=700')

The container will be named *metabase* and will use the image *metabase/metabase:latest*.

> Link to the image: https://hub.docker.com/r/metabase/metabase/

And as always, the image is from a public repository, so do not check the **Private repository authentication** box:

![Container Settings](images/container-settings.png ':size=700')

The **Memory limit** will be set at **800 MiB**:

![Memory Limits](images/memory-limits.png ':size=700')

Now you have to look at the port mapping. First of all, you have to know that **the port used to connect to Metabase is port 3000**. Port 3000 is not a port used by a third party service of the instance, so it is interesting to assign the same port on the instance.

In other words, **connect port 3000 of the container to port 3000 of the instance**:

![Port Mappings](images/port-mappings.png ':size=700')

It is possible to assign environment variables to Metabase, here is the link referencing them: https://www.metabase.com/docs/latest/operations-guide/environment-variables.html

But here, **do not fill in any environment variables**:

![Environment Variables](images/environment-variables.png ':size=700')

The settings are done. Validate the container settings and the task settings to create the task definition *td-metabase*. All that remains is to launch it:

![Run New Task](images/run-new-task.png ':size=700')

Select *td-metabase*, and start the task:

![Run Task](images/run-task.png ':size=700')

Make sure the container is in the **Running** state, otherwise it means that it failed to run probably due to a bad configuration. If you see **Running**, the container is well configured:

![Task Running](images/task-running.png ':size=700')

All that remains is to add an inbound rule to the ECS cluster's security group to get HTTP access to Metabase:

![Edit Inbound Rules](images/edit-inbound-rules.png ':size=700')

Same process as for phpMyAdmin, but this time it is the port 3000 that is authorized to the Source **My IP**:

![HTTP Access Metabase](images/http-access-metabase.png ':size=800')

It only remains to connect in HTTP to Metabase from the browser:

![Front Page Metabase](images/front-page-metabase.png ':size=500')

:warning: `Be sure you are pointing to port 3000 in HTTP and not HTTPS. To avoid mistakes, write the whole link like this: http://12.34.56.78:3000`

At the first start, Metabase must be configured. It is necessary to:
- Choose the default language;
- Create a Metabase Administrator account;
- Link the database to Metabase.

It is up to you to choose the default language and to create your administrator account:

![Add Your Data](images/add-your-data.png ':size=500')

To make the link with the database, here is how to proceed:
- Choose the database type **MySQL**;
- Choose the display name of your choice. Here the choice was to keep the same name as the one assigned to the RDS database *rds-mysql-project3*;
- In the field **Host**, provide the Endpoint link of the RDS database;
- The **Database name field** is for the name of the **database structure**. In a MySQL database, the default database structure name is **mysql**;
- Enter the username and password of the database administrator account;

Your configuration should look like this:

![Database Settings](images/database-settings.png ':size=500')

Once you have completed all the Metabase configuration steps on the first startup, you will be connected to the Metabase main page:

![Main Page Metabase](images/main-page-metabase.png ':size=900')

Perfect, now that the containers are ready, it's time to use phpMyAdmin and Metabase right? But are you sure that the Metabase container is correctly configured, and that **these first startup settings will persist?** Check this by **stopping and restarting the Metabase container**:

![Stop Task](images/stop-task.png ':size=700')

Once the Metabase container is stopped and restarted, return to the Metabase web page:

![Front Page Again](images/front-page-again.png ':size=500')

It is asked **again** to enter the configuration at the first start of Metabase. It seems that **the settings have been deleted from the container**!

> The important thing to remember is that **when a container is stopped, it is deleted.**

By default, Metabase saves its configuration in a file, which it stores in the container's storage space that is deleted when the container is stopped. The question is: **Is there a solution to store the configuration file somewhere else, and use it in real time?**

The answer is **yes**, thanks to EFS.

### [Add EFS to Metabase container](/projects/project-3/part-7/README.md)