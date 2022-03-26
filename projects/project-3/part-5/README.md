## Task Definition for phpMyAdmin DBMS container

Before creating a container, you must first check the resources available for them:

![Cpu Memory](images/cpu-memory.png ':size=800')

1024 CPU units and 982 MiB of memory are available.

:warning: `What you should know is that phpMyAdmin consumes very few resources, while Metabase consumes a lot. 800 MiB of memory and 800 CPU units will be allocated to Metabase, which leaves 182 MiB of memory and 224 CPU units for phpMyAdmin (which is quite enough).`

To create a container, you need to create what is called a **Task Definition**. A Task Definition is an element containing all the information related to the container (the image used, the size of the container, the environment variables etc.).

It is therefore **necessary to create a Task Definition** specific to the container, and it will be possible to deploy the container from it. To do this, select **Task Definitions**, then **Create new Task Definition**:

![Create Task Definition](images/create-task-definition.png ':size=800')

Select EC2 launch type:

![Launch Type EC2](images/launch-type-ec2.png ':size=800')

Define the **name of the Task Definition**, for this example the name will be *td-phpmyadmin*. Do not create a **Task role** and leave the **Network mode** in *default* since the default operation of the Linux instance (bridge) is perfectly fine.

![Configure Task Container](images/configure-task-container.png ':size=600')

Do not define a **Task execution role**, since CloudWatch will not be used for this project:

![Task Execution Role](images/task-execution-role.png ':size=700')

As seen before, the phpMyAdmin container will have 182 MiB of memory and 224 dedicated CPU units:

![Task Size](images/task-size.png ':size=700')

All task-specific settings have been made. Now it's time to go to the container settings by clicking on **Add container**:

![Add Container](images/add-container.png ':size=700')

:warning: `In order to better understand the following, it is necessary to have a basic knowledge of Docker. For those who don't know Docker at all, here is an excellent video explaining it in broad strokes:` https://www.youtube.com/watch?v=gAkwW2tuIqE

Let's see the container settings, first of all, for the **container name**, I advise to give the name of the service installed in it, that is *phpmyadmin*.

In order to install phpMyAdmin in the container, we need to import the phpMyAdmin image from Docker Hub. The most recent phpMyAdmin image is called *phpmyadmin:latest*, and can be found on this link: https://hub.docker.com/_/phpmyadmin

> Remember this: to import an image from Docker Hub on ECS, the URL is **docker.io/image:tag**

So what you need to add is the following link: *docker.io/phpmyadmin:latest*

And for **Private repository authentication**, do not enable it since the image used is public.

This gives:

![Container Settings](images/container-settings.png ':size=700')

What follows is interesting. **In order for containers to coexist and not sabotage each other, it is necessary to limit the memory they consume.** Imagine if a container uses more memory than expected, it will steal the memory of other containers, which will prevent them from working; in other words: **a container that uses too much memory can corrupt other containers.**

To circumvent this problem, it is set up what is called **Memory Limits**: *Hard limit* and *Soft limit*. Here, it is the *Hard limit* that will be used, since it allows to stop the container if it exceeds the memory consumption that is assigned to it. The **Hard limit assigned is 182 MiB** since this is the maximum value normally allocated to the container:

![Memory Limits](images/memory-limits.png ':size=700')

The other interesting element is **port mapping**, which is an essential tool for working with containers. It simply consists in **linking the container port to the port of the instance which holds the Cluster**.

To access phpMyAdmin, you have to connect to port 80 of the container, but it is impossible to connect directly to the container. It is however possible to connect directly to the EC2 instance, so the solution is to connect to a port of the instance linked to the port 80 of the container.

Here, I strongly advise you to **connect port 80 of the container to port 8080 of the EC2 instance**.

> It is possible to connect port 80 of the container to any other port of the instance that is not already used by another service. To be sure to provide an unused port, it is best practice to assign a port greater than 1024.

![Port Mappings](images/port-mappings.png ':size=700')

To finish with the container settings, you need to configure what is called **Environment variables**.

**Environment variables** are nothing more than variables that are specific to the configuration of the container when it is created. In other words, **it is possible to modify the default configuration of the container by entering Environment variables**.

![Environment Variables](images/environment-variables.png ':size=700')

Why use them for phpMyAdmin? It's simple, it is necessary that the container at its creation is directly connected to the RDS database, and unfortunately with the default settings the container is not able to connect to it.

To solve this problem, you have to set the Environment variable **PMA_HOST**, which must have as value the hostname (or IP) of the RDS database. Here, you will fill in the endpoint of the RDS database.

To do so, go to the RDS database page, and copy the endpoint:

![RDS Endpoint](images/rds-endpoint.png ':size=600')

Now paste the copied endpoint into the **PMA_HOST** Environment variable:

![PMA Host](images/pma-host.png ':size=600')

Perfect, the settings of the container are finally done. You can now validate the settings of the container, then the settings of the task.

It is time to create a task that will launch the phpmyadmin container, to do this, go inside the Cluster, then go to the **Tasks** menu and click on **Run new Task**:

![Run New Task](images/run-new-task.png ':size=700')

Select the **Launch Type EC2**, and select the **Task definition phpmyadmin** freshly created. The number of task will be obviously at 1 since it is useless to have more than one phpMyAdmin container:

![Run Task](images/run-task.png ':size=700')

Leave the other settings as they are and create the task. The task is now in the **Running** state:

![Task Running](images/task-running.png ':size=700')

All that remains is to create an **inbound rule** authorizing access to port 8080 of the instance, to do this, go to the **Security Group of the Cluster**:

![Edit Inbound Rules](images/edit-inbound-rules.png ':size=700')

Create the inbound rule in question by allowing access only to *My IP* so that phpMyAdmin is accessible only from your public IP:

![HTTP Access phpMyAdmin](images/http-access-phpmyadmin.png ':size=800')

Now, connect to the EC2 instance containing the ECS Cluster from its IP address, pointing to port 8080 in HTTP:

![Welcome Page phpMyAdmin](images/welcome-page-phpmyadmin.png ':size=600')

:warning: `Be sure you are pointing to port 8080 in HTTP and not HTTPS. To avoid mistakes, write the whole link like this: http://12.34.56.78:8080`

You are now in front of the PhpMyAdmin connection page. Log in using the login details of the RDS database:

![Connected phpMyAdmin](images/connected-phpmyadmin.png ':size=800')

And now you have the possibility to manipulate the RDS database with phpMyAdmin installed inside a container. Now let's do the same with Metabase.

### [Task Definition for Metabase visualization tool container](/projects/project-3/part-6/README.md)