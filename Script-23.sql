-- =====================================
-- Отчёт 1: Средний доход по компании
-- =====================================
-- Вычисляет глобальное среднее значение выручки от продаж (цена × количество).
-- Используется как эталон для сравнения с доходами продавцов.

with global_avg as (
select
	ROUND(AVG(p.price * s.quantity), 0) as global_avg
from
	sales as s
inner join products as p on
	s.product_id = p.product_id
)
select
	*
from
	global_avg;



-- =====================================
-- Отчёт 2: Доходы продавцов
-- =====================================
-- Рассчитывает средний доход каждого продавца (по сумме цена × количество).
-- Результаты сортируются по убыванию дохода.

WITH seller_avg AS (
    SELECT
        CONCAT(e.first_name, ' ', e.last_name) AS seller,
        ROUND(AVG(p.price * s.quantity), 0) AS average_income
    FROM sales AS s
    INNER JOIN employees AS e ON s.sales_person_id = e.employee_id
    INNER JOIN products AS p ON s.product_id = p.product_id
    GROUP BY e.first_name, e.last_name
    ORDER BY average_income DESC
)
SELECT * FROM seller_avg;



-- =====================================
-- Отчёт 3: Продавцы ниже среднего
-- =====================================
-- Выводит продавцов, чей средний доход ниже глобального среднего.
-- Сортировка: по возрастанию дохода продавца.

WITH global_avg AS (
    SELECT ROUND(AVG(p.price * s.quantity), 0) AS global_avg
    FROM sales AS s
    INNER JOIN products AS p ON s.product_id = p.product_id
),
seller_avg AS (
    SELECT
        CONCAT(e.first_name, ' ', e.last_name) AS seller,
        ROUND(AVG(p.price * s.quantity), 0) AS average_income
    FROM sales AS s
    INNER JOIN employees AS e ON s.sales_person_id = e.employee_id
    INNER JOIN products AS p ON s.product_id = p.product_id
    GROUP BY e.first_name, e.last_name
    ORDER BY average_income DESC
)
SELECT
    seller_avg.seller,
    seller_avg.average_income
FROM seller_avg
CROSS JOIN global_avg
WHERE seller_avg.average_income < global_avg.global_avg
ORDER BY seller_avg.average_income ASC;