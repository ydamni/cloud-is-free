## Create and configure S3 Buckets

To host your static website, you will need to create an S3 Bucket containing the pages of your website, then you will put the Bucket in public to make it accessible to all.

In this example, the domain name will be *cif-project.com*.

The files that will be installed in the S3 Bucket and that will serve as pages for the website, are downloadable on GitHub to this link: [Github link](https://github.com/ydamni/cloud-is-free/tree/main/projects/project-1/resources)

##### Now, let’s start.

Did you know that when a user accesses a website, he does so in two ways:

- The user enters the www name of the website (e.g. *www<nolink>.cif-project.com*) in the search bar;
- The user enters the non-www name of the website (e.g. *cif-project.com*) in the search bar.

So how to make a website accessible via these two names? It's simple, by creating two S3 Buckets: a **main** Bucket which will contain the pages of the website, and which will be in public; and a **redirect** Bucket which will redirect the traffic it receives to the main Bucket.

:warning: `S3 Buckets MUST have the same name as the corresponding website name, so that AWS can route the traffic from the website to the right Bucket!`

Before starting to create two S3 Buckets, there are two choices:
- Make the www name (*www<nolink>.cif-project.com*) the main address of the website;
- Make the non-www name (*cif-project.com*) the main address of the website.

This will decide what the final URL displayed to the user will be.

For example, Amazon has chosen to have the address of its website in www :

![Amazon www](images/amazon-www.png ':size=250')

While Twitter has decided to have the address of its website in non-www :

![Twitter non-www](images/twitter-non-www.png ':size=250')

So, which one should you choose? Well… it doesn't matter, do as you please. Don't waste too much time on this detail, or you'll end up in the [Bike Shed Effect!](https://bikeshed.com/)

For this example, the website will have the non-www name as main address: *cif-project.com*.


### A.	Main S3 Bucket

To begin with, create the main S3 Bucket which must have the same name as the website you are hosting:

![General configuration Main](images/general-configuration-main.png ':size=700')

Then allow this Bucket to be publicly available on the Internet:

![Public Access Settings Bucket](images/public-access-settings-bucket.png ':size=800')

The main Bucket is now created, it is time to install the files of your website. To do this, go to your Bucket and click on **Upload**:

![Upload Objects](images/upload-objects.png ':size=1200')

Add previously downloaded *index.html* and *error.html* files:

![How to Upload](images/how-to-upload.png ':size=1300')

The files are now objects in the main S3 Bucket:

![Files and Folders](images/files-and-folders.png ':size=750')

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

![Publicly Available](images/publicly-available.png ':size=200')

Last step: activate static web hosting by going to the **Static website hosting section**, at the bottom of the **Properties tab**:

![Static Web Hosting disabled](images/static-web-hosting-disabled.png ':size=1100')

Start by activating and hosting your static website, and indicate the name of your index (*index.html*) and error (*error.html*) documents:

![Edit Static Web hosting main](images/edit-static-web-hosting-main.png ':size=700')

After saving changes, all you need to do is check that the site is accessible from a public address. Go back to the **Static website hosting section** to get the temporary URL of the S3 Bucket:

![Copy URL main Bucket](images/copy-url-main-bucket.png ':size=1400')

Now let's see what the S3 Bucket displays:

![Nice Job main Bucket](images/nice-job-main-bucket.png ':size=600')

Perfect! You have access to your main page of the website (*index.html*), the website is in public access on the internet.

Mission accomplished for the main S3 Bucket, now it's time for the redirect S3 Bucket.

### B.	Redirect S3 Bucket

First, create the redirect S3 Bucket that will redirect all the traffic it receives to the main S3 Bucket:

![General Configuration redirect](images/general-configuration-redirect.png ':size=700')

Then, go to the **Bucket configuration** > **Properties tab** > **Static website hosting section**:

![Static Web Hosting disabled](images/static-web-hosting-disabled.png ':size=1100')

Activate the static website hosting, but this time by redirecting the requests. Specify the target Bucket (in this example *cif-project.com*), and leave the **Protocol field** as it is for the moment (*none*):

![Edit Static Web Hosting redirect](images/edit-static-web-hosting-redirect.png ':size=700')

Get the URL of your redirect S3 Bucket:

![Copy URL redirect Bucket](images/copy-url-redirect-bucket.png ':size=1200')

Time to see the result:

![Site can't be reached](images/site-cant-be-reached.png ':size=1000')

There is good news and bad news:
- The good news is that the redirection is done: you are redirected to your website (in this example *cif-project.com*);
- The bad news is that the website does not link to anything... `This site can't be reached`.

To remedy this problem, you need to indicate somewhere that your domain name redirects to the main S3 Bucket so that you can access your static website.

And for that, you need to use Route 53 again by configuring your previously created hosted zone.

### [Link the domain to S3 Buckets with Route 53](/projects/project-1/part-5/README.md)