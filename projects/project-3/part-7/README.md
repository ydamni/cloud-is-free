## Add EFS to Metabase container

To use EFS with the Metabase container, the container needs to have the necessary access. For this purpose, you must first create a Security Group for EFS:

![Create Security Group](images/create-security-group.png ':size=700')

Give a name to the Security Group, here the name will be *efs-project3*. Fill in the **Description** field as you wish, trying to explain as well as possible the use of the Security Group, and implement the Security Group in the right VPC.

Now you need to create an inbound rule capable of giving access to EFS for the Metabase container.
Two things must be taken into account:
- The access rules of the container are based on the access rules of its cluster;
- EFS uses the NFS protocol to receive/send data.

> More info on the NFS protocol: https://en.wikipedia.org/wiki/Network_File_System

The inbound rule will therefore allow the NFS protocol to the Security Group of the ECS Cluster.

The Security Group creation settings should look like this:

![Security Group Settings](images/security-group-settings.png ':size=700')

The Security Group is now created, go to EFS and select **Create file system**:

![Create File System](images/create-file-system.png ':size=700')

A quick creation menu appears. Instead of using this menu, click on **Customize**:

![Customize EFS](images/customize-efs.png ':size=500')

A new, more complete and detailed menu appears.

Give a name to the EFS volume, here the name given is *metabase-volume*.

For AZ, select a **One Zone storage class** since EFS will be used only in the zone you selected, in this example the selected zone for the project is *us-east-1a* :

![File System Settings](images/file-system-settings.png ':size=700')

See the **Backup section**. You should know that EFS offers 5 GiB of storage, but the backups are not part of the Free Tier and are therefore charged. Disable automatic backups to stay in the Free Tier.

Transiting the data to an infrequent access reduces access performance but allows you to make more savings on EFS storage. But here, the space provided is free thanks to the Free Tier, which nullifies the advantage of lifecycle management.
This is why it is in your interest to disable lifecycle management:

![File System Settings 2](images/file-system-settings-2.png ':size=700')

Select **General Purpose** in **Performance mode**, and **Bursting** in **Throughput mode**; these two modes are more than enough to use EFS for this project. Do not enable **Encryption** at rest.

![File System Settings 3](images/file-system-settings-3.png ':size=700')

For network access, first select the project's VPC. Create a **Mount Target** and associate it to the AZ used for the project (here *us-east-1a*), to the public subnet of the AZ, and assign the previously created Security Group (here *efs-project3*):

![Network Access](images/network-access.png ':size=700')

For the **File system policy** part, leave it blank and go to the next part:

![File System Policy](images/file-system-policy.png ':size=700')

All the settings have been made, all that remains is to validate the creation of the EFS volume.

Now it's time to modify the Task Definition *td-metabase*, which will create a **new revision**. **A revision is simply a version of the Task Definition at a given time.** The first revision (rev 1) of the Task Definition *td-metabase* is the current version, then when the Task Definition will be modified to include EFS, it will have a second revision (rev 2).

To do so, go to the Task Definition settings and select **Create new revision**:

![Create New Revision](images/create-new-revision.png ':size=700')

You are back in the task settings. Go to the bottom and add a volume:

![Volumes Task](images/volumes-task.png ':size=900')

Add a name to your volume, here the name given is the same as the EFS volume *metabase-volume*, but the name can be different. 

Choose the **volume type EFS** and select the previously created EFS volume.

Leave the **Access point ID** field set to *None* since no access point needs to be created or used for this project.

Set the **Root directory** to the root **/** , and do not enable **encryption** or **EFS IAM Authorization**.

This gives:

![Add Volume Task](images/add-volume-task.png ':size=700')

The volume is added to the task, now you have to **go to the container settings**:

![Container Settings](images/container-settings.png ':size=900')

Go to the **Storage and logging** section and add a mount point to the volume. Specify **/mnt** as the **Container path**, so that the volume is mounted in the **/mnt** folder of the container:

![Mount Point Container](images/mount-point-container.png ':size=700')

And finally, go to the **Environment Variables** and add the environment variable **MB_DB_FILE** allowing to define the path in which the Metabase configuration file named *metabase.db* will be stored.

> Link to Environment Variable **MB_DB_FILE** Documentation: https://www.metabase.com/docs/latest/operations-guide/environment-variables.html#mb_db_file

The file *metabase.db* will be stored in the EFS volume, which is itself mounted in */mnt* ; the path to the file will therefore be */mnt/metabase.db* :

![Environment Variable Container](images/environment-variable-container.png ':size=700')

All that remains is to save the container settings then the task settings. The second revision of the Task Definition is created.

Here is a summary of what has just been done:
- The EFS volume has been added to the Task Definition;
- The container has a new EFS volume mounted in the /mnt file;
- The Metabase configuration file is stored in the EFS volume, so it will not be deleted when the container is restarted.

All that remains is to recreate the Metabase container by launching the **revision 2** of the Task Definition *td-metabase* :

![Run Task Rev 2](images/run-task-rev-2.png ':size=700')

Make sure that the task is in the **Running** state, to ensure that the configuration is correct, and therefore that the container is correctly launched:

![Task Running](images/task-running.png ':size=700')

Connect to the web page of Metabase:

![Front Page Metabase](images/front-page-metabase.png ':size=500')

Redo the same settings as before, until you reach the main page of Metabase:

![Main Page Metabase](images/main-page-metabase.png ':size=900')

Make sure that the Metabase configuration file is saved in the EFS volume by stopping the container and restarting it:

![Stop Task](images/stop-task.png ':size=700')

Wait a few minutes and return to the Metabase web page:

![Main Page Metabase Again](images/main-page-metabase-again.png ':size=900')

Good news: **the Metabase configuration has been saved in the EFS volume!**

The Cloud infrastructure is now ready, all that remains is to manage the database by using the tools provided. Start by creating the database structure with phpMyAdmin.

### [Create database structure with phpMyAdmin](/projects/project-3/part-8/README.md)