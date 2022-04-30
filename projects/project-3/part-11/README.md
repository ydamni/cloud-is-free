## And the bill?

> For those who have already completed other projects before, you can skip the intro and step *A. Decimal Separator*, and go directly to step *B. One month invoice*.

For the more hesitant who do not want to follow this tutorial blindly and wish to verify that this project will not cost them more than the advertised price: you are right to ask!

So I'm showing you, in my use case, my AWS bill over a month of going live.
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
You can finally analyze the evolution of a bill from this project over a month.


### B.	One month invoice


#### EC2:

![Elastic Compute Cloud](images/elastic-compute-cloud.png ':size=800')

**What is observed:**
- Usage (Free Tier:  750 hours per month of t2.micro instance usage):
    - 672 Hours = 89.6% of the Free Tier used.
- EBS (Free Tier: 30 GB of General Purpose (SSD) or Magnetic):
    - 27.585 GB provisioned = 92% of the Free Tier used.


#### ECS:

![Elastic Container Service](images/elastic-container-service.png ':size=800')

**What is observed:**
- Free Tier: used on EC2, so relies on EC2 billing.


#### EFS:

![Elastic File System](images/elastic-file-system.png ':size=800')

**What is observed:**
- Storage (Free Tier: 5 GB of Storage):
    - 0.002 GB of Storage = 0.04% of the Free Tier used.


#### RDS:

![Relational Database Service](images/relational-database-service.png ':size=800')

**What is observed:**
- Usage (750 Hours per month of db.t2.micro & db.t3.micro database usage):
    - 655 + 17 Hours => 672 Hours in total =  89.6% of the Free Tier used.
- Storage (20 GB of General Purpose (SSD) database storage):
    - 18.636 GB provisioned = 93% of the Free Tier used.


...

In one month, the Free Tier was used at a **maximum of 93%**. No cost have been incurred.

#### In one month, the Free Tier threshold will never be exceeded. The *Database and Containers* project is completely free of charge.


### [Finish the project](../)