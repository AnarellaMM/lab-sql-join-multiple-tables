use sakila; 
-- Write a query to display for each store its store ID, city, and country.
select s.store_id, a.city_id, a.district, a.address
from store s
join address a on s.address_id = a.address_id;

-- Write a query to display how much business, in dollars, each store brought in.
select s.store_id, sum(p.amount) as total_business
from store s
join customer c on s.store_id = c.store_id
join payment p on c.customer_id = p.customer_id
group by s.store_id;

-- What is the average running time of films by category?
-- Which film categories are longest?
select c.name as category_name, avg(f.length) as average_running_time
from category c
join film_category fc on c.category_id = fc.category_id
join film f ON fc.film_id = f.film_id
group by c.category_id, category_name
ORDER BY average_running_time DESC;

-- Display the most frequently rented movies in descending order.
select f.film_id, f.title, count(*) as rental_count
from film f
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
group by f.film_id, f.title
order by rental_count desc;

-- List the top five genres in gross revenue in descending order.
select c.name as genre, sum(p.amount) as gross_revenue
from category c
join film_category fc on c.category_id = fc.category_id
join film f on fc.film_id = f.film_id
join inventory i on f.film_id = i.film_id
join rental r on i.inventory_id = r.inventory_id
join payment p on r.rental_id = p.rental_id
group by c.category_id, genre
order by gross_revenue desc
LIMIT 5;

-- Is "Academy Dinosaur" available for rent from Store 1?
select f.title, s.store_id, count(*) as availability
from film f
join inventory i on f.film_id = i.film_id
join store s on i.store_id = s.store_id
where f.title = 'Academy Dinosaur' and s.store_id = 1
group by f.title, s.store_id;