-- =====================================
-- Отчёт 0: Отчет о количестве покупателей
-- =====================================


select
    COUNT(distinct customer_id) as customers_count
from customers;


-- =====================================
-- Отчёт 1: Отчет о десятке лучших продавцов
-- =====================================


select
    CONCAT(e.first_name, ' ', e.last_name) as seller,
    COUNT(s.sales_id) as operations,
    FLOOR(SUM(p.price * s.quantity)) as income
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
    select
    FLOOR(AVG(p.price * s.quantity)) as global_avg
    from sales as s
    inner join products as p on s.product_id = p.product_id
),

seller_avg as (
    select
        CONCAT(e.first_name, ' ', e.last_name) as seller,
        FLOOR(AVG(p.price * s.quantity)) as average_income
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
  trim(TO_CHAR(s.sale_date, 'day')) AS day_of_week,
  FLOOR(SUM(p.price * s.quantity)) AS income
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
    FLOOR(SUM(s.quantity * p.price)) as income
from sales as s
inner join products as p on s.product_id = p.product_id
group by selling_month
order by selling_month;



-- =====================================
-- Отчёт 6: Покупатели, первая покупка которых была в ходе проведения акций.
-- =====================================


WITH first_sales AS (
  SELECT
    s.customer_id,
    CONCAT(c.first_name, ' ', c.last_name) AS customer,
    s.sale_date,
    CONCAT(e.first_name, ' ', e.last_name) AS seller,
    ROW_NUMBER() OVER (PARTITION BY s.customer_id ORDER BY s.sale_date) AS rn
  FROM sales s
  JOIN employees e ON e.employee_id = s.sales_person_id
  JOIN products p ON p.product_id = s.product_id
  JOIN customers c ON c.customer_id = s.customer_id
  WHERE p.price = 0
)
SELECT
  customer,
  sale_date,
  seller
FROM first_sales
WHERE rn = 1  
ORDER BY customer_id;



