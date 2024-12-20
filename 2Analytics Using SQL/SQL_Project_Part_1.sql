use modelcarsdb;
/*Task1- Customer Data Analysis*/

-- 1. Find the top 10 customers by credit limit.
select * from customers order by creditLimit desc limit 10;
/*Interpretation- Top 10 customers by credit limit have been displayed.*/

-- 2. Find the average credit limit for customers in each country.
select country, avg(creditLimit) from customers group by country order by avg(creditLimit) desc;
/*Interpretation- Average credit limit for customers in each country has been displayed.*/

-- 3. Find the number of customers in each state.
select state, count(*) from customers where state is not null group by state order by count(*) desc;
/*Interpretation- The number of customers in each state have been displayed.*/

-- 4. Find the customers who haven't placed any orders.
select * from customers c 
left join orders o on c.customerNumber=o.customerNumber
where o.customerNumber is null;
/*Interpretation- Customers who haven't placed any orders have been listed.*/

-- 5. Calculate total sales for each customer.
select c.customerNumber, c.customerName, sum(quantityOrdered*priceEach) as total_sales from customers c
join orders o on c.customerNumber=o.customerNumber
join orderdetails d on o.orderNumber=d.orderNumber
group by c.customerNumber
order by total_sales desc;
/*Interpretation- Total sales for each customer has been calculated.*/

-- 6. List customers with their assigned sales representatives.
select c.customerNumber, c.customerName, c.salesRepEmployeeNumber, e.firstName as salesRepfirstName, e.lastName as salesReplastName from customers c
join employees e on c.salesRepEmployeeNumber=e.employeeNumber
where c.salesRepEmployeeNumber=e.employeeNumber
group by c.customerNumber;
/*Interpretation- Customers have been listed with their assigned sales representatives. */

-- 7. Retrieve customer information with their most recent payment details.
select c.customerNumber, c.customerName, p.checkNumber, p.paymentDate, p.amount from customers c
join payments p on c.customerNumber=p.customerNumber
where p.paymentDate in (select max(paymentDate) from payments group by customerNumber);
/*Interpretation- Customer information with their most recent payment details has been retrieved.*/

-- 8. Identify the customers who have exceeded their credit limit.
select c.customerNumber, c.customerName, c.creditLimit, sum(d.quantityOrdered*d.priceEach) as total_sales from customers c
join orders o on c.customerNumber=o.customerNumber
join orderdetails d on o.orderNumber=d.orderNumber
group by c.customerNumber
having sum(d.quantityOrdered*d.priceEach)>c.creditLimit;
/*Interpretation- Customers who have exceeded their credit limit have been identified.*/

-- 9. Find the names of all customers who have placed an order for a product from a specific product line.
select c.customerNumber, c.customerName from customers c
join orders o on c.customerNumber=o.customerNumber
join orderdetails d on o.orderNumber=d.orderNumber
join products p on d.productCode=p.productCode
where productLine='Motorcycles'
group by c.customerNumber
order by c.customerNumber;
/*Interpretation- Names of all customers who have placed an order for a product from the product line 'Motorcycles' have been displayed.*/

-- 10. Find the names of all customers who have placed an order for the most expensive product.
select c.customerNumber, c.customerName from customers c
join orders o on c.customerNumber=o.customerNumber
join orderdetails d on o.orderNumber=d.orderNumber
join products p on d.productCode=p.productCode
where p.MSRP in (select max(p.MSRP) from products)
group by c.customerNumber;
/*Interpretation- Names of all customers who have placed an order for the most expensive product have been displayed.*/

/*Task2- Office Data Analysis*/

-- 1. Count the number of employees working in each office.
select o.officeCode, o.city, count(e.employeeNumber) as total_employees from offices o
join employees e on o.officeCode=e.officeCode
group by o.officeCode;
/*Interpretation- Number of employees working in each office has been displayed.*/

-- 2. Identify the offices with less than a certain number of employees.
select o.officeCode, o.city, count(e.employeeNumber) as no_of_emp from offices o
join employees e on o.officeCode=e.officeCode
group by o.officeCode
having count(e.employeeNumber)<3;
/*Interpretation- The offices with less than 3 employees have been identified.*/

-- 3. List offices along with their assigned territories.
select officeCode, city, territory from offices;
/*Interpretation- Offices along with their assigned territories have been listed.*/

-- 4. Find the offices that have no employees assigned to them.
select o.officeCode, o.city from offices o
join employees e on o.officeCode=e.officeCode 
where e.officeCode is null;
/*Interpretation- There are no offices that have no employees assigned to them.*/

