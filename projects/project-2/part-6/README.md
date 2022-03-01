## Manage how to send using Step Functions

Before starting, it is worth explaning what Step Functions is.

See how AWS defines it:

*AWS Step Functions is a low-code, visual workflow service that developers use to build distributed applications, automate IT and business processes, and build data and machine learning pipelines using AWS services. Workflows manage failures, retries, parallelization, service integrations, and observability so developers can focus on higher-value business logic.*

> https://aws.amazon.com/step-functions/

This definition helps to understand how Step Functions works in broad terms, but makes it difficult to visualise the tool. The following will give a much better understanding of Step Functions, which is, contrary to its complex definition, a simple tool to use.

### Create *Sending* State Machine

First, go to Step Functions and select **State machines** on the left:

![Select State Machines](images/select-state-machines.png ':size=900')

Then select **Create state machine**:

![Create State Machine](images/create-state-machine.png ':size=700')

There are now three choices:
- **Design your worflow visually**: This method allows you to create state machines via block diagrams. A new method that is easier to handle, but less effective than the other two.
- **Write your workflow in code**: As the title suggests, workflow is written in code, nothing more to add.
- **Run a sample project**: All you have to do is get a sample project using CloudFormation.

The choice here is to **write the workflow in code**, which is the best way to get the hang of and understand the tool:

![Define State Machine](images/define-state-machine.png ':size=600')

For the **Type**, to make the wise choice, click on the **Help me decide** text, and take a look at the comparison table of the *Standard* and *Express* types.

What needs to be compared is the pricing between the two types, and ESPECIALLY which of the two types is compatible with the Free Tier. Here is what is offered with the Free Tier for Step Functions:

![Step Functions Free Tier](images/step-functions-free-tier.png ':size=500')

AWS offers 4,000 state transitions per month, and if you take a look at the Standard pricing, this is what you observe:

![Standard Pricing](images/standard-pricing.png ':size=180')

The Standard type is priced per state transitions, where the Express type is priced by the number of execution you run, their duration and memory consumption. In other words, **the type eligible for Free Tier is the Standard type**. You must therefore select **Standard**:

![Type Standard](images/type-standard.png ':size=700')

Go to the **Definition** menu:

![Definition Menu](images/definition-menu.png ':size=800')

This is where it starts to get interesting. On the left you can see some code written in JSON, which makes the workflow diagram on the right.

