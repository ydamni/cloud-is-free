## Create database structure with phpMyAdmin

#### Before starting

It is time to create a database structure, to which you will add data. And to know what data to add, what better than a simulation of a real use of a database in a company:

Imagine you have a company that sells PC components to individuals; in simple terms, **you own a computer store**.

![Computer Store](images/computer-store.png ':size=500')

In order to know what data should be stored in a database, the following questions must be asked: **what, who and how**?

- What do I sell? Computer products &rarr; I need to create a **products table** that contains the data of my products;
- Who buys my products? Customers &rarr; I need to create a **customers table** that contains the information of my customers;
- How do my customers buy my products? By ordering &rarr; I need to create a **orders table** that stores order information.

From a very simple reflection, your Database now have three tables:

![Computer Store](images/database-tables.png ':size=500')

To start, go to phpMyAdmin and create the new database that will contain these tables:

![Create New Database](images/create-new-database.png ':size=1000')

Name the database before pressing **Create**, here the database will be named *computer_store* :

![Computer Store Database](images/computer-store-database.png ':size=500')

Now that the database is created, let's create the tables.



## *Products* Table

#### Table creation

When creating a table, you must first give it what is called a primary key. **The primary key is used to identify each record in a database table, and is most of the time associated with an id.** The first field of the table will therefore be an **id** serving as primary key.

Each product has its own name (e.g. Mx Click) and category (e.g. mouse), so there will be two other fields **name** and **category** in the table.

Finally, in the case of a store, a product always has a selling price (e.g. $40) and a stock (e.g. 3), so the last two fields of the table will be the **price** and **stock** fields.

Taking into account the corresponding field type, the table looks like this:

![Products Table](images/products-table.png ':size=200')

To create the table in the database, you will need to perform this SQL query in phpMyAdmin:

```sql
CREATE TABLE products
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	name VARCHAR(100),
	category VARCHAR(100),
	price DOUBLE,
	stock INT
);
```

To do this, select the **SQL** window, then insert the query to create the **products** table:

![Products SQL](images/products-sql.png ':size=900')

This message will appear once the table is created:

![Products Table Created](images/products-table-created.png ':size=900')

Next step, add data to this table.


#### Adding data

If you are creative, you can create the data yourself, by inventing the products your store sells.

Here is an example of a list of products:

```sql
INSERT INTO products(name, category, price, stock)
VALUES
	('Superkey 84', 'keyboard', 50, 7),
	('MX Click', 'mouse', 39, 2),
	('Type Pro 2022', 'keyboard', 115, 4),
	('GL Zoom', 'webcam', 70, 13),
	('LEDD Future 5K', 'monitor', 450, 1);
```

If you lack creativity, I allow you to retrieve this example and fill it in your table:

![Add Products](images/add-products.png ':size=900')

Move on to the next table.



## *Customers* Table

#### Table creation

As explained above, the first field of the table will be an **id** serving as primary key.

Each customer has its own first name, last name and age, so there will be three fields **first_name**, **last_name** and **age** in the table.

In order to recontact customers and send them promotional offers or even invoices for their orders, it is necessary to have their email. An **email** field will be added to the table.

Taking into account the corresponding field type, the table looks like this:

![Customers Table](images/customers-table.png ':size=200')

To create the table in the database, you will need to perform this SQL query in phpMyAdmin:

```sql
CREATE TABLE customers
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	first_name VARCHAR(100),
	last_name VARCHAR(100),
	age INT,
	email VARCHAR(100)
);
```
To do this, select the **SQL** window, then insert the query to create the **customers** table:

![Customers SQL](images/customers-sql.png ':size=900')

This message will appear once the table is created:

![Products Table Created](images/customers-table-created.png ':size=900')

Next step, add data to this table.


#### Adding data

If you are creative, you can create the data yourself, by imagining a list of customers from your store.

Here is an example of a list of customers:

```sql
INSERT INTO customers(first_name, last_name, age, email)
VALUES 
	('James', 'Cooper', 27, 'james.cooper@cif-mail.com'),
	('Ruth', 'Dugan', 45, 'ruth.dugan@cif-mail.com'),
	('Victor', 'Jackson', 14, 'victor.jackson@cif-mail.com'),
	('Elizabeth', 'Sullivan', 27, 'elizabeth.sullivan@cif-mail.com'),
	('Connie', 'Jackson', 33, 'connie.jackson@cif-mail.com');
```

If you lack creativity, I allow you to retrieve this example and fill it in your table:

![Add Customers](images/add-customers.png ':size=900')

Move on to the next and last table.



## *Orders* Table

#### Table creation

As explained above, the first field of the table will be an **id** serving as primary key.

An order exists because a customer buys one or more products; **to simplify the table, consider that only 1 product can be bought at a time**. It is therefore necessary that the order contains the information of the customer AND the product purchased, and to do this, the fields **customer_id** and **product_id** will be added to the table.

An order also contains two crucial pieces of information: an order date and the total cost of the order. Two fields will be added, respectively **order_date** and **cost**.

Taking into account the corresponding field type, the table looks like this:

![Orders Table](images/orders-table.png ':size=200')

To create the table in the database, you will need to perform this SQL query in phpMyAdmin:

```sql
CREATE TABLE orders
(
	id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
	customer_id INT,
	product_id INT,
	order_date DATE,
	cost DOUBLE
);
```

To do this, select the **SQL** window, then insert the query to create the **orders** table:

![Orders SQL](images/orders-sql.png ':size=900')

This message will appear once the table is created:

![Products Table Created](images/orders-table-created.png ':size=900')

Next step, add data to this table.


#### Adding data

If you are creative, you can create the data yourself by simulating orders.

Here is an example of a list of orders:

```sql
INSERT INTO orders(customer_id, product_id, order_date, cost)
VALUES
	(1, 3, '2022-01-02', 115),
	(1, 5, '2022-01-02', 450),
	(3, 4, '2022-01-12', 70),
	(2, 4, '2022-01-17', 70),
	(1, 1, '2022-02-01', 50),
	(4, 2, '2022-02-14', 39),
	(4, 3, '2022-02-27', 115),
	(5, 3, '2022-02-28', 115),
	(1, 3, '2022-03-03', 115),
	(2, 1, '2022-03-18', 50);
```

If you lack creativity, I allow you to retrieve this example and fill it in your table:

![Add Orders](images/add-orders.png ':size=900')

Finally. The database is created and contains data in each of its tables. You can now manipulate the data in the database to analyze the information in your store and draw conclusions.

**Next step:** create graphs based on the data in the database using Metabase.

### [Create dashboards with Metabase](/projects/project-3/part-9/README.md)