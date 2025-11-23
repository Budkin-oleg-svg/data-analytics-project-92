
////Первый отчет - количество покупателей в разных возрастных группах: 16-25, 26-40 и 40+.////

select 
case 
when age between 16 and 25 then '16-25'
when age between 25 and 40 then '26-40'
when age > 40 then '40+'
end as age_category,
count(*) as age_count 
from customers c
group by age_category
order by age_category;


-- данные по количеству уникальных покупателей и выручке, которую они принесли.

select 
TO_CHAR(sale_date, 'yyyy-mm') as selling_month,
count(distinct customer_id) as total_customers,
round(sum(quantity * p.price),0) as income
from sales s
inner join products p on s.product_id = p.product_id
group by selling_month
order by selling_month;   



-- покупатели, первая покупка которых была в ходе проведения акций.

   with zero_product as 
  ( 
   select
        customer_id,
        MIN(sale_date) AS first_purchase_date,
        s.product_id,
        p.price,
        s.sales_person_id 
    from sales s
    inner join products p on p.product_id = s.product_id
    group by customer_id, s.product_id, p.price, s.sales_person_id 
    having p.price = 0
    )
    select 
    CONCAT(c.first_name, ' ', c.last_name) as customer,
    zp.first_purchase_date as sale_date,
    CONCAT(e.first_name, ' ', e.last_name) as seller
    from customers c  
    inner join zero_product zp on c.customer_id = zp.customer_id
    inner join employees e on zp.sales_person_id = e.employee_id
    order by customer;