-- 5. Retrieve the most profitable office based on total sales.
select o.officeCode, o.city, sum(quantityOrdered*priceEach) from offices o
join employees e on o.officeCode=e.officeCode
join customers c on e.employeeNumber=c.salesRepEmployeeNumber
join orders od on c.customerNumber=od.customerNumber
join orderdetails d on od.orderNumber=d.orderNumber
group by o.officeCode
order by sum(quantityOrdered*priceEach) desc limit 1;
/*Interpretation- The most profitable office based on total sales is Paris.*/

-- 6. Find the office with the highest number of employees.
select o.officeCode, o.city, count(e.employeeNumber) as total_employees from offices o
join employees e on o.officeCode=e.officeCode
group by o.officeCode
order by count(e.employeeNumber) desc limit 1;
/*Interpretation- The office with the highest number of employees is San Francisco.*/

-- 7. Find the average credit limit for customers in each office.
select o.officeCode, o.city, avg(c.creditLimit) from offices o 
join employees e on o.officeCode=e.officeCode
join customers c on e.employeeNumber=c.salesRepEmployeeNumber
group by o.officeCode;
/*Interpretation- Average credit limit for customers in each office has been displayed.*/

-- 8. Find the number of offices in each country.
select country, count(officeCode) as no_of_offices from offices group by country;
/*Interpretation- Number of offices in each country have been displayed.*/

/*Task3- Product Data Analysis*/

-- 1. Count the number of products in each product line.
select productLine, count(productCode) as no_of_products from products group by productLine order by count(productCode) desc;
/*Interpretation- Number of products in each product line have been displayed.*/

-- 2. Find the product line with the highest average product price.
select productLine, avg(MSRP) as avg_prod_price from products group by productLine order by avg(MSRP) desc limit 1;
/*Interpretation- Product line with the highest average product price is Classic Cars.*/

-- 3. Find all products with a price above or below a certain amount (MSRP should be between 50 and 100).
select * from products where MSRP>90;
select * from products where MSRP<90;
/*Interpretation- All products with a price above or below 90 have been displayed.*/

-- 4. Find the total sales amount for each product line.
select productLine, sum(quantityOrdered*priceEach) as total_sales from products p
join orderdetails o on p.productCode=o.productCode
group by productLine
order by sum(quantityOrdered*priceEach) desc;
/*Interpretation- Total sales amount for each product line has been displayed.*/

-- 5. Identify products with low inventory levels (less than a specific threshold value of 10 for quantityInStock).
select * from products where quantityInStock<10;
/*Interpretation- There are no products with low inventory levels.*/

-- 6. Retrieve the most expensive product based on MSRP.
select * from products order by MSRP desc limit 1;
/*Interpretation- The most expensive product based on MSRP is 1952 Alpine Renault 1300.*/

-- 7. Calculate total sales for each product.
select o.productCode, p.productName, p.productLine, sum(quantityOrdered*priceEach) as total_sales from orderdetails o
join products p on o.productCode=p.productCode group by o.productCode;
/*Interpretation- Total sales for each product has been calculated.*/

-- 8. Identify the top selling products based on total quantity ordered using a stored procedure. The procedure should accept an input parameter to specify the number of top-selling products to retrieve.
DROP procedure IF EXISTS `top_selling_products`;

DELIMITER $$
USE `modelcarsdb`$$
CREATE PROCEDURE `top_selling_products` (in no_of_prod int)
BEGIN
with ranked_prod as (select productCode, sum(quantityOrdered) as total_qty, row_number() over (order by sum(quantityOrdered) desc) as prod_rank from orderdetails group by productCode)
select productCode, total_qty from ranked_prod 
where prod_rank<=no_of_prod 
order by prod_rank;
END$$

DELIMITER ;

call modelcarsdb.top_selling_products(10);
/*Interpretation- This stored procedure accepts no_of_prod as a parameter to specify the number of top-selling products to retrieve based on total quantity ordered.*/

-- 9. Retrieve products with low inventory levels (less than a threshold value of 10 for quantityInStock) within specífic product lines ('Classic Cars', 'Motorcycles').
select * from products where quantityInStock<10 and productLine in ('Motorcycles','Classic Cars');
/*Interpretation- There are no products with low inventory levels within specífic product lines ('Classic Cars', 'Motorcycles').*/

-- 10. Find the names of all products that have been ordered by more than 10 customers.
select p.productCode, p.productName from products p
join orderdetails d on p.productCode=d.productCode
join orders o on d.orderNumber=o.orderNumber
group by p.productCode
having count(distinct o.customerNumber)>10;
/*Interpretation- Names of all products that have been ordered by more than 10 customers have been displayed.*/

-- 11. Find the names of all products that have been ordered more than the average number of orders for their product line.
select p.productCode, p.productName from products p
join orderdetails d on p.productCode=d.productCode
group by p.productCode
having sum(quantityOrdered)>avg(quantityOrdered);
/*Interpretation- Names of all products that have been ordered more than the average number of orders for their product line have been displayed.*/
