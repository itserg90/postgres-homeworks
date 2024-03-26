-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)
SELECT c.company_name, CONCAT(e.title_of_courtesy, ' ', e.first_name, ' ', e.last_name) FROM orders AS o
JOIN customers AS c USING(customer_id)
JOIN employees as e USING(employee_id)
JOIN shippers AS s ON o.ship_via = s.shipper_id
WHERE c.city = 'London' AND e.city = 'London' AND s.company_name = 'United Package'

-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.
SELECT p.product_name, p.units_in_stock, s.contact_name, s.phone FROM categories AS c
JOIN products AS p USING(category_id)
JOIN suppliers AS s USING(supplier_id)
WHERE p.discontinued = 0 AND p.units_in_stock < 25 AND c.category_name in ('Dairy Products', 'Condiments')
ORDER BY p.units_in_stock

-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа
SELECT company_name FROM customers AS c
LEFT JOIN orders AS o USING(customer_id)
WHERE o.customer_id IS NULL

-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.
SELECT DISTINCT p.product_name FROM products AS p
JOIN order_details AS o USING(product_id)
WHERE EXISTS(SELECT o.quantity FROM order_details WHERE o.quantity = 10)