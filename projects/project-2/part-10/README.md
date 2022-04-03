## And the bill?


> For those who have already completed other projects before, you can skip the intro and step *A. Decimal Separator*, and go directly to step *B. One month invoice*.

For the more hesitant who do not want to follow this tutorial blindly and wish to verify that this project will not cost them more than the advertised price: you are right to ask!

So I'm showing you, in my use case, my AWS bill over a week and a month of going live.
But before, let's look at this:

![How many requests](images/how-many-requests.png ':size=800')

Here is a sample of my bill, we are interested in the number of requests here, and I have a question for you:
##### What value are you reading?
- A.	1012 Requests
- B.	1 012 000 Requests
- C.	1,012 Requests

The correct answer is A. If you chose answer B, you have probably seen two commas or two dots, and if you chose answer C, you are not totally wrong. In fact, it all depends on your decimal separator.

### A.	Decimal Separator
A little general knowledge doesn't hurt:

In the world, there are several types of notations to separate the integer part from the decimal part: the dot, the comma and the momayyez (also called the Arabic decimal separator).
The graph below shows the decimal separator according to the country:

![Decimal Separator](images/decimal-separator.png ':size=350')

Link: https://en.wikipedia.org/wiki/Decimal_separator

But what’s the problem?

Using the example above, with a number of 1,012.000 queries, it can be read differently by an American and a French person:
- The American reads "one thousand twelve";
- The French reads " one point zero twelve ";
- And whoever thought he saw two commas or two periods read "one million twelve thousand".

It ends up with totally different values, you can easily go from one to a million on a reading error.

##### As AWS is an American company, the decimal separator is the American one.

This means:
- The comma **,** is used to space out the thousands, e.g.: one billion = 1,000,000,000
- The dot **.** separates the integer part from the decimal part, ex: ½ = 0.5

You now know how to read an AWS invoice without any problem.
You can finally analyze the evolution of a bill from this project over a week and a month.

### B.	One week invoice


#### S3:
S3 Bucket is created in us-east-1, so we refer to the billing for that region only.

![S3](images/simple-storage-service.png ':size=800')

**What is observed:**
- Requests (Free Tier: 2,000 PUT & 20,000 GET):
    - 93 PUT, COPY, POST or LIST requests used = 4.65% of the Free Tier used;
    - 734 GET requests used = 3.67% of the Free Tier used.
- Storage (Free Tier: 5 GB):
    - 0.000002 GB used = 0.00004% of the Free Tier used.

#### API Gateway:

![API Gateway](images/api-gateway.png ':size=800')

**What is observed:**
- API Gateway Requests (Free Tier: 1 Million API Calls Received):
    - 19 API Gateway Requests = 0.0019% of the Free Tier used.


#### Lambda:

![Lambda](images/lambda.png ':size=800')

**What is observed:**
- GB-seconds (Free Tier: 400,000 GB-Seconds):
    - 1.072 seconds = 0.0003% of the Free Tier used.
- Requests (Free tier: 1,000,000 Requests):
    - 38 Requests = 0,004% of the Free Tier used.


#### Step Functions:

![Step Functions](images/step-functions.png ':size=800')

**What is observed:**
- State Transitions (Free tier: 4,000 state transitions)
    - 60 state transitions = 1.5% of the Free Tier used.


#### SES:

![SES](images/simple-email-service.png ':size=800')

**What is observed:**
- Email Sent (Free tier: 1,000 Outbound messages)
    - 6 email sent = 0.6% of the Free Tier used.


#### SNS:

> SNS is the only service charged, since each SMS sent follows the following billing model: https://aws.amazon.com/sns/sms-pricing/

For your information, the messages were sent to a French phone number.

![SNS](images/simple-notification-service.png ':size=800')

**What is observed:**

- Delivery (Free tier: 1,000 Email Deliveries)
    - 1 Delivery = 0.1% of the Free Tier used.
- Requests (Free tier: 1,000,000 SNS API Requests)
    - 10 Requests = 0.001% of the Free Tier used.
- Pricing by SMS ($0.06933 for sending SMS to France)
    - 8*0.06933 = 0,55464 Dollars
- SMS Sent (see "Pricing by SMS")
    - 8 SMS Sent


...

In one month, the Free Tier was used at a **maximum of 4.65%**, and the price paid was $0.55 for sending 8 SMS to a French phone number.

#### In one month, with light use of the Serverless Sending Application, the Free Tier threshold will never be exceeded. Just be careful about the number of SMS you send.

### [Finish the project](../)