#SELECT * FROM magist123.products;


        

#What categories of tech products does Magist have?

SELECT
    COUNT(DISTINCT product_id) AS number_of_products,
    product_category_name
FROM
    products
WHERE
    product_category_name IN ('eletronicos' , 'informatica_acessorios',
        'livros_tecnicos',
        'pc_gamer',
        'relogios_presentes',
        'audio',
        'pcs')
GROUP BY product_category_name
ORDER BY number_of_products DESC;

#How many products of these tech categories have been sold (within the time window of the database snapshot)? 



SELECT 
    COUNT(DISTINCT (ot.product_id)) AS tech_products_sold
FROM
    order_items ot
        LEFT JOIN
    products p USING (product_id)
        LEFT JOIN
    product_category_name_translation pt USING (product_category_name)
        LEFT JOIN
    orders o USING (order_id)
WHERE
    p.product_category_name IN ('eletronicos' , 'informatica_acessorios',
        'livros_tecnicos',
        'pc_gamer',
        'relogios_presentes',
        'audio',
        'pcs')
        AND o.order_status = 'delivered';

SELECT 
    COUNT(DISTINCT ot.product_id) AS total_products_sold
FROM
    orders o
        JOIN
    order_items ot ON o.order_id = ot.order_id
        JOIN
    products p ON ot.product_id = p.product_id
        JOIN
    product_category_name_translation pc ON pc.product_category_name = p.product_category_name
WHERE
    o.order_status = 'delivered';



#What percentage does that represent from the overall number of products sold?

SELECT 
    COUNT(DISTINCT CASE
            WHEN
                pc.product_category_name_english IN ('electronics' , 'computers_accessories',
                    'technical_books',
                    'pc_gamer',
                    'watches_gifts',
                    'audio',
                    'pcs')
            THEN
                ot.product_id
        END) AS tech_products_sold,
    COUNT(DISTINCT ot.product_id) AS total_products_sold,
    ROUND(100.0 * COUNT(DISTINCT CASE
                    WHEN
                        pc.product_category_name_english IN ('electronics' , 'computers_accessories',
                            'technical_books',
                            'pc_gamer',
                            'watches_gifts',
                            'audio',
                            'pcs')
                    THEN
                        ot.product_id
                END) / COUNT(DISTINCT ot.product_id),
            2) AS tech_percentage
FROM
    orders o
        LEFT JOIN
    order_items ot ON o.order_id = ot.order_id
        LEFT JOIN
    products p ON ot.product_id = p.product_id
        LEFT JOIN
    product_category_name_translation pc ON p.product_category_name = pc.product_category_name
WHERE
    o.order_status = 'delivered';



#What’s the average price of the products being sold?

   SELECT 
    round(AVG(ot.price)) as average_price_sold
FROM
    orders o
        JOIN
    order_items ot ON o.order_id = ot.order_id
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
        'pcs')
        AND o.order_status = 'delivered';
        
        
        
        SELECT 
    ROUND(AVG(ot.price), 2)
FROM
    order_items ot
        JOIN
    orders o USING (order_id)
WHERE
    o.order_status = 'delivered';
        
#Are expensive tech products popular?;
        
        
   
