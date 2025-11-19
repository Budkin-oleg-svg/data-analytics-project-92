INSERT INTO "with global_avg as (
select 
ROUND(AVG(p.price * s.quantity),0) as global_avg -- вычисляем среднюю выручку по всем продавцам
from sales s -- склеиваем таблицы
inner join products p on s.product_id = p.product_id
), seller_avg as (
select 
CONCAT(e.first_name, ' ', e.last_name) as seller,-- склеиваем 2 столбца
ROUND(avg(p.price * s.quantity),0) as average_income
from sales s -- склеиваем таблицы
inner join employees e on s.sales_person_id = e.employee_id
inner join products p on s.product_id = p.product_id 
group by e.first_name, e.last_name
order by average_income desc
)
select 
seller,
average_income
from seller_avg 
cross join global_avg
where seller_avg.average_income < global_avg
order by seller_avg.average_income asc" (seller,average_income) VALUES
	 ('Stearns MacFeather',46407),
	 ('Ann Dull',55091),
	 ('Morningstar Greene',88124),
	 ('Marjorie Green',109396),
	 ('Johnson White',126134),
	 ('Anne Ringer',136768),
	 ('Cheryl Carson',139818),
	 ('Reginald Blotchet-Halls',151773),
	 ('Charlene Locksley',152007),
	 ('Michael O''Leary',161108);
INSERT INTO "with global_avg as (
select 
ROUND(AVG(p.price * s.quantity),0) as global_avg -- вычисляем среднюю выручку по всем продавцам
from sales s -- склеиваем таблицы
inner join products p on s.product_id = p.product_id
), seller_avg as (
select 
CONCAT(e.first_name, ' ', e.last_name) as seller,-- склеиваем 2 столбца
ROUND(avg(p.price * s.quantity),0) as average_income
from sales s -- склеиваем таблицы
inner join employees e on s.sales_person_id = e.employee_id
inner join products p on s.product_id = p.product_id 
group by e.first_name, e.last_name
order by average_income desc
)
select 
seller,
average_income
from seller_avg 
cross join global_avg
where seller_avg.average_income < global_avg
order by seller_avg.average_income asc" (seller,average_income) VALUES
	 ('Burt Gringlesby',167993),
	 ('Abraham Bennet',170983),
	 ('Sylvia Panteley',179518),
	 ('Meander Smith',188076),
	 ('Sheryl Hunter',225516);
