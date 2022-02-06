## Use a domain name

To host a website, you first need a domain name in order to access it easily and safely.
To get a domain name, two choices: buy the domain name either from AWS or from a third-party domain registrar.

##### If you never purchased or handled a domain name
the simplest and most comfortable method is to buy your domain at AWS, it is relatively simple to do and you can skip the step of creating a hosted zone and link your domain to it, which can be complex for beginners.

##### If you already purchased or handled domain names with a third-party domain registrar
Do as you wish, if you have a domain registrar that you care about, you are free to buy your domain from it. However, you will have to create a hosted zone and link your domain to it.


### A.	Buy a domain from AWS

For those wishing to purchase their domain name from AWS, follow these steps.

First, go to *Route 53*, then select **Register domain** in order to register a domain name with AWS:

![Route 53 Dashboard](images/route-53-dashboard.png ':size=600')

Then, choose the domain name of your choice and check if it is available via the **Check** button. In this example, the chosen domain is *cif-domain-name-for-aws*, and it is available for any URL extension. Choose the domain extension you want by clicking on **Add to cart**, and proceed to the purchase by pressing **Continue**:

![Choose domain name](images/choose-domain-name.png ':size=700')

To take ownership of a domain, it is necessary to provide personal information (name, first name, address ...); this information is crucial to prove that the domain belongs to you, so **make sure not to provide false information**.

For those who want to preserve their anonymity on the internet, don't worry, it is possible to activate Privacy Protection (also called WHOIS privacy) so that your data will not be visible to any user making WHOIS queries on your domain name. I recommend you to activate it.

:warning: `Some domain extensions do not benefit from this protection of private data (e.g. the .fr extension), so it is important that you select a domain extension that applies this protection (e.g. the .com extension).`

Once you have filled in everything, you can move on to the next step:

![Contact Details](images/contact-details-for-domain.png ':size=550')

Finally, you are asked if you want to activate the automatic renewal of your domain name; in other words, once the domain expires after one year of use, it will be automatically renewed for one year. This allows you to not forget to renew your domain name, and to see it bought by someone else: I recommend you to activate the automatic renewal.
However, if you only want to use this domain for one year, do not activate the automatic renewal.

To complete the purchase of your domain, all that remains is to accept the AWS Domain Name Registration Agreement, and to check the email sent by AWS:

![Complete Order](images/complete-order.png ':size=700')

You now have in your possession a domain name hosted at AWS. Once you have your domain name, it is time for you to create a hosted zone.

### B.	Buy a domain from a third-party domain registrar

For those who prefer to buy their domain name from a third-party domain registrar, I couldn't give you a detailed explanation of how to do it, since there are an endless number of hosting companies offering this service.

If you don't know which third-party domain registrar to go to, I suggest you do your research on the internet and find the one that suits you best; otherwise, don't complicate things and buy a domain from AWS by following the steps above.

Once you have your domain name, it is time for you to create a hosted zone.

### [Create a hosted zone](/projects/project-1/part-3/README.md)