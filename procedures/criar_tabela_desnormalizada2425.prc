--
-- Procedure "CRIAR_TABELA_DESNORMALIZADA2425"
--
CREATE OR REPLACE EDITIONABLE PROCEDURE "DEMO"."CRIAR_TABELA_DESNORMALIZADA2425" IS
BEGIN
  EXECUTE IMMEDIATE q'[
    CREATE TABLE desnormalizada2425 AS
    SELECT
        o.ORDER_ID,
        o.ORDER_DATE,
        o.ORDER_MODE,
        o.ORDER_STATUS,
        o.ORDER_TOTAL,
        o.DELIVERY_TYPE,
        o.COST_OF_DELIVERY,
        o.WAIT_TILL_ALL_AVAILABLE,

        -- Customer Info
        c.CUSTOMER_ID,
        c.CUST_FIRST_NAME,
        c.CUST_LAST_NAME,
        c.CUST_EMAIL,
        c.CUSTOMER_CLASS,
        c.CREDIT_LIMIT,
        c.CUSTOMER_SINCE,
        c.DOB,

        -- Preferred Address
        a.HOUSE_NO_OR_NAME,
        a.STREET_NAME,
        a.TOWN,
        a.COUNTY,
        a.COUNTRY,
        a.POST_CODE,
        a.ZIP_CODE,

        -- Preferred Card
        cd.CARD_TYPE,
        cd.CARD_NUMBER,
        cd.EXPIRY_DATE,

        -- Order Items
        oi.LINE_ITEM_ID,
        oi.PRODUCT_ID,
        oi.UNIT_PRICE,
        oi.QUANTITY,
        oi.DISPATCH_DATE,
        oi.RETURN_DATE,
        oi.GIFT_WRAP,
        oi.CONDITION,
        oi.ESTIMATED_DELIVERY,

        -- Product
        pi.PRODUCT_NAME AS PRODUCT_NAME_EN,
        pd.TRANSLATED_NAME,
        pd.TRANSLATED_DESCRIPTION,
        pi.CATEGORY_ID,
        pi.LIST_PRICE,
        pi.MIN_PRICE,
        pi.PRODUCT_STATUS,

        -- Inventory 
        w.WAREHOUSE_NAME,
        inv.QUANTITY_ON_HAND

    FROM "PORTO01"."ORDERS"@"CLOUD$LINK" o
    JOIN "PORTO01"."CUSTOMERS"@"CLOUD$LINK" c
        ON o.CUSTOMER_ID = c.CUSTOMER_ID
    LEFT JOIN "PORTO01"."ADDRESSES"@"CLOUD$LINK" a
        ON o.DELIVERY_ADDRESS_ID = a.ADDRESS_ID
    LEFT JOIN "PORTO01"."CARD_DETAILS"@"CLOUD$LINK" cd
        ON o.CARD_ID = cd.CARD_ID
    JOIN "PORTO01"."ORDER_ITEMS"@"CLOUD$LINK" oi
        ON o.ORDER_ID = oi.ORDER_ID
    LEFT JOIN "PORTO01"."PRODUCT_INFORMATION"@"CLOUD$LINK" pi
        ON oi.PRODUCT_ID = pi.PRODUCT_ID
    LEFT JOIN "PORTO01"."PRODUCT_DESCRIPTIONS"@"CLOUD$LINK" pd
        ON pd.PRODUCT_ID = oi.PRODUCT_ID
        AND pd.LANGUAGE_ID = 'PT'
    LEFT JOIN "PORTO01"."INVENTORIES"@"CLOUD$LINK" inv
        ON oi.PRODUCT_ID = inv.PRODUCT_ID
        AND o.WAREHOUSE_ID = inv.WAREHOUSE_ID
    LEFT JOIN "PORTO01"."WAREHOUSES"@"CLOUD$LINK" w
        ON o.WAREHOUSE_ID = w.WAREHOUSE_ID
    WHERE o.ORDER_DATE >= DATE '2024-01-01'
      AND o.ORDER_DATE < DATE '2025-01-01'
  ]';
END;
/