## Send Email using SES and Lambda

The first step is to create a Lambda function capable of sending to SES the instruction to send an email.

When writing an email, there are three fields that must be filled in:
- the sender's email address
- The content of the message
- the recipient's email address

The sender's email address is automaticly filled in, and the two other fields will be filled in from the website hosted on S3.

It is therefore necessary to create a Lambda function capable of retrieving the content of the message and the address of the recipient as an event, and to add them to the instruction sent to SES.

#### Prerequisites before starting

What you should know before using SES is that the service can send emails only from verified email adresses and to verified email addresses. For this project, two addresses will be verified: a source email address and a destination email address.

To do this, go to SES, and select **Create Identity**:

![SES Create Identity](images/create-identity.png ':size=500')

Select **Email address** as **Identity type** and fill in the "email address" field with the address that will serve as the source email address. For this example, the source email address is *cif-source<span>@yopmail.com*:

![Create Source Email Address](images/source-email.png ':size=600')

Check the mailbox and verify the mail address by clicking the link inside the email you just received from AWS. Once validated, this is what should appear in the AWS console:

![Source Email Address Verified](images/source-verified.png ':size=600')

Do the same for the destination email address:

![Create Destination Email Address](images/destination-email.png ':size=600')

And verify it as well:

![Destination Email Address Verified](images/destination-verified.png ':size=600')

Everything is ready. Now time to create the Lambda function *email.py*.

#### Create Lambda function *email.py*

Go to Lambda to create the first function.

The function is called *email* and uses the **Python 3.9** language. In the **Permissions** tab, choose the newly created Lambda role. You can then create the function:

![Lambda Create Function](images/create-function.png ':size=900')

Once the function is created, go to the **Code source** menu. This can be seen:

![Code Source](images/code-source.png ':size=900')

Delete the code contained in *lambda_function*. Everything is ready, it's time to code.

In order to interact with AWS services in Python, you need to know the Software Development Kit (SDK) used by AWS. An SDK is a toolkit that a platform provides to developers to interact with its services.

> For those who struggle to understand what an SDK is, I recommend you watch this great video from IBM explaining it: https://www.youtube.com/watch?v=kG-fLp9BTRo

Here, AWS provides its own SDK for python3 named boto3. More details on this link: https://docs.aws.amazon.com/lambda/latest/dg/lambda-python.html

In order to interact with AWS services, you must first import the boto3 library inside your code:

``` py
import boto3
```

Here, the service to be interacted with is SES. To do this, you have to call the *client('ses')* class of the boto3 library. This class will be stored in a *ses* variable to simplify the code:

``` py
ses = boto3.client('ses')
```

The library is imported, and the *ses* variable is ready, you now have to work on the *lambda_handler* function. The *lambda_handler* function is the default function in Lambda. It is inside this function that the events received are managed. It is declared in this way:

``` py
def lambda_handler(event, context):
```

The function contains two arguments: *event* and *context*.

*Event* is the event value received by Lambda (the Input), and *context* contains information specific to the function (execution time, name, version etc.). 
> The context argument is of no use here, but for the more curious who want to learn more about the context argument, go to this link: https://docs.aws.amazon.com/lambda/latest/dg/python-context.html

Within this function, the SES appropriate function for sending an email must be filled in. To find the function, let's have a look at the boto3 documentation for SES: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/ses.html

After a little research, the function that fits the bill seems to be *send_email()*:

![Function Send Email](images/function-send-email.png ':size=600')

And according to the documentation, three fields are mandatory: **Source**, **Destination** and **Message**. Perfect, the source and destination addresses are ready, and the message will contain what you want.

The *send_email* function to be added to *lambda_handler* should look like this:

``` py
    ses.send_email(
        Source='cif-source@yopmail.com',
        Destination={
            'ToAddresses': [
                'cif-destination@yopmail.com',
            ]
        },
        Message={
            'Subject': {
                'Data': 'Cloudisfree - Project 2'
            },
            'Body': {
                'Text': {
                    'Data': 'This is my message'
                }
            }
        }
    )
```

:warning: `Be careful, here you do not want to insert a hard-coded destination e-mail address and a hard-coded message, but ONLY a hard-coded source address. The destination address and the message come from the website, so these values will arrive in the event of the Lambda function (remember, the Input)!`

To do this, add two variables "destinationEmail" and "message" from the event, in this way:

``` py
    ses.send_email(
        Source='cif-source@yopmail.com',
        Destination={
            'ToAddresses': [
                event['destinationEmail'],
            ]
        },
        Message={
            'Subject': {
                'Data': 'Cloudisfree - Project 2'
            },
            'Body': {
                'Text': {
                    'Data': event['message']
                }
            }
        }
    )
```

If you look closely, the destination email address and message have been replaced by **event['destinationEmail']** and **event['message']**. This way, the values of the destination email address and the message will be those retrieved from the event.

All that remains is to add a **return** at the end of the function. It is important to know that the return is received by the one who called the Lambda function. According to the project diagram, it is Step Functions that calls this Lambda function, and Step Functions needs to receive a return in order to operate, but the value of the return does not matter.

Fill in the return at the end of the function, with the value of your choice (in this case the value is *"Email sent!"*):

``` py
    return 'Email sent!'
```

the Lambda function should look like this (with your own source email address):

``` py
import boto3

ses = boto3.client('ses')

def lambda_handler(event, context):
    ses.send_email(
        Source='cif-source@yopmail.com',
        Destination={
            'ToAddresses': [
                event['destinationEmail'],
            ]
        },
        Message={
            'Subject': {
                'Data': 'Cloudisfree - Project 2'
            },
            'Body': {
                'Text': {
                    'Data': event['message']
                }
            }
        }
    )
    return 'Email sent!'
```

It is now time to Deploy and Test the code:

![Email Function Finished](images/email-function-finished.png ':size=900')

The last step is to configure a test event to simulate the reception of an event. To do this, fill in the **destinationEmail** and **message** variables with the desired values. In this example, **destinationEmail** has the value *cif-destination<span>@yopmail.com* and **message** has the value *Time to test*:

![Configure Test Event](images/configure-test-event.png ':size=600')

All that remains is to press the **Test** button, and there should be a *Succeeded* status displayed in the execution results:

![Execution Results](images/execution-results.png ':size=700')

Let's take a look at the destination Mailbox:

![Email Received](images/email-received.png ':size=300')

The message was received at the right address with the right message: **Mission completed**.

The same must now be done for the *sms.py* function.

### [Send SMS using SNS and Lambda](/projects/project-2/part-5/README.md)