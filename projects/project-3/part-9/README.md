## Create dashboards with Metabase

The database contains all the company's data, so why not use this data to make statistics.

> Statistics is the study of phenomena based on data.

Statistics are nowadays essential for the evolution of a company. Statistics allow a store to study buying behaviors and to know which products are or will be in trend.

There are an infinite number of possible statistics, but for this project, 4 statistics will be made from the data recently added in the database:
- The most purchased products;
- The most purchased categories of products;
- The best customers;
- The sales revenues.

And nothing better to set up these statistics than Metabase.


## Before starting

Connect to Metabase:

![Connect Metabase](images/connect-metabase.png ':size=900')

You need to add the newly created database (*computer_store*), to do this go to **Admin settings**, then **Databases** and select **Add database**:

![Add database](images/add-database.png ':size=900')

The configuration is the same as when the *mysql* database was added, but this time you have to set your database name (*computer_store*) as **Database name**:

![Database Config](images/database-config.png ':size=500')

Once the database is created, all you have to do is open the **SQL Query** menu, then select the Computer Store database:

![SQL Query](images/sql-query.png ':size=900')

You are now ready to create statistics on Metabase.


## Most purchased products

To have the list of the most purchased products, you must:
- Select the name of the products &rarr; **name** field from *products* table;
- Calculate the number of times each product has been purchased &rarr; **count the orders** in the *orders* table;
- Correlate the *products* & *orders* tables &rarr; link the **id** and **product_id** fields.

This is what the request looks like:

```sql
SELECT products.name, COUNT(*) AS purchased
FROM products, orders
WHERE products.id=orders.product_id
GROUP BY products.name
ORDER BY COUNT(*) DESC
```

The result of the query should look like this:

![Most Purchased Products](images/most-purchased-products.png ':size=250')

All that remains is to save:

![Save Most Purchased Products](images/save-most-purchased-products.png ':size=900')


## Most purchased categories of products

The principle is exactly the same.

To have the list of the most purchased categories of products, you must:
- Select the name of the categories &rarr; **category** field from *products* table;
- Calculate the number of times each category has been purchased &rarr; **count the orders** in the *orders* table;
- Correlate the *products* & *orders* tables &rarr; link the **id** and **product_id** fields.

This is what the request looks like:

```sql
SELECT products.category, COUNT(*) AS purchased
FROM products, orders
WHERE products.id=orders.product_id
GROUP BY products.category
ORDER BY COUNT(*) DESC
```

The result of the query should look like this:

![Most Purchased Categories Of Products](images/most-purchased-categories-products.png ':size=250')

All that remains is to save:

![Save Most Purchased Categories Of Products](images/save-most-purchased-categories-products.png ':size=900')


## Best customers

To have the list of the best customers, you must:
- Select the name of the customer &rarr; **first_name** & **last_name** field from *customers* table;
- Calculate the number of times each customer has made a purchase &rarr; **count the orders** in the *orders* table;
- Correlate the *customers* & *orders* tables &rarr; link the **id** and **customer_id** fields.

This is what the request looks like:

```sql
SELECT CONCAT(customers.first_name,' ',customers.last_name) AS customer, COUNT(*) AS purchases
FROM customers, orders
WHERE customers.id=orders.customer_id
GROUP BY customer
ORDER BY COUNT(*) DESC
```

The result of the query should look like this:

![Best Customers](images/best-customers.png ':size=250')

All that remains is to save:

![Save Best Customers](images/save-best-customers.png ':size=900')


## Sales revenues

To find the sale revenues, you simply have to :
- Sum up the purchases costs &rarr; sum up the **cost** field from *orders* table.

This is what the request looks like:

```sql
SELECT SUM(orders.cost)
FROM orders
```

The result of the query should look like this:

![Sales Revenues](images/sales-revenues.png ':size=100')

All that remains is to save:

![Save Sales Revenues](images/save-sales-revenues.png ':size=900')

All the statistics are ready, now it's time to put them together in a single Dashboard.


## Final Dashboard

First, create a Dashboard and give it a name, here the name of the Dashboard will be *Computer Store Dashboard* (nothing simpler):

![Create Dashboard](images/create-dashboard.png ':size=900')

To finish with a flourish, you will complete the Dashboard on your own. Try to have a Dashboard that looks like this:

![Computer Store Dashboard](images/computer-store-dashboard.png ':size=900')

And now, with the right modifications, try to have a Dashboard that looks like that:

![Dashboard Completed](images/dashboard-completed.png ':size=900')

If your Dashboard is completed and looks like the one above, then...

**Congratulations!** You are now capable to:
- Create a MySQL database on RDS;
- Deploy database software tools in ECS containers;
- Make files from an ECS container persistent using EFS;
- Structure and manipulate a database from tools installed in containers

### [Why using ECS & EC2 instead of EC2 only?](/projects/project-3/part-10/README.md)