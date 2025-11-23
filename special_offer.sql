INSERT INTO "with zero_product as ( -- создаем витирину с необходимыми данными
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
    ) --итоговый зарос
    select 
    CONCAT(c.first_name, ' ', c.last_name) as customer,
    zp.first_purchase_date as sale_date,
    CONCAT(e.first_name, ' ', e.last_name) as seller
    from customers c  
    inner join zero_product zp on c.customer_id = zp.customer_id
    inner join employees e on zp.sales_person_id = e.employee_id
    order by customer" (customer,sale_date,seller) VALUES
	 ('Cristina Xu','1992-09-21','Abraham Bennet'),
	 ('Jacob Martinez','1992-09-21','Michael O''Leary'),
	 ('Jared Gray','1992-09-22','Dirk Stringer'),
	 ('Kaitlyn Allen','1992-09-21','Dirk Stringer'),
	 ('Karen Huang','1992-09-21','Dirk Stringer'),
	 ('Krista Gill','1992-09-22','Marjorie Green'),
	 ('Kristen Li','1992-09-21','Michael O''Leary'),
	 ('Levi Gonzalez','1992-09-21','Marjorie Green'),
	 ('Mario Rai','1992-09-21','Abraham Bennet'),
	 ('Mya Coleman','1992-09-24','Michael O''Leary');
INSERT INTO "with zero_product as ( -- создаем витирину с необходимыми данными
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
    ) --итоговый зарос
    select 
    CONCAT(c.first_name, ' ', c.last_name) as customer,
    zp.first_purchase_date as sale_date,
    CONCAT(e.first_name, ' ', e.last_name) as seller
    from customers c  
    inner join zero_product zp on c.customer_id = zp.customer_id
    inner join employees e on zp.sales_person_id = e.employee_id
    order by customer" (customer,sale_date,seller) VALUES
	 ('Olivia Bennett','1992-11-10','Reginald Blotchet-Halls'),
	 ('Olivia Bennett','1992-09-21','Michael O''Leary'),
	 ('Richard Martinez','1992-09-21','Abraham Bennet'),
	 ('Samuel Sharma','1992-09-22','Michael O''Leary'),
	 ('Tyrone Ruiz','1992-09-21','Marjorie Green'),
	 ('Willie Gao','1992-09-22','Michael O''Leary');
