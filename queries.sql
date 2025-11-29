-- =====================================
-- Отчёт 1: Отчет о десятке лучших продавцов
-- =====================================


select
    CONCAT(e.first_name, ' ', e.last_name) as seller,
    COUNT(s.sales_id) as operations,
    ROUND(SUM(p.price * s.quantity), 0) as income
from sales as s
inner join employees as e on s.sales_person_id = e.employee_id
inner join products as p on s.product_id = p.product_id
group by e.first_name, e.last_name
order by income desc
limit 10;



-- =====================================
-- Отчёт 2: Информация о продавцах, чья средняя выручка за сделку меньше средней выручки за сделку по всем продавцам
-- =====================================


with global_avg as (
    select ROUND(AVG(p.price * s.quantity), 0) as global_avg
    from sales as s
    inner join products as p on s.product_id = p.product_id
),

seller_avg as (
    select
        CONCAT(e.first_name, ' ', e.last_name) as seller,
        ROUND(AVG(p.price * s.quantity), 0) as average_income
    from sales as s
    inner join employees as e on s.sales_person_id = e.employee_id
    inner join products as p on s.product_id = p.product_id
    group by e.first_name, e.last_name
    order by average_income desc
)

select
    seller_avg.seller,
    seller_avg.average_income
from seller_avg 
cross join global_avg
where seller_avg.average_income < global_avg.global_avg
order by seller_avg.average_income asc;



-- =====================================
-- Отчёт 3: Информация о выручке по дням недели
-- =====================================


SELECT
    CONCAT(e.first_name, ' ', e.last_name) AS seller,
    TO_CHAR(s.sale_date, 'Day') AS day_of_week,
    ROUND(SUM(p.price * s.quantity), 0) AS income
FROM sales AS s
INNER JOIN employees AS e ON s.sales_person_id = e.employee_id
INNER JOIN products AS p ON s.product_id = p.product_id
GROUP BY seller, day_of_week, EXTRACT(ISODOW FROM s.sale_date)
ORDER BY EXTRACT(ISODOW FROM s.sale_date), seller;



-- =====================================
-- Отчёт 4: Количество покупателей в разных возрастных группах: 16-25, 26-40 и 40+.
-- =====================================


select
    case
        when age between 16 and 25 then '16-25'
        when age between 25 and 40 then '26-40'
        when age > 40 then '40+'
    end as age_category,
    count(*) as age_count
from customers
group by age_category
order by age_category;



-- =====================================
-- Отчёт 5: Данные по количеству уникальных покупателей и выручке, которую они принесли.
-- =====================================


select
    TO_CHAR(s.sale_date, 'yyyy-mm') as selling_month,
    COUNT(distinct s.customer_id) as total_customers,
    ROUND(SUM(s.quantity * p.price), 0) as income
from sales as s
inner join products as p on s.product_id = p.product_id
group by selling_month
order by selling_month;



-- =====================================
-- Отчёт 6: Покупатели, первая покупка которых была в ходе проведения акций.
-- =====================================


with zero_product as (
    select
        s.customer_id,
        s.product_id,
        p.price,
        s.sales_person_id,
        MIN(s.sale_date) as first_purchase_date
    from sales as s
    inner join products as p on s.product_id = p.product_id
    group by s.customer_id, s.product_id, p.price, s.sales_person_id
    having p.price = 0
)

select
    zp.first_purchase_date as sale_date,
    CONCAT(c.first_name, ' ', c.last_name) as customer,
    CONCAT(e.first_name, ' ', e.last_name) as seller
from customers as c
inner join zero_product as zp on c.customer_id = zp.customer_id
inner join employees as e on zp.sales_person_id = e.employee_id
order by customer;




