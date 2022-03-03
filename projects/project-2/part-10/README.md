## And the bill?

:warning: `This part will be completed in the future once the project is invoiced over a week and then a month. For the moment, only step A. Decimal Separator will be available. Thank you for your patience.`

> For those who have already completed other projects before, you can skip the intro and step *A. Decimal Separator*, and go directly to step *B. One week invoice*.

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

### [Finish the project](../)