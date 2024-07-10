create database airlines;
/*2. Write a query to create a route_details table using suitable data types for 
the fields, such as route_id, flight_num, origin_airport, destination_airport, 
aircraft_id, and distance_miles. Implement the check constraint for the 
flight number and unique constraint for the route_id fields. Also, make sure 
that the distance miles field is greater than 0.*/
use airlines;
describe routes;
create table route_details(flight_number int,route_id int,distance_miles int);
alter table route_details
add constraint flight_number check (flight_number LIKE '[A-Z0-9]*'),
add constraint route_id unique (route_id),
add constraint distance_miles check (distance_miles > 0);

/*3. Write a query to display all the passengers (customers) who have 
travelled in routes 01 to 25. Take data from the passengers_on_flights 
table*/
select * from passengers_on_flights where customer_id between 1 and 25;

/*4. Write a query to identify the number of passengers and total revenue in 
business class from the ticket_details table. */
select count(*) as ticket_details, sum(Price_per_ticket) as total_revenue from ticket_details;

/*5. Write a query to display the full name of the customer by extracting the 
first name and last name from the customer table.*/
select concat(first_name, ' ', last_name) as full_name from customer;

/*6. Write a query to extract the customers who have registered and booked a 
ticket. Use data from the customer and ticket_details tables. */
select customer.customer_id,customer.first_name,customer.last_name from customer join ticket_details on customer.customer_id = ticket_details.no_of_tickets;

-- _________________________doubt______________________________________________
/*7. Write a query to identify the customer’s first name and last name based 
on their customer ID and brand (Emirates) from the ticket_details table. */
select customer.customer_id,customer.first_name,customer.last_name from customer join ticket_details on
customer.customer_id = ticket_details.customer_id where brand = 'emirates';

/*8. Write a query to identify the customers who have travelled by Economy 
Plus class using Group By and Having clause on the passengers_on_flights 
table.*/
select customer_id from passengers_on_flights where class_id = 'Economy Plus' group by customer_id having count(*) > 0;

/*9. Write a query to identify whether the revenue has crossed 10000 using 
the IF clause on the ticket_details table. */
select if(sum(Price_per_ticket) > 10000, 'Revenue has crossed 10000', 'Revenue has not crossed') as revenue_status from ticket_details;

-- _________________________doubt______________________________________________
/*10. Write a query to create and grant access to a new user to perform 
operations on a database. */

/*11. Write a query to find the maximum ticket price for each class using 
window functions on the ticket_details table.  */
select class_id,price_per_ticket,max(Price_per_ticket) over (partition by class_id) as max_price_per_class from ticket_details;

/*12. Write a query to extract the passengers whose route ID is 4 by improving 
the speed and performance of the passengers_on_flights table. */
select * from passengers_on_flights where route_id = 4;

/*13.  For the route ID 4, write a query to view the execution plan of the 
passengers_on_flights table. */
explain select * from passengers_on_flights where route_id = 4;

-- ________________________doubt________________________________________________
/*14. Write a query to calculate the total price of all tickets booked by a 
customer across different aircraft IDs using rollup function. */
select customer_id,aircraft_id,sum(Price_per_ticket) as total_price from ticket_details group by rollup(customer_id, aircraft_id);

-- ________________________doubt________________________________________________
/*15. Write a query to create a view with only business class customers along 
with the brand of airlines. */
select * from business_class_bradns;

/*16. Write a query to create a stored procedure to get the details of all 
passengers flying between a range of routes defined in run time. Also, 
return an error message if the table doesn't exist. */
