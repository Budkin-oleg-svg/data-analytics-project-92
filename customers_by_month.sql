INSERT INTO "select 
TO_CHAR(sale_date, 'yyyy-mm') as selling_month,
count(distinct customer_id) as total_customers,
round(sum(quantity * p.price),0) as income
from sales s
inner join products p on s.product_id = p.product_id
group by selling_month
order by selling_month" (selling_month,total_customers,income) VALUES
	 ('1992-09',226,2618930332),
	 ('1992-10',230,8358113699),
	 ('1992-11',228,8031353738),
	 ('1992-12',229,7708189847);
