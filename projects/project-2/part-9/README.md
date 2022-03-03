## Code a website and upload it to S3

Last step before finishing the project: the website.

For this part, you have to:
- create a main page on which to fill in the **message** and **destinationEmail**/**phoneNumber** data;
- write a script capable of sending the data from the website to the REST API;
- upload the website to S3.

It is now time to see how to carry out these three steps.

### Create main page *index.html*

First, for those working on Visual Studio Code, create an HTML file, and write an exclamation mark '**!**' then press enter to generate a basic HTML template.

For those who do not use Visual Studio Code, copy the HTML page below:

``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
</body>
</html>
```

In order to fill in the **message** and **destinationEmail**/**phoneNumber** data, set up a form in the *<<span>body>*, containing **Message**, **Email** and **SMS** fields, as well as two buttons, one for **sending an email** and the other for **sending an SMS**. The result should look like this:

``` html
<body>
    <form>
        <div>
            <label>Message:</label>
            <input type="text" name="message">
            <br><br>
            <label>Email:</label>
            <input name="email">
            <button>Send an Email</button>
            <br><br>
            <label>SMS:</label>
            <input name="sms">
            <button>Send a SMS</button>
        </div>
    </form>
</body>
```

:warning:`It is REQUIRED to fill in the name attributes for the <input>, this will be very important for later.`

The main page should look like this:

![Main Page Form](images/main-page-form.png ':size=300')

Now you want to send the form data to the *formToApi.js* script, to do this you must first declare in the *<<span>head>* the use of the script:

``` html
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project 2 - Cloud Is Free</title>
    <script src="formToAPI.js"></script>
</head>
```

The objective now is to send an email when the **Send an Email** button is clicked, and to send a SMS when the **Send a SMS** button is clicked.

In other words: on click, send the data and the **typeOfSending** corresponding to the button clicked to the script. To do this, use the **onClick** attribute, which will launch the *formToAPI.js* script when a button is clicked.

> To know more about OnClick: https://www.w3schools.com/tags/ev_onclick.asp

This is what it looks like:

``` html
<body>
    <form>
        <div>
            <label>Message:</label>
            <input type="text" name="message">
            <br><br>
            <label>Email:</label>
            <input name="email">
            <button onClick="formToAPI(event,'email')">Send an Email</button>
            <br><br>
            <label>SMS:</label>
            <input name="sms">
            <button onClick="formToAPI(event,'sms')">Send a SMS</button>
        </div>
    </form>
</body>
```
> The **FormToApi()** function and its arguments will be explained below when creating the *FormToApi.js* script.

In the end, the main page should look like this:

``` html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Project 2 - Cloud Is Free</title>
    <script src="formToAPI.js"></script>
</head>
<body>
    <form>
        <div>
            <label>Message:</label>
            <input type="text" name="message">
            <br><br>
            <label>Email:</label>
            <input name="email">
            <button onClick="formToAPI(event,'email')">Send an Email</button>
            <br><br>
            <label>SMS:</label>
            <input name="sms">
            <button onClick="formToAPI(event,'sms')">Send a SMS</button>
        </div>
    </form>
</body>
</html>
```

The main page *index.html* is ready, now it's time for the *formToApi.js* script.

### Create POST script *formToApi.js*

First, create a JavaScript file *formToApi.js*, in which the **formToApi()** function will be created:

``` js
function formToAPI(event, typeOfSending) {
```

The function has **event** and **typeOfSending** as arguments.

The **typeOfSending** argument is already known to everyone, if its value is *email* then an email will be sent, and if its value is *sms* then a SMS will be sent.

The **event** argument contains the event that occurred when the JS script was called. Here, it is the click on a button (**onClick** argument) that launched the function **formToApi()**, and the **onClick** argument by default redirects to the file containing the function (*formToApi.js*). You must therefore prevent the redirection to the *formToApi.js* file and remain on the main page *index.html* when you click on a button.

And to do this, use the **preventDefault()** method, which prevents the default action of the **onClick** argument:

``` js
    event.preventDefault()
```

>  To better understand the preventDefault() method: https://developer.mozilla.org/en-US/docs/Web/API/Event/preventDefault

All you need to remember is that:
- **event** is used to prevent page redirection;
- **typeOfSending** is used to specify the type of sending.

Now that the arguments of the **formToApi()** function are understood, it is time to send the data to the API.

To do this, create a **data** variable containing all the **variables** to be sent to the API, **typeOfSending**, **destinationEmail**, **phoneNumber** and **message**:

``` js
    var data = {
        typeOfSending: ,
        destinationEmail:,
        phoneNumber: ,
        message:
    }
```

But how can this data be retrieved? It's simple: the value of **typeOfSending** has been retrieved in the argument **typeOfSending** of the function, so you just need to call the argument of the same name:

``` js
    var data = {
        typeOfSending: typeOfSending,
        destinationEmail: ,
        phoneNumber: ,
        message:
    }
```

And for the other three arguments, you need to retrieve the values contained in the form, and this will be possible using the **name** attribute previously filled in. Remember, in *index.html*, each *<<span>input>* has a **name** (for example name="message" for the <<span>input> containing the message).

To do this, use the **getElementsByName** method, which, as its name suggests, retrieves an element (or elements) based on the name.
This gives:

``` js
    var data = {
        typeOfSending: typeOfSending,
        destinationEmail: document.getElementsByName('email')[0].value,
        phoneNumber: document.getElementsByName('sms')[0].value,
        message: document.getElementsByName('message')[0].value
    }
```

