
-- USE shopsphere;
-- SELECT DATABASE();
-- USE shopsphere;

-- CREATE TABLE customers (
--     Customer_ID VARCHAR(20) PRIMARY KEY,
--     Customer_Name VARCHAR(100),
--     Gender VARCHAR(20),
--     Age INT,
--     City VARCHAR(100),
--     State VARCHAR(100),
--     Signup_Date DATE,
--     Customer_Segment VARCHAR(50)
-- );

-- CREATE TABLE products (
--     Product_ID VARCHAR(20) PRIMARY KEY,
--     Product_Name VARCHAR(150),
--     Category VARCHAR(100),
--     Sub_Category VARCHAR(100),
--     Unit_Cost DECIMAL(10,2),
--     Unit_Price DECIMAL(10,2)
-- );

-- CREATE TABLE orders (
--     Order_ID VARCHAR(20) PRIMARY KEY,
--     Customer_ID VARCHAR(20),
--     Order_Date DATE,
--     Order_Status VARCHAR(30),
--     Payment_Method VARCHAR(50),
--     Shipping_Method VARCHAR(50),
--     FOREIGN KEY (Customer_ID) REFERENCES customers(Customer_ID)
-- );

-- CREATE TABLE order_items (
--     Order_ID VARCHAR(20),
--     Product_ID VARCHAR(20),
--     Quantity INT,
--     Discount_Percent DECIMAL(5,2),
--     Unit_Selling_Price DECIMAL(10,2),
--     PRIMARY KEY (Order_ID, Product_ID),
--     FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID),
--     FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
-- );

-- CREATE TABLE shipping (
--     Order_ID VARCHAR(20) PRIMARY KEY,
--     Shipping_Date DATE,
--     Expected_Delivery_Date DATE,
--     Delivery_Date DATE,
--     Delivery_Status VARCHAR(30),
--     Shipping_Cost DECIMAL(10,2),
--     FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
-- );

-- CREATE TABLE returns (
--     Return_ID VARCHAR(20) PRIMARY KEY,
--     Order_ID VARCHAR(20),
--     Return_Date DATE,
--     Return_Reason VARCHAR(100),
--     Refund_Amount DECIMAL(12,2),
--     FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID)
-- );

-- SELECT COUNT(*) AS customer_count
-- FROM customers;

-- SELECT COUNT(*) AS product_count
-- FROM products;

-- SELECT COUNT(*) AS order_count
-- FROM orders;

-- SELECT COUNT(*) AS current_rows
-- FROM order_items;

-- SELECT 
--     Order_ID,
--     Product_ID,
--     COUNT(*) AS item_count
-- FROM order_items
-- GROUP BY Order_ID, Product_ID
-- HAVING COUNT(*) > 1
-- LIMIT 10;

-- DROP TABLE order_items;

-- CREATE TABLE order_items (
--     Line_Item_ID INT AUTO_INCREMENT PRIMARY KEY,
--     Order_ID VARCHAR(20),
--     Product_ID VARCHAR(20),
--     Quantity INT,
--     Discount_Percent DECIMAL(5,2),
--     Unit_Selling_Price DECIMAL(10,2),
--     FOREIGN KEY (Order_ID) REFERENCES orders(Order_ID),
--     FOREIGN KEY (Product_ID) REFERENCES products(Product_ID)
-- );

--  USE shopsphere;
-- SELECT COUNT(*) AS order_item_count
-- FROM order_items;

-- SELECT COUNT(*) AS shipping_count
-- FROM shipping;

-- SELECT COUNT(*) AS return_count
-- FROM returns;

-- SELECT 'Customers' AS Table_Name, COUNT(*) AS Row_Count FROM customers
-- UNION ALL
-- SELECT 'Products', COUNT(*) FROM products
-- UNION ALL
-- SELECT 'Orders', COUNT(*) FROM orders
-- UNION ALL
-- SELECT 'Order Items', COUNT(*) FROM order_items
-- UNION ALL
-- SELECT 'Shipping', COUNT(*) FROM shipping
-- UNION ALL
-- SELECT 'Returns', COUNT(*) FROM returns;

-- SELECT COUNT(*) AS orphan_orders
-- FROM orders o
-- LEFT JOIN customers c
--     ON o.Customer_ID = c.Customer_ID
-- WHERE c.Customer_ID IS NULL;

-- SELECT COUNT(*) AS orphan_order_items
-- FROM order_items oi
-- LEFT JOIN orders o
--     ON oi.Order_ID = o.Order_ID
-- WHERE o.Order_ID IS NULL;