All workflows start with a *Start* and end with an *End* (it makes sense doesn't it), and the aim is to establish actions between these two. The actions will use the data received at the Input of the workflow (at the *Start* more precisely). The objective for the project is therefore to **set up actions that will process the data received from the website: message, destinationEmail, and phoneNumber**. 

You have to :
- Send the values of the **message** and **destinationEmail** variables to the script *email.py*;
- Send the values of the **message** and **phoneNumber** variables to the script *sms.py*.

But you should also consider what type of sending you want to do. Send an email or a SMS? Sometimes you will want to send an email to your uncle, and other times you will want to send an SMS to your friend. For this, you will need a new variable that will be used by your state machine: **typeOfSending**.

The final goal is to have this workflow diagram:

![Workflow Diagram](images/workflow-diagram.png ':size=200')

The first action is to select the type of sending, then the chosen sending is processed (an SMS if **typeOfSending** = *sms*, or an email if **typeOfSending** = *email*).

Enough talk, it's time to create your first state machine, and there's nothing like the documentation to help you: https://docs.aws.amazon.com/step-functions/latest/dg/amazon-states-language-state-machine-structure.html

You can see that a state machine MUST consist of the **StartAt** and **States** fields, but to help you, I recommend you add the **Comment** field which will explain the functionality of the state machine (in case you forget in 2 years why this state machine exists):

``` json
{
    "Comment": "State machine for sending SMS & email",
    "StartAt": "Select Type of Sending",
    "States": {
```

In doing so, **Comment** explains the functionality of the state machine, **StartAt** allows you to define which action to start with (in this case *Select Type of Sending*), and **States** contains all the states that contain the actions you want to perform.

As seen in the diagram above, *Select Type of Sending*, *Email* and *SMS* are the states, and each performs its own action.

These three states must therefore be created, with an action assigned to them:
- the *Select type of Sending* state will make the choice between the *Email* or *SMS* state based on the **typeOfSending** variable;
- the *Email* state sends the **destinationEmail** and **message** variables to the Lambda function *email.py*;
- the *SMS* state sends the **phoneNumber** and **message** variables to the Lambda function *sms.py*.

> Find out more about the states: https://docs.aws.amazon.com/step-functions/latest/dg/concepts-states.html

Start with the first state, *Select Type of Sending* :

``` json
        "Select Type of Sending": {
            "Type": "Choice",
```

The state is of type *Choice*, which as its name indicates, allows a choice between several states. Here, the choice will be between the *SMS* and *Email* states:

``` json
            "Choices": [
                {
                    "Variable": "$.typeOfSending",
                    "StringEquals": "email",
                    "Next": "Email"
                },
                {
                    "Variable": "$.typeOfSending",
                    "StringEquals": "sms",
                    "Next": "SMS"
                }
            ]
        },
```

In the **Choices** field, two elements are filled in.

:warning:`The following is very important to understand. Once this is understood, the rest is relatively simple:` In order to make its choice, the *Select Type Of Sending* state checks the **typeOfSending** variable received as Input, checking whether its value is equal to the value of the **StringEquals** field.

In the first choice, the **StringEquals** field has the value *email*, so if **typeOfSending** = *email*, then the chosen state will be the value contained in the **Next** field: the *Email* state.

In the second choice, the **StringEquals** field has the value *sms*, so if **typeOfSending** = *sms*, then the chosen state will be the value contained in the **Next** field: the *SMS* state.

The *Type Of Sending* state is now ready, it is time to create the *Email* and *SMS states.

Continue with the second state, *Email* :

``` json
        "Email": {
            "Type" : "Task",
            "Resource": "<lambda_email.py_arn>",
            "End": true
        },
```

The state is of type *Task*, which allows to execute a resource by specifying its ARN. Here the resource is the Lambda function *email.py*. The **"End": true** field is used to say that this is the last state to be executed.

Finish with the third state, *SMS* :

``` json
        "SMS": {
            "Type" : "Task",
            "Resource": "<lambda_sms.py_arn>",
            "End": true
        }
    }
}
```

The state is of type *Task*, and this time, the resource is the Lambda function *sms.py*. The **"End": true** field is used to say that this is the last state to be executed too.

In the end, the code looks like this:

``` json
{
    "Comment": "State machine for sending SMS & email",
    "StartAt": "Select Type of Sending",
    "States": {
        "Select Type of Sending": {
            "Type": "Choice",
            "Choices": [
                {
                    "Variable": "$.typeOfSending",
                    "StringEquals": "email",
                    "Next": "Email"
                },
                {
                    "Variable": "$.typeOfSending",
                    "StringEquals": "sms",
                    "Next": "SMS"
                }
            ]
        },
        "Email": {
            "Type" : "Task",
            "Resource": "<lambda_email.py_arn>",
            "End": true
        },
        "SMS": {
            "Type" : "Task",
            "Resource": "<lambda_sms.py_arn>",
            "End": true
        }
    }
}
```

All that remains to be done is to add the ARNs of the Lambda functions *email.py* and *sms.py* to the corresponding states:

![email.py ARN](images/email-arn.png ':size=700')

![sms.py ARN](images/sms-arn.png ':size=700')

Once the code is ready, the workflow diagram should change to this one:

![Workflow Diagram](images/workflow-diagram.png ':size=200')

> If the diagram to the right of the code does not change or does not look like the one seen above, there is an error in the code (a syntax error for example). When the code is correct, the workflow diagram appears automatically. Check that your workflow diagram is the same as the one above.

And it is time to finalise the creation of the state machine, give a name to the state machine:

![State Machine Name](images/state-machine-name.png ':size=700')

Leave the other values as default and create the state machine.

It is time to run the newly created state machine. Click on **Start execution**:

![Start Execution](images/start-execution.png ':size=700')

A window appears, asking for a Test Input for the state machine (just like the Test Event for Lambda). The Input is encoded in JSON, and must contain the variables **typeOfSending**, **destinationEmail**, **phoneNumber** and **message**:

``` json
{
	"typeOfSending": "email",
    "destinationEmail" : "cif-destination@yopmail.com",
	"phoneNumber": "+33678901234",
    "message": "Sent from Step Functions"
}
```

All that remains is to launch the execution with the desired values:

![Input Step Functions](images/input-step-functions.png ':size=1000')

For this execution, an email must be sent since the **typeOfSending** variable is set to *email*, so let's see how this works:

![Graph Email Success](images/graph-email-success.png ':size=700')

According to Step Functions, everything went well, so the email must have been sent. See the mailbox of the destination email:

![Email Received](images/email-received.png ':size=300')

The mail has been received: the state machine works perfectly to send an email. Now time to check if all goes well to send an SMS, by changing the **typeOfSending** variable to *sms*:

![Graph SMS Success](images/graph-sms-success.png ':size=700')

According to Step Functions, everything went well, and the SMS has been received.

**The *Sending* state machine is now ready for use**. It's time to go back to Lambda to attack the third and final Lambda function: *restApiHandler.py*.

### [Create the REST API Handler using Lambda](/projects/project-2/part-7/README.md)