> To learn more about getElementsByName: https://www.w3schools.com/jsref/met_doc_getelementsbyname.asp

You now need to send this data to the previously created REST API using the **fetch()** method. Here, this is how **fetch()** should be written:

``` js
    fetch( "<API_url>" , {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data),
        mode: "no-cors"
    })
}
```

> To learn more about fetch(): https://javascript.info/fetch-api

The method **fetch()** has two arguments, the first containing the URL of the API, and the second containing several options (here **method**, **headers**, **body** and **mode**). Let's look at these options in detail.

**method** designates the method to use to interact with the API. Here you want to send data, so you have to use the *POST* method.

**headers** contains the headers you want to add to the request. Here you specify that the content (what is in the **body**) is of type JSON, so you fill in: *"Content-Type": "application/json "*

**body** contains the content to be sent during the request. You have to add the data (*data* variable) in the body, and in JSON format (*JSON.stringify*) to be readable by the API.

**mode** specifies the mode you want to use for the request. The mode used here is *no-cors* in order to receive an opaque response from the API. In some cases, we prefer to get an explicit response from the API (to get an image with a GET method for example), but in this case, it is not a problem to receive an opaque response since the only method that will be used is POST. The *no-cors* mode strengthens the security since potential attackers won't be able to retrieve anything from the API.

> For those who want to know more about opaque responses: https://tpiros.dev/blog/what-is-an-opaque-response/


The script *formToApi.js* should now look like this:

``` js
function formToAPI(event, typeOfSending) {

    event.preventDefault()

    var data = {
        typeOfSending: typeOfSending,
        destinationEmail: document.getElementsByName('email')[0].value,
        phoneNumber: document.getElementsByName('sms')[0].value,
        message: document.getElementsByName('message')[0].value
    }

    fetch( "<API_url>" , {
        method: "POST",
        headers: {
            "Content-Type": "application/json"
        },
        body: JSON.stringify(data),
        mode: "no-cors"
    })
}
```

:warning:`When filling the API URL, you need to put the Invoke URL of the API AND the resource containing the POST method at the end of the Invoke URL.`

**Example:**

| Invoke URL | Resource | API URL |
| ---------- | -------- | --------|
|  https://tgykfcp526.execute-api.us-east-1.amazonaws.com/sendingStage  | sending | https://tgykfcp526.execute-api.us-east-1.amazonaws.com/sendingStage/sending |

Now is the time to test the website. 

> In order to test the website, I strongly advise you to set up a local web server. For VSCode users, this tutorial explains very well how to do it: https://www.youtube.com/watch?v=tk8wLMJ7diQ

Test the website by going to the main page, and trying to send an email and a SMS:

![Sending Email](images/sending-email.png ':size=300')

Wait a few seconds, before going to the mailbox of the destination mail:

![Email Received](images/email-received.png ':size=300')

The email has been received, now it's time to send a SMS:

![Sending SMS](images/sending-sms.png ':size=300')

Wait a few seconds, and the SMS should be received.

The website works perfectly, only one last step left in the project: upload the website on S3.

### Upload the website on S3

Go to S3 and create a bucket. Assign the bucket name of your choice:

![Create Bucket](images/create-bucket.png ':size=600')

Then allow the bucket to be publicly available on the Internet:

![Public Access Settings Bucket](images/public-access-settings-bucket.png ':size=600')

You can then create the bucket.

Once the bucket is created, go to its configuration and upload the *index.html* and *formToApi.js* files:

![Upload Files](images/upload-files.png ':size=600')

Go to the **Properties** tab, section **Static website hosting** (at the very bottom) and click on **Edit**:

![Static Web Hosting](images/static-website-hosting.png ':size=700')

*Enable* the **Static website hosting**, and fill in the *index.html* file in the **Index document** field before validating the **Static website hosting** configuration:

![Configure Hosting](images/configure-hosting.png ':size=600')

Move to **Permissions** to modify the Bucket Policy:

![Edit Bucket policy](images/edit-bucket-policy.png ':size=1000')

Insert the following policy and modify it slightly before validating:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::bucket_name/*"
            ]
        }
    ]
}
```

This Bucket policy allows:
- Assign read rights to objects via the Action ''s3:GetObject'' ;
- The Targeted Resources are the objects in your S3 Bucket.

:warning: `Do not forget to replace the *bucket_name* field with the name of the S3 Bucket, and keep the /* at the end of the Resource field, otherwise you won't give access to the Bucket objects!`

In this example, the Bucket policy now looks like this:

![Bucket policy added](images/bucket-policy-added.png ':size=1350')

All that remains is to apply the new Bucket policy; the pages of the website will now be publicly accessible. It should be displayed *publicly accessible* below the name of the S3 Bucket:

![Publicly Accessible](images/publicly-accessible.png ':size=200')

Go back to **Properties** section **Static website hosting** and copy the website link into a new tab:

![Copy URL](images/copy-url.png ':size=800')

The website hosted on S3 is now accessible:

![Website Accessible](images/website-accessible.png ':size=800')

Do a final test, by sending an email from S3:

![Email Sent From S3](images/send-email-from-s3.png ':size=300')

Let's see the destination mailbox:

![Email from S3 Received](images/email-s3-received.png ':size=300')

It works. Now time to send a SMS from S3:

![SMS Sent From S3](images/send-sms-from-s3.png ':size=300')

If you receive the message: **Congratulations!**

**You have completed Project 2. You are now fully capable of making Serverless services interact with each other and send instructions to them from a website, all using AWS.**

### [And the bill?](/projects/project-2/part-10/README.md)