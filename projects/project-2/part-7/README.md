## Create the REST API Handler using Lambda

### What is a REST API Handler ?

A REST API Handler is a function that retrieves and processes data sent by a REST API.

> To learn more about what a REST API is, I refer you to this video from IBM which explains it very well: https://www.youtube.com/watch?v=lsMQRaeKNDk

When a REST API receives data, it stores it in a variable named **body**, and then sends the **body** variable to a REST API Handler which will then process the data.

The objective is therefore to create a Lambda function capable of receiving data sent by a REST API (**body** variable) and returning this data to the desired service (here Step Functions).

Let's see how to create the Lambda function *restApiHandler.py*.

### Create Lambda Function *restApiHandler.py*

Go to Lambda to create the third and last function.

The function is called *restApiHandler.py* and uses the **Python 3.9** language. In the **Permissions** tab, choose the Lambda role you created. You can then create the function:

![Rest API Handler Create Function](images/create-api-function.png ':size=900')

Once the function is created, go to the **Code source** menu. This can be seen:

![Code Source](images/code-source.png ':size=900')

Delete the code contained in *lambda_function*. Everything is ready, it's time to code.

As always, in order to interact with AWS services, you must first import the boto3 libraries inside your code:

``` py
import boto3
```

New thing here, this Lambda function will use functions to manipulate JSON data, so add the JSON library:

``` py
import json
```

Here, the service to be interacted with is Step Functions. To do this, you have to call the *client('stepfunctions')* class of the boto3 library. This class will be stored in a *sfn* variable to simplify the code:

``` py
sfn = boto3.client('stepfunctions')
```

Create the function *lambda_handler*, which, to remind you, is the default function in Lambda where the events received are managed:

``` py
def lambda_handler(event, context):
```

Within this function, the Step Functions appropriate function for executing a state machine must be filled in. To find the function, let's have a look at the boto3 documentation for Step Functions: https://boto3.amazonaws.com/v1/documentation/api/latest/reference/services/stepfunctions.html

After a little research, the function that addresses the issue seems to be *start_execution()*:

![Function Start Execution](images/function-start-execution.png ':size=600')

And according to the documentation, only one field is required: **stateMachineArn**. However, it is necessary here to send data as Input, so the **input** variable will also be used.

The *start_execution* function to be added to *lambda_handler* should look like this:

``` py
    sfn.start_execution(
        stateMachineArn="<state_machine_arn>",
        input=event['body']
    )
```

:warning: `It is worth noting that for the input, the event variable called is 'body', since as explained earlier, the API stores the data it receives into a 'body' variable and sends it. Therefore it is in this variable that all other variables are contained.`

All that remains is to add a **return** at the end of the function, which gives the sending result to the API Gateway. Unlike the other scripts (*email.py* and *sms.py*), the value returned is important. The Gateway API needs to receive a **Status Code** and a **body** in JSON format containing the **Status**.

> Learn more about status codes: https://en.wikipedia.org/wiki/List_of_HTTP_status_codes

The **Status Code** to be returned when the Lambda function executes correctly is *code 200*. The **Status** can contain the value of your choice (try to be as explicit as possible), which gives a result like this:

``` py
    return {
        "statusCode": 200,
        "body": json.dumps(
            {"Status": "Instruction sent to the REST API Handler!"},
        )
    }
```

In the end, the Lambda function should look like this:

``` py
import boto3
import json

sfn = boto3.client('stepfunctions')

def lambda_handler(event, context):
    sfn.start_execution(
        stateMachineArn="<state_machine_arn>",
        input=event['body']
    )
    
    return {
        "statusCode": 200,
        "body": json.dumps(
            {"Status": "Instruction sent to the REST API Handler!"},
        )
    }
```

It is now time to see if it works. First copy the ARN of the state machine previously created:

![Copy State Machine ARN](images/copy-state-machine-arn.png ':size=600')

Add it to your code, and now Deploy and Test the code:

![REST API Handler Function Finished](images/api-function-finished.png ':size=900')

The last step is to configure a test event to simulate the reception of an event. To do this, fill in the **body** variable, but not in just any way. 
The format must correspond to what Step Functions receives as Input, and according to the documentation, the format for the Input is written as follows:

![Input Format](images/input-format.png ':size=600')

Following the requested format, the Input must look like this:

``` json
{
    "body": "{\"typeOfSending\":\"sms\", \"destinationEmail\":\"cif-destination@yopmail.com\", \"phoneNumber\":\"+33678901234\", \"message\":\"Sent from REST API Handler\"}"
}
```

All that remains is to press the **Test** button, and there should be a *Succeeded* status displayed in the execution results:

![Execution Results](images/execution-results.png ':size=900')

If you received an email or an SMS based on what you have chosen: **Congratulations, you know how to receive data from an API and send it to Step Functions.**

The *restApiHandler.py* script is ready, and it's time to link it to API Gateway.

### [Create and configure the API Gateway](/projects/project-2/part-8/README.md)