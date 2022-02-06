## Create a hosted zone

Before continuing, you must have the following question in your head: *what is a hosted zone?*

See how AWS defines it:

*A hosted zone is a container for records, and records contain information about how you want to route traffic for a specific domain, such as example.com, and its subdomains (acme.example.com, zenith.example.com). A hosted zone and the corresponding domain have the same name.*

> https://docs.aws.amazon.com/en_en/Route53/latest/DeveloperGuide/hosted-zones-working-with.html

Now that you know what a hosted zone is, let's look at how to create one:

##### If you have your domain name with AWS
Your hosted zone has been automatically created, you will not need to do anything. I invite you to [skip this part and go directly to the next one](/projects/project-1/part-4/README.md).

##### If you have your domain name with a third-party domain registrar
You will see right away how to create your hosted zone.

First, create your hosted zone, where you specify your domain name, in the example *cif-project.com*; then specify that you want your hosted zone to be public, otherwise it will be inaccessible from the public internet:

![Create hosted zone](images/create-hosted-zone.png ':size=700')

Your hosted zone is now created, and contains DNS records of type NS (Name Server) and SOA (Start of Authority):

![Hosted zone](images/hosted-zone.png ':size=1000')

Now you need to link your domain name purchased from a third-party domain registrar with your hosted zone. To do this, you will need to map the NS records of your hosted zone to the DNS configuration of the domain purchased from the domain registrar. The DNS configuration of the purchased domain can be easily found in the domain registrar’s dashboard.

An example will clarify the situation; here is how to do it with the third-party domain registrar, *Hostinger*:

> The two following pictures have been retrieved from this link: https://support.hostinger.com/en/articles/1696789-how-to-change-nameservers-at-hostinger

First of all, go to the dashboard of the domain registrar by connecting to the customer area, then ask to change the DNS servers of the domain name:

![Change DNS Hostinger](images/change-dns-hostinger.png ':size=700')

You are redirected to a page, where you specify the names of the DNS servers contained in the NS record of the hosted zone:

![Choose Nameservers Hostinger](images/choose-nameservers-hostinger.png ':size=700')

Insert in these fields the NS records of your hosted zone:

:warning: `When you copy a NS record, delete the dot at the end !`

![Copy NS records](images/copy-ns-records.png ':size=1000')

Once the settings are done, wait a few minutes before checking the propagation in real time with a DNS information search tool (e.g. *nslookup*). If you are not familiar with this kind of tool, some websites offer this type of service to simplify your life. Here is a relatively efficient one: https://www.whatsmydns.net/#NS

Verify that all the public DNS in the world have the information that your domain name uses the NS of your AWS hosted zone. When it's done, you can get down to real business: creating your S3 buckets.

### [Create and configure S3 Buckets](/projects/project-1/part-4/README.md)