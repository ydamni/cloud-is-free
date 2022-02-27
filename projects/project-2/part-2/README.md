## How Lambda works

Before starting, it is worth recalling what Lambda is.

See how AWS defines it:

*AWS Lambda is a serverless, event-driven compute service that lets you run code for virtually any type of application or backend service without provisioning or managing servers. You can trigger Lambda from over 200 AWS services and software as a service (SaaS) applications, and only pay for what you use.*

> https://aws.amazon.com/lambda/

This definition says enough about how Lambda works, but let's look at it in more detail.

#### Lambda Event and Response

To work with Lambda, it is **essential** to know what an event and a response represent.

**Events are actions or occurrences that take place in a system.** For example, when a user clicks a button on a site, it generates an event containing the information that "a user has clicked a button". An event represents the Input of Lambda.

**A response is the result of information processed by a program.** For example, when a user asks a program how much is 2+2, the program processes the information "2+2" and returns the result "4" as a response. A response represents the Output of Lambda.

In a traditional scheme, this is referred to as the "Input-Process-Output" (IPO) model:

![IPO model](images/input-process-output.png ':size=500')

*Link: https://en.wikipedia.org/wiki/IPO_model*


For Lambda, the IPO model translates in this way:

![Event, Lambda and Response](images/event-lambda-response.png ':size=500')

The purpose of Lambda is therefore to use it to process the event received, and then to send the desired response after processing.

#### Link with other services

Lambda's strength lies in its ability to interact with other AWS services. It is possible to make instructions such as "send the received data to SQS" or "change the format of an image uploaded to S3" using Lambda.

For this project, Lambda interacts with:
- SNS for sending SMS;
- SES for sending email;
- Step Functions to send data received from an API.

But in order to interact with other services, you need to have permissions to use them.

#### Permissions

In order for a Lambda function to interact with a service, the function must have what is called a *Lambda Role*. The Lambda Role contains the permissions of our Lambda function, such as the permission to use all actions of the SNS service for example.

So let's start the practice by creating a Lambda Role that will be used by our Lambda functions.

### [Create a Lambda Role](/projects/project-2/part-3/README.md)