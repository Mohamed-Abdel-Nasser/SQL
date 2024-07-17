--SQL Server Nested Quarries 

--Example 1: Using ANY
--Find all products that belong to any category with the name 'Mountain Bikes'.

		SELECT product_name
		FROM production.products
		WHERE category_id = ANY (
			SELECT category_id
			FROM production.categories
			WHERE category_name = 'Mountain Bikes'
		);
--Example 2: Using ALL
--Find all products with a list price higher than all products in the 'Road Bikes' category.

		SELECT p.product_name
		FROM production.products p
		WHERE list_price > ALL (
			SELECT list_price
			FROM production.products p
			JOIN production.categories c ON p.category_id = c.category_id
			WHERE c.category_name = 'Electric Bikes'
			);
--Example 3: Nested Query with IN
--List customers who have placed an order.

		SELECT first_name, last_name
		FROM sales.customers
		WHERE customer_id IN (
			SELECT customer_id
			FROM sales.orders
			);
--Example 4: Correlated Subquery
--Find the stores that have more than 50 products in stock.

		SELECT store_name
		FROM sales.stores s
		WHERE 50 < (
			SELECT SUM(quantity)
			FROM production.stocks st
			WHERE st.store_id = s.store_id
			);


--Example 5: Subquery with EXISTS
--Find the names of products that have been ordered at least once.
		SELECT p.product_name
		FROM production.products p
		WHERE EXISTS (
			SELECT 1
			FROM sales.order_items oi
			WHERE oi.product_id = p.product_id
		);


--Example 6: Finding Customers with High-Value Orders

SELECT c.customer_id, c.first_name, c.last_name
FROM sales.customers c
WHERE EXISTS (
    SELECT 1
    FROM sales.orders o
    JOIN sales.order_items oi ON o.order_id = oi.order_id
    WHERE o.customer_id = c.customer_id
    GROUP BY o.customer_id
    HAVING SUM(oi.quantity * oi.list_price * (1 - oi.discount / 100)) > 1000
);



