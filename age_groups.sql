INSERT INTO "select 
case --классифицируем покупателей по возрастным группам
when age between 16 and 25 then '16-25'
when age between 25 and 40 then '26-40'
when age > 40 then '40+'
end as age_category,
count(*) as age_count --подсчитываем количество покупателей в каждой группе
from customers c
group by age_category
order by age_category" (age_category,age_count) VALUES
	 ('16-25',2663),
	 ('26-40',5139),
	 ('40+',11957);