-- SELECT COUNT(*) AS orphan_product_items
-- FROM order_items oi
-- LEFT JOIN products p
--     ON oi.Product_ID = p.Product_ID
-- WHERE p.Product_ID IS NULL;

-- SELECT COUNT(*) AS orphan_shipping
-- FROM shipping s
-- LEFT JOIN orders o
--     ON s.Order_ID = o.Order_ID
-- WHERE o.Order_ID IS NULL;

-- SELECT COUNT(*) AS orphan_returns
-- FROM returns r
-- LEFT JOIN orders o
--     ON r.Order_ID = o.Order_ID
-- WHERE o.Order_ID IS NULL;

SELECT
    COUNT(DISTINCT o.Order_ID) AS total_orders,
    SUM(oi.Quantity) AS total_quantity_sold,
    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,
    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ) / COUNT(DISTINCT o.Order_ID),
        2
    ) AS average_order_value
FROM orders o
JOIN order_items oi
    ON o.Order_ID = oi.Order_ID
WHERE o.Order_Status IN ('Delivered', 'Returned');

SELECT
    p.Category,
    SUM(
        oi.Quantity
        * oi.Unit_Selling_Price
        * (1 - oi.Discount_Percent / 100)
    ) AS total_revenue
FROM orders o
JOIN order_items oi
    ON o.Order_ID = oi.Order_ID
JOIN products p
    ON oi.Product_ID = p.Product_ID
WHERE o.Order_Status IN ('Delivered', 'Returned')
GROUP BY p.Category
ORDER BY total_revenue DESC;

SELECT
    p.Category,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * p.Unit_Cost
        ),
        2
    ) AS total_cost,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        -
        SUM(
            oi.Quantity
            * p.Unit_Cost
        ),
        2
    ) AS total_profit

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY p.Category

ORDER BY total_profit DESC;

SELECT
    p.Category,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(oi.Quantity * p.Unit_Cost),
        2
    ) AS total_cost,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        - SUM(oi.Quantity * p.Unit_Cost),
        2
    ) AS total_profit,

    ROUND(
        (
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            )
            - SUM(oi.Quantity * p.Unit_Cost)
        )
        /
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        * 100,
        2
    ) AS profit_margin_percent

FROM orders o
JOIN order_items oi
    ON o.Order_ID = oi.Order_ID
JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY p.Category

ORDER BY profit_margin_percent DESC;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,

    SUM(
        oi.Quantity
        * oi.Unit_Selling_Price
        * (1 - oi.Discount_Percent / 100)
    ) AS total_revenue,

    SUM(oi.Quantity) AS units_sold

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category

ORDER BY total_revenue DESC

LIMIT 10;

SELECT
    p.Product_ID,
    p.Product_Name,
    p.Category,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity * p.Unit_Cost
        ),
        2
    ) AS total_cost,

    ROUND(
        (
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            )
            - SUM(oi.Quantity * p.Unit_Cost)
        )
        /
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        * 100,
        2
    ) AS profit_margin_percent

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category

ORDER BY profit_margin_percent DESC

LIMIT 10;

SELECT
    c.Customer_Segment,

    COUNT(DISTINCT o.Customer_ID) AS total_customers,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY c.Customer_Segment

ORDER BY total_revenue DESC;

SELECT
    c.Customer_Segment,

    COUNT(DISTINCT c.Customer_ID) AS total_customers,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        / COUNT(DISTINCT c.Customer_ID),
        2
    ) AS revenue_per_customer

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY c.Customer_Segment

ORDER BY revenue_per_customer DESC;SELECT
    c.Customer_Segment,

    COUNT(DISTINCT c.Customer_ID) AS total_customers,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        / COUNT(DISTINCT c.Customer_ID),
        2
    ) AS revenue_per_customer

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY c.Customer_Segment

ORDER BY revenue_per_customer DESC;

SELECT
    DATE_FORMAT(o.Order_Date, '%Y-%m') AS month,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    SUM(oi.Quantity) AS units_sold,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY DATE_FORMAT(o.Order_Date, '%Y-%m')

ORDER BY month;


SELECT
    YEAR(o.Order_Date) AS year,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    SUM(oi.Quantity) AS units_sold,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY YEAR(o.Order_Date)

ORDER BY year;

