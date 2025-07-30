--
-- View "PRODUCT_PRICES"
--
CREATE OR REPLACE FORCE EDITIONABLE VIEW "DEMO"."PRODUCT_PRICES" ("CATEGORY_ID", "#_OF_PRODUCTS", "LOW_PRICE", "HIGH_PRICE") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT category_id
,      COUNT(*)        as "#_OF_PRODUCTS"
,      MIN(list_price) as low_price
,      MAX(list_price) as high_price
FROM   DEMO.product_information
GROUP BY category_id
/