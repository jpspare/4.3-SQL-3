--1. List all customers who live in Texas (use JOINs)
select first_name, last_name
from customer
inner join address
on customer.address_id = address.address_id
where district = 'Texas';
--Answer: Jennifer Davis, Kim Cruz, Richard McCrary, Bryan Hardison, and Ian Still

--2. Get all payments above $6.99 with the Customer's Full Name
select first_name, last_name, amount
from payment
inner join customer
on payment.customer_id = customer.customer_id
where amount > 6.99;
-- Answer: See query results; 27 results

--3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name
from customer
where customer_id in(
	select customer_id
	from payment
	where amount > 175
);
-- Answer: Mary Smith and Douglas Graf

--4. List all customers that live in Nepal (use the city table)
select first_name, last_name
from customer
full join address
on customer.address_id = address.address_id
full join city
on address.city_id = city.city_id
full join country
on city.country_id = country.country_id
where country = 'Nepal';
-- Answer: Kevin Schuler


--5. Which staff member had the most transactions?
select staff.first_name, staff.last_name, payment.staff_id, COUNT(payment.staff_id)
from staff
full join payment
on staff.staff_id = payment.staff_id
group by payment.staff_id, staff.first_name, staff.last_name
having count(payment.staff_id) = (
	select max(staff_transactions)
	from (select staff_id, count(staff_id) as staff_transactions
	from payment
	group by staff_id
	) as q
);
-- Answer: Jon Stephens

--6. How many movies of each rating are there?
select COUNT(film_id), rating
from film
group by rating
order by rating;
--Answer: G: 178; PG: 194; PG-13: 223; R: 196; NC-17: 209

--7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select customer_id, first_name, last_name
from customer
where customer_id in (
	select customer_id
	from payment
	where amount > 6.99
	group by customer_id
	having count(payment_id)=1
);
--Answer: Douglas Graf, Alvin Deloach, and Alfredo McAdams

--8. How many free rentals did our stores give away?
select count(rental.rental_id)
from rental
left join payment
on rental.rental_id = payment.rental_id
where payment.rental_id is null;
--Answer: 1,452