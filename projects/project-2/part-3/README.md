## Create a Lambda Role

Lambda interacts with SES, SNS and Step Functions, so a Lambda Role must be created with execution rights for these three services.

First, go to **IAM**, and select **Roles** on the left, then **Create Role**:

![IAM Create Role](images/iam-create-role.png ':size=1000')

Next, select **AWS Service** as the **Trusted entity type**, and for the **Use case** select **Lambda** to perform a Lambda Role:

![Select Trusted Entity](images/select-trusted-entity.png ':size=700')

A menu for adding permissions appears:

![Permissions Policies](images/permissions-policies.png ':size=700')

From now on, search for the name of each service, and select *Full Access* rights in order to send instructions and information to the services.

> It is best practice to refine the permissions by using only the rights necessary for the actions you want to do with the services, and to do this you must create our own permissions. Here, to facilitate the execution of the project, the *Full Access* permissions created by default by AWS are used.

Add the *Full Access* permissions of SES:

![SES Permissions](images/ses-permissions.png ':size=700')

Same for SNS:

![SNS Permissions](images/sns-permissions.png ':size=700')

And same for Step Functions:

![Step Functions Permissions](images/step-functions-permissions.png ':size=700')

Now all that remains to be done is to validate and create the Lambda Role with the desired name.

Once the Lambda Role has been created, it is time to create the first Lambda function: *email.py*.

### [Send Email using SES and Lambda](/projects/project-2/part-4/README.md)