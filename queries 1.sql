
--Первый отчет о десятке лучших продавцовю

select 
CONCAT(e.first_name, ' ', e.last_name) as seller,-- склеиваем 2 столбца
COUNT(s.sales_id) as operations,-- считаем колтчество сделок
ROUND(SUM(p.price * s.quantity),0) as income -- вычисляем общую выручку продавца за все время
from sales s -- склеиваем таблицы
inner join employees e on s.sales_person_id = e.employee_id
inner join products p on s.product_id = p.product_id 
group by e.first_name, e.last_name
order by income desc
limit 10; -- ограничиваем количество продавцов



--Второй отчет содержит информацию о продавцах, чья средняя выручка за сделку меньше средней выручки за сделку по всем продавцам.

with global_avg as (
select 
ROUND(AVG(p.price * s.quantity),0) as global_avg 
from sales s 
inner join products p on s.product_id = p.product_id
), seller_avg as ( 
select 
CONCAT(e.first_name, ' ', e.last_name) as seller,
ROUND(avg(p.price * s.quantity),0) as average_income 
from sales s 
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
order by seller_avg.average_income asc;

--Третий отчет содержит информацию о выручке по дням недели.

SELECT 
CONCAT(e.first_name, ' ', e.last_name) as seller,
TO_CHAR(sale_date, 'Day') as day_of_week,
ROUND(SUM(p.price * s.quantity),0) as income
from sales s 
inner join employees e on s.sales_person_id = e.employee_id
inner join products p on s.product_id = p.product_id 
group by seller, day_of_week, EXTRACT(ISODOW FROM sale_date)
order by EXTRACT(ISODOW FROM sale_date), seller


