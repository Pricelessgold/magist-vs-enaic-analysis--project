#Can you work out the average monthly income of Tech sellers?

 SELECT 
    round(SUM(ot.price) / count(distinct date_format(o.order_purchase_timestamp, '%Y-%m')), 2) as average_monthly_tech_income
FROM
    order_items ot
        JOIN
    orders o ON o.order_id = ot.order_id
    JOIN products p 
    ON ot.product_id = p.product_id
JOIN product_category_name_translation pc 
    ON p.product_category_name = pc.product_category_name
WHERE pc.product_category_name_english IN ('eletronicos' , 'informatica_acessorios',
        'livros_tecnicos',
        'pc_gamer',
        'relogios_presentes',
        'audio',
        'pcs')
and
    o.order_status = 'delivered';
    
    
    #What’s the average time between the order being placed and the product being delivered?
    
    SELECT 
    ROUND(AVG(TIMESTAMPDIFF(DAY,
                order_purchase_timestamp,
                order_delivered_customer_date)))
FROM
    orders
WHERE
  order_delivered_customer_date IS NOT NULL;
    
    
    
    #How many orders are delivered on time vs orders delivered with a delay?

SELECT 
    CASE
        WHEN order_delivered_customer_date <= order_estimated_delivery_date THEN 'on_time'
        ELSE 'delayed'
    END AS delivery_status,
    COUNT(*) AS number_delievered
FROM
    orders
WHERE
   order_delivered_customer_date IS NOT NULL
    group by delivery_status;
    
    