SELECT
    ROUND(
        (
            SUM(
                CASE
                    WHEN YEAR(o.Order_Date) = 2025 THEN
                        oi.Quantity
                        * oi.Unit_Selling_Price
                        * (1 - oi.Discount_Percent / 100)
                    ELSE 0
                END
            )
            -
            SUM(
                CASE
                    WHEN YEAR(o.Order_Date) = 2024 THEN
                        oi.Quantity
                        * oi.Unit_Selling_Price
                        * (1 - oi.Discount_Percent / 100)
                    ELSE 0
                END
            )
        )
        /
        SUM(
            CASE
                WHEN YEAR(o.Order_Date) = 2024 THEN
                    oi.Quantity
                    * oi.Unit_Selling_Price
                    * (1 - oi.Discount_Percent / 100)
                ELSE 0
            END
        )
        * 100,
        2
    ) AS yoy_revenue_growth_percent

FROM orders o
JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned');

SELECT
    YEAR(o.Order_Date) AS year,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        / COUNT(DISTINCT o.Order_ID),
        2
    ) AS average_order_value

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY YEAR(o.Order_Date)

ORDER BY year;

SELECT
    CASE
        WHEN oi.Discount_Percent = 0 THEN 'No Discount'
        WHEN oi.Discount_Percent <= 10 THEN '1-10%'
        WHEN oi.Discount_Percent <= 20 THEN '11-20%'
        WHEN oi.Discount_Percent <= 30 THEN '21-30%'
        ELSE '30%+'
    END AS discount_range,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * (
                oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
                - p.Unit_Cost
            )
        ),
        2
    ) AS total_profit

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    CASE
        WHEN oi.Discount_Percent = 0 THEN 'No Discount'
        WHEN oi.Discount_Percent <= 10 THEN '1-10%'
        WHEN oi.Discount_Percent <= 20 THEN '11-20%'
        WHEN oi.Discount_Percent <= 30 THEN '21-30%'
        ELSE '30%+'
    END

ORDER BY total_revenue DESC;

SELECT
    CASE
        WHEN oi.Discount_Percent = 0 THEN 'No Discount'
        WHEN oi.Discount_Percent <= 10 THEN '1-10%'
        WHEN oi.Discount_Percent <= 20 THEN '11-20%'
        WHEN oi.Discount_Percent <= 30 THEN '21-30%'
        ELSE '30%+'
    END AS discount_range,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * (
                oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
                - p.Unit_Cost
            )
        ),
        2
    ) AS total_profit,

    ROUND(
        (
            SUM(
                oi.Quantity
                * (
                    oi.Unit_Selling_Price
                    * (1 - oi.Discount_Percent / 100)
                    - p.Unit_Cost
                )
            )
            /
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            )
        ) * 100,
        2
    ) AS profit_margin_percent

FROM orders o

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    CASE
        WHEN oi.Discount_Percent = 0 THEN 'No Discount'
        WHEN oi.Discount_Percent <= 10 THEN '1-10%'
        WHEN oi.Discount_Percent <= 20 THEN '11-20%'
        WHEN oi.Discount_Percent <= 30 THEN '21-30%'
        ELSE '30%+'
    END

ORDER BY profit_margin_percent DESC;

SELECT
    c.State,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    SUM(oi.Quantity) AS units_sold,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * (
                oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
                - p.Unit_Cost
            )
        ),
        2
    ) AS total_profit

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY c.State

ORDER BY total_revenue DESC

LIMIT 10;

SELECT
    c.State,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * (
                oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
                - p.Unit_Cost
            )
        ),
        2
    ) AS total_profit,

    ROUND(
        (
            SUM(
                oi.Quantity
                * (
                    oi.Unit_Selling_Price
                    * (1 - oi.Discount_Percent / 100)
                    - p.Unit_Cost
                )
            )
            /
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            )
        ) * 100,
        2
    ) AS profit_margin_percent

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY c.State

ORDER BY profit_margin_percent DESC

LIMIT 10;


SELECT
    COUNT(DISTINCT Order_ID) AS total_shipped_orders,

    ROUND(
        AVG(
            DATEDIFF(Delivery_Date, Shipping_Date)
        ),
        2
    ) AS average_delivery_days,

    SUM(
        CASE
            WHEN Delivery_Status = 'On Time' THEN 1
            ELSE 0
        END
    ) AS on_time_orders,

    SUM(
        CASE
            WHEN Delivery_Status = 'Late' THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        (
            SUM(
                CASE
                    WHEN Delivery_Status = 'On Time' THEN 1
                    ELSE 0
                END
            )
            / COUNT(*)
        ) * 100,
        2
    ) AS on_time_delivery_percent

FROM shipping;


SELECT
    o.Shipping_Method,

    COUNT(DISTINCT s.Order_ID) AS total_orders,

    SUM(
        CASE
            WHEN s.Delivery_Status = 'On Time' THEN 1
            ELSE 0
        END
    ) AS on_time_orders,

    SUM(
        CASE
            WHEN s.Delivery_Status = 'Late' THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        SUM(
            CASE
                WHEN s.Delivery_Status = 'Late' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS late_delivery_percent

FROM shipping s

JOIN orders o
    ON s.Order_ID = o.Order_ID

GROUP BY o.Shipping_Method

ORDER BY late_delivery_percent DESC;

SELECT
    c.State,

    COUNT(DISTINCT s.Order_ID) AS total_orders,

    SUM(
        CASE
            WHEN s.Delivery_Status = 'Late' THEN 1
            ELSE 0
        END
    ) AS late_orders,

    ROUND(
        SUM(
            CASE
                WHEN s.Delivery_Status = 'Late' THEN 1
                ELSE 0
            END
        ) / COUNT(*) * 100,
        2
    ) AS late_delivery_percent

FROM shipping s

JOIN orders o
    ON s.Order_ID = o.Order_ID

JOIN customers c
    ON o.Customer_ID = c.Customer_ID

GROUP BY c.State

HAVING COUNT(DISTINCT s.Order_ID) >= 500

ORDER BY late_delivery_percent DESC

LIMIT 10;

SELECT
    s.Delivery_Status,

    COUNT(DISTINCT s.Order_ID) AS total_orders,

    COUNT(DISTINCT r.Order_ID) AS returned_orders,

    ROUND(
        COUNT(DISTINCT r.Order_ID)
        / COUNT(DISTINCT s.Order_ID) * 100,
        2
    ) AS return_rate_percent

FROM shipping s

JOIN orders o
    ON s.Order_ID = o.Order_ID

LEFT JOIN returns r
    ON s.Order_ID = r.Order_ID

GROUP BY s.Delivery_Status

ORDER BY return_rate_percent DESC;

SELECT
    Return_Reason,

    COUNT(*) AS total_returns,

    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM returns),
        2
    ) AS return_percentage,

    ROUND(
        SUM(Refund_Amount),
        2
    ) AS total_refund_amount

FROM returns

GROUP BY Return_Reason

ORDER BY total_returns DESC;

SELECT
    p.Product_ID,

    p.Product_Name,

    p.Category,

    COUNT(DISTINCT r.Return_ID) AS total_returns,

    ROUND(
        SUM(r.Refund_Amount),
        2
    ) AS total_refund_amount

FROM returns r

JOIN order_items oi
    ON r.Order_ID = oi.Order_ID

JOIN products p
    ON oi.Product_ID = p.Product_ID

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category

ORDER BY total_returns DESC

LIMIT 10;

SELECT
    p.Product_ID,

    p.Product_Name,

    p.Category,

    COUNT(DISTINCT oi.Order_ID) AS total_orders,

    COUNT(DISTINCT r.Return_ID) AS returned_orders,

    ROUND(
        COUNT(DISTINCT r.Return_ID)
        / COUNT(DISTINCT oi.Order_ID) * 100,
        2
    ) AS return_rate_percent

FROM order_items oi

JOIN products p
    ON oi.Product_ID = p.Product_ID

JOIN orders o
    ON oi.Order_ID = o.Order_ID

LEFT JOIN returns r
    ON oi.Order_ID = r.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    p.Product_ID,
    p.Product_Name,
    p.Category

HAVING COUNT(DISTINCT oi.Order_ID) >= 100

ORDER BY return_rate_percent DESC

LIMIT 10;

SELECT
    p.Category,

    COUNT(DISTINCT oi.Order_ID) AS total_orders,

    COUNT(DISTINCT r.Return_ID) AS returned_orders,

    ROUND(
        COUNT(DISTINCT r.Return_ID)
        / COUNT(DISTINCT oi.Order_ID) * 100,
        2
    ) AS return_rate_percent

FROM order_items oi

JOIN products p
    ON oi.Product_ID = p.Product_ID

JOIN orders o
    ON oi.Order_ID = o.Order_ID

LEFT JOIN returns r
    ON oi.Order_ID = r.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY p.Category

ORDER BY return_rate_percent DESC;

SELECT
    Return_Reason,

    COUNT(*) AS total_returns,

    ROUND(
        COUNT(*) /
        (SELECT COUNT(*) FROM returns) * 100,
        2
    ) AS return_percentage,

    ROUND(
        SUM(Refund_Amount),
        2
    ) AS total_refund_amount

FROM returns

GROUP BY Return_Reason

ORDER BY total_returns DESC;

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Segment,
    c.City,
    c.State,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Segment,
    c.City,
    c.State

ORDER BY total_revenue DESC

LIMIT 10;

SELECT
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Segment,

    COUNT(DISTINCT o.Order_ID) AS total_orders,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS total_revenue,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        )
        / COUNT(DISTINCT o.Order_ID),
        2
    ) AS average_order_value

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    c.Customer_ID,
    c.Customer_Name,
    c.Customer_Segment

HAVING COUNT(DISTINCT o.Order_ID) >= 3

ORDER BY average_order_value DESC

LIMIT 10;

USE shopsphere;
SELECT
    c.Customer_ID,
    c.Customer_Name,
    MAX(o.Order_Date) AS last_order_date

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    c.Customer_ID,
    c.Customer_Name

ORDER BY last_order_date DESC

LIMIT 10;

SELECT
    c.Customer_ID,
    c.Customer_Name,
    COUNT(DISTINCT o.Order_ID) AS frequency

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    c.Customer_ID,
    c.Customer_Name

ORDER BY frequency DESC

LIMIT 10;

SELECT
    c.Customer_ID,
    c.Customer_Name,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS monetary_value

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    c.Customer_ID,
    c.Customer_Name

ORDER BY monetary_value DESC

LIMIT 10;

SELECT
    c.Customer_ID,
    c.Customer_Name,

    DATEDIFF(
        '2025-12-31',
        MAX(o.Order_Date)
    ) AS recency_days,

    COUNT(DISTINCT o.Order_ID) AS frequency,

    ROUND(
        SUM(
            oi.Quantity
            * oi.Unit_Selling_Price
            * (1 - oi.Discount_Percent / 100)
        ),
        2
    ) AS monetary_value

FROM customers c

JOIN orders o
    ON c.Customer_ID = o.Customer_ID

JOIN order_items oi
    ON o.Order_ID = oi.Order_ID

WHERE o.Order_Status IN ('Delivered', 'Returned')

GROUP BY
    c.Customer_ID,
    c.Customer_Name;
    
    WITH rfm AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,

        DATEDIFF(
            '2025-12-31',
            MAX(o.Order_Date)
        ) AS recency_days,

        COUNT(DISTINCT o.Order_ID) AS frequency,

        ROUND(
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            ),
            2
        ) AS monetary_value

    FROM customers c

    JOIN orders o
        ON c.Customer_ID = o.Customer_ID

    JOIN order_items oi
        ON o.Order_ID = oi.Order_ID

    WHERE o.Order_Status IN ('Delivered', 'Returned')

    GROUP BY
        c.Customer_ID,
        c.Customer_Name
),

rfm_scores AS (
    SELECT
        *,
        
        6 - NTILE(5) OVER (
            ORDER BY recency_days
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary_value
        ) AS monetary_score

    FROM rfm
)

SELECT
    Customer_ID,
    Customer_Name,
    recency_days,
    frequency,
    monetary_value,
    recency_score,
    frequency_score,
    monetary_score,

    CONCAT(
        recency_score,
        frequency_score,
        monetary_score
    ) AS rfm_score

FROM rfm_scores

ORDER BY
    recency_score DESC,
    frequency_score DESC,
    monetary_score DESC

LIMIT 20;

WITH rfm AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,

        DATEDIFF(
            '2025-12-31',
            MAX(o.Order_Date)
        ) AS recency_days,

        COUNT(DISTINCT o.Order_ID) AS frequency,

        ROUND(
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            ),
            2
        ) AS monetary_value

    FROM customers c

    JOIN orders o
        ON c.Customer_ID = o.Customer_ID

    JOIN order_items oi
        ON o.Order_ID = oi.Order_ID

    WHERE o.Order_Status IN ('Delivered', 'Returned')

    GROUP BY
        c.Customer_ID,
        c.Customer_Name
),

rfm_scores AS (
    SELECT
        *,
        
        6 - NTILE(5) OVER (
            ORDER BY recency_days
        ) AS recency_score,

        NTILE(5) OVER (
            ORDER BY frequency
        ) AS frequency_score,

        NTILE(5) OVER (
            ORDER BY monetary_value
        ) AS monetary_score

    FROM rfm
)

