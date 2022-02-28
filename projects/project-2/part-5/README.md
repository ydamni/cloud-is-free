## Send SMS using SNS and Lambda

The first step is to create a Lambda function capable of sending to SNS the instruction to send a SMS.

When sending a SMS, there are two fields that must be filled in:
- The content of the message
- the recipient's phone number

Those two fields will be filled in from the website hosted on S3.

Like *email.py*, it is necessary to create a Lambda function capable of retrieving the content of the message and the phone number of the recipient as an event, and to add them to the instruction sent to SNS.

#### Prerequisites before starting

Like SES does with emails, SNS can only send messages to verified numbers, but no need to have a source phone number, AWS will bring one for you. All you have to do is add a single number that will receive the SMS to the list of verified phone numbers, your phone number for example.

To do so, go to SNS, and select **Text Messaging (SMS)** at the left:

![Text Messaging](images/text-messaging.png ':size=900')

Then, in the **Account Information** menu, you should see this:

![SNS Account Information](images/sns-account-information.png ':size=800')

By default, an AWS account is in an SMS sandbox, so the phone number must be verified. If this is your case, it's not a problem, you just need to verify the phone number for the project.

For those who are not in the SMS sandbox, it may be that someone on your team with access to the AWS account has asked to leave it, so you can skip the phone number verification step and move directly to the **Create Lambda function *sms.py*** part.

> For those interested, you can have more information about SMS sandbox right there: https://docs.aws.amazon.com/sns/latest/dg/sns-sms-sandbox.html

To check the phone number, go to the **Sandbox destination phone numbers** menu and select **Add phone number**:

![Sandbox Destination Phone Number](images/sandbox-destination-phone.png ':size=700')

Add your phone number **with the area code**, and select the verification message language of your choice:

![Verify Phone Number](images/verify-phone-number.png ':size=800')

All that remains is to enter the Verification code received by SMS:

![Verification Code](images/verification-code.png ':size=800')

The number is now verified:

![Verified Phone Number](images/verified-phone-number.png ':size=700')

Everything is ready. Now time to create the Lambda function *sms.py*.

#### Create Lambda function *sms.py*

Go to Lambda to create the second function.

The function is called *sms* and uses the **Python 3.9** language. In the **Permissions** tab, choose the newly created Lambda role. You can then create the function:

![SMS Create Function](images/create-sms-function.png ':size=900')

Once the function is created, go to the **Code source** menu. This can be seen:

![Code Source](images/code-source.png ':size=900')

Delete the code contained in *lambda_function*. Everything is ready, it's time to code.

As before, in order to interact with AWS services, you must first import the boto3 libraries inside your code:

``` py
import boto3
```

Here, the service to be interacted with is SNS. To do this, you have to call the *client('sns')* class of the boto3 library. This class will be stored in a *sns* variable to simplify the code:

``` py
sns = boto3.client('sns')
```

Create the function *lambda_handler*, which, to remind you, is the default function in Lambda where the events received are managed:

``` py
def lambda_handler(event, context):
```

Within this function, the SNS appropriate function for sending a SMS must be filled in. To find the function, let's have a look at the boto3 documentation for SNS: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/sns.html

After a little research, the function that fits the bill seems to be *publish()*:

![Function Publish](images/function-publish.png ':size=600')

And according to the documentation, two fields are required: **Message**, and something to send the message (**PhoneNumber** in our case). The phone number is ready, and the message will contain what you want.

The *publish* function to be added to *lambda_handler* should look like this:

``` py
    sns.publish(
        PhoneNumber='+33678901234',
        Message='Time to test'
    )
```

So, as for *email.py*, by adding the variables contained in event, we get this:

``` py
    sns.publish(
        PhoneNumber=event['phoneNumber'],
        Message=event['message']
    )
```

All that remains is to add a **return** at the end of the function, which is REQUIRED for Step Functions to operate:

``` py
    return 'SMS sent!'
```

the Lambda function should look like this:

``` py
import boto3

sns = boto3.client('sns')

def lambda_handler(event, context):
    sns.publish(
        PhoneNumber=event['phoneNumber'],
        Message=event['message']
    )
    return 'SMS sent!'
```

It is now time to Deploy and Test the code:

![SMS Function Finished](images/sms-function-finished.png ':size=900')

The last step is to configure a test event to simulate the reception of an event. To do this, fill in the **phoneNumber** and **message** variables with the desired values. In this example, **phoneNumber** has the value *+33678901234* and **message** has the value *Time to test*:

![Configure Test Event](images/configure-test-event.png ':size=600')

All that remains is to press the **Test** button, and there should be a *Succeeded* status displayed in the execution results:

![Execution Results](images/execution-results.png ':size=700')

You received an SMS a few seconds after running the test: **Congratulations, you know how to send an SMS with Lambda.**

The *email.py* and *sms.py* scripts are ready, it's time to link them to Step Functions, which will transfer the data and execute the scripts.

### [Manage how to send using Step Functions](/projects/project-2/part-6/README.md)