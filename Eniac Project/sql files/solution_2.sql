#Are expensive tech products popular?;
        
        
    SELECT 
    CASE 
        WHEN ot.price < 100 THEN 'Low (<100)'
        WHEN ot.price BETWEEN 100 AND 500 THEN 'Mid (100–500)'
        WHEN ot.price > 500 THEN 'High (>500)'
    END AS price_range,
    COUNT(*) AS products_sold
FROM orders o
JOIN order_items ot 
    ON o.order_id = ot.order_id
JOIN products p 
    ON ot.product_id = p.product_id
JOIN product_category_name_translation pc 
    ON p.product_category_name = pc.product_category_name
WHERE o.order_status = 'delivered'
  AND pc.product_category_name_english IN (
      'telephony',
      'computers_accessories',
      'electronics',
      'small_appliances_home_oven_and_coffee',
      'audio',
      'tablets_printing_image'
  )
GROUP BY price_range
ORDER BY products_sold DESC;

#How many months of data are included in the magist database?


SELECT 
    COUNT(DISTINCT DATE_FORMAT(order_purchase_timestamp, '%Y-%m')) AS months_of_data
FROM orders;

#How many sellers are there?  3095

SELECT count(distinct seller_id) as total_sellers

FROM
    sellers;
    
    
    

#How many Tech sellers are there?
SELECT count(distinct seller_id) 

FROM
    sellers;

SELECT 
    COUNT(DISTINCT s.seller_id) AS tech_sellers
FROM
    sellers s
        JOIN
    order_items ot ON ot.seller_id = s.seller_id
       JOIN
    products p ON ot.product_id = p.product_id
        JOIN
    product_category_name_translation pc ON pc.product_category_name = p.product_category_name
WHERE
    p.product_category_name IN ('eletronicos' , 'informatica_acessorios',
        'livros_tecnicos',
        'pc_gamer',
        'relogios_presentes',
        'audio',
        'pcs');
        
        
        
     #  What percentage of overall sellers are Tech sellers? 
     
     
        SELECT 
    COUNT(DISTINCT s.seller_id) AS total_sellers,
    COUNT(DISTINCT CASE 
                       WHEN p.product_category_name IN (
                           'eletronicos',
                           'informatica_acessorios',
                           'livros_tecnicos',
                           'pc_gamer',
                           'relogios_presentes',
                           'audio',
                           'pcs'
                       ) THEN s.seller_id 
                   END) AS tech_sellers,
    ROUND(
        100.0 * COUNT(DISTINCT CASE 
                                  WHEN p.product_category_name IN (
                                      'eletronicos',
                                      'informatica_acessorios',
                                      'livros_tecnicos',
                                      'pc_gamer',
                                      'relogios_presentes',
                                      'audio',
                                      'pcs'
                                  ) THEN s.seller_id 
                              END) / COUNT(DISTINCT s.seller_id), 
        2
    ) AS tech_seller_percentage
FROM sellers s
LEFT JOIN order_items ot 
    ON ot.seller_id = s.seller_id
LEFT JOIN products p 
    ON ot.product_id = p.product_id
LEFT JOIN product_category_name_translation pc 
    ON pc.product_category_name = p.product_category_name;


#What is the total amount earned by all sellers

SELECT 
    round(SUM(ot.price), 2) as total_amount
FROM
    order_items ot
        JOIN
    orders o ON o.order_id = ot.order_id
WHERE
    o.order_status = 'delivered';
    
    select * from order_payments;
    
    SELECT 
    SUM(oi.price) AS total
FROM
    order_items oi
        LEFT JOIN
    orders o USING (order_id)
WHERE
    o.order_status NOT IN ('unavailable' , 'canceled');
    
    select distinct order_status from orders;
    
   # What is the total amount earned by all Tech sellers?
   
   
    SELECT 
    round(SUM(ot.price)) as total_amount_tech_sellers
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
    
    
    
    
   # Can you work out the average monthly income of all sellers
   
   SELECT 
    ROUND(SUM(ot.price) / COUNT(DISTINCT DATE_FORMAT(o.order_purchase_timestamp, '%Y-%m')), 2) AS avg_monthly_income
FROM orders o
JOIN order_items ot 
    ON o.order_id = ot.order_id
WHERE o.order_status = 'delivered'

#Can you work out the average monthly income of Tech sellers?