SELECT
    Customer_ID,
    Customer_Name,
    recency_days,
    frequency,
    monetary_value,
    recency_score,
    frequency_score,
    monetary_score,

    CASE

        WHEN recency_score >= 4
             AND frequency_score >= 4
             AND monetary_score >= 4
        THEN 'High Value'

        WHEN recency_score >= 4
             AND frequency_score >= 4
        THEN 'Loyal'

        WHEN recency_score >= 4
             AND monetary_score >= 4
        THEN 'Potential High Value'

        WHEN recency_score <= 2
             AND frequency_score >= 4
        THEN 'At Risk'

        WHEN recency_score <= 2
             AND monetary_score >= 4
        THEN 'At Risk High Spender'

        ELSE 'Regular'

    END AS customer_segment

FROM rfm_scores;

WITH rfm AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,

        DATEDIFF(
            '2025-12-31',
            MAX(o.Order_Date)
        ) AS recency_days,

        COUNT(DISTINCT o.Order_ID) AS frequency,

        ROUND(
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            ),
            2
        ) AS monetary_value

    FROM customers c
    JOIN orders o
        ON c.Customer_ID = o.Customer_ID
    JOIN order_items oi
        ON o.Order_ID = oi.Order_ID

    WHERE o.Order_Status IN ('Delivered', 'Returned')

    GROUP BY
        c.Customer_ID,
        c.Customer_Name
),

rfm_scores AS (
    SELECT
        *,
        6 - NTILE(5) OVER (ORDER BY recency_days) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value) AS monetary_score
    FROM rfm
),

segmented AS (
    SELECT
        *,
        CASE
            WHEN recency_score >= 4
                 AND frequency_score >= 4
                 AND monetary_score >= 4
                THEN 'High Value'

            WHEN recency_score >= 4
                 AND frequency_score >= 4
                THEN 'Loyal'

            WHEN recency_score >= 4
                 AND monetary_score >= 4
                THEN 'Potential High Value'

            WHEN recency_score <= 2
                 AND frequency_score >= 4
                THEN 'At Risk'

            WHEN recency_score <= 2
                 AND monetary_score >= 4
                THEN 'At Risk High Spender'

            ELSE 'Regular'
        END AS customer_segment
    FROM rfm_scores
)

SELECT
    customer_segment,
    COUNT(*) AS total_customers
FROM segmented
GROUP BY customer_segment
ORDER BY total_customers DESC;

WITH rfm AS (
    SELECT
        c.Customer_ID,
        c.Customer_Name,

        DATEDIFF(
            '2025-12-31',
            MAX(o.Order_Date)
        ) AS recency_days,

        COUNT(DISTINCT o.Order_ID) AS frequency,

        ROUND(
            SUM(
                oi.Quantity
                * oi.Unit_Selling_Price
                * (1 - oi.Discount_Percent / 100)
            ),
            2
        ) AS monetary_value

    FROM customers c
    JOIN orders o
        ON c.Customer_ID = o.Customer_ID
    JOIN order_items oi
        ON o.Order_ID = oi.Order_ID

    WHERE o.Order_Status IN ('Delivered', 'Returned')

    GROUP BY
        c.Customer_ID,
        c.Customer_Name
),

rfm_scores AS (
    SELECT
        *,
        6 - NTILE(5) OVER (ORDER BY recency_days) AS recency_score,
        NTILE(5) OVER (ORDER BY frequency) AS frequency_score,
        NTILE(5) OVER (ORDER BY monetary_value) AS monetary_score
    FROM rfm
),

segmented AS (
    SELECT
        *,
        CASE
            WHEN recency_score >= 4
                 AND frequency_score >= 4
                 AND monetary_score >= 4
                THEN 'High Value'

            WHEN recency_score >= 4
                 AND frequency_score >= 4
                THEN 'Loyal'

            WHEN recency_score >= 4
                 AND monetary_score >= 4
                THEN 'Potential High Value'

            WHEN recency_score <= 2
                 AND frequency_score >= 4
                THEN 'At Risk'

            WHEN recency_score <= 2
                 AND monetary_score >= 4
                THEN 'At Risk High Spender'

            ELSE 'Regular'
        END AS customer_segment
    FROM rfm_scores
)

SELECT
    customer_segment,

    COUNT(*) AS total_customers,

    ROUND(
        SUM(monetary_value),
        2
    ) AS total_revenue,

    ROUND(
        AVG(monetary_value),
        2
    ) AS average_customer_value

FROM segmented

GROUP BY customer_segment

ORDER BY total_revenue DESC;