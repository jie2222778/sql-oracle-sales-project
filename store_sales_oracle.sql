-- 店铺表
CREATE TABLE stores (
    store_id NUMBER PRIMARY KEY,
    store_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(50),
    open_date DATE
);

-- 销售订单表，外键关联店铺
CREATE TABLE sales_orders (
    order_id NUMBER PRIMARY KEY,
    store_id NUMBER NOT NULL,
    sale_amount NUMBER(10,2),
    sale_time DATE,
    customer_name VARCHAR2(80),
    CONSTRAINT fk_store FOREIGN KEY(store_id) REFERENCES stores(store_id)
);

-- 插入模拟测试数据
INSERT INTO stores VALUES(1,'城东门店','成都',TO_DATE('2024-01-10','yyyy-mm-dd'));
INSERT INTO stores VALUES(2,'城西门店','成都',TO_DATE('2024-02-05','yyyy-mm-dd'));

INSERT INTO sales_orders VALUES(101,1,235.50,TO_DATE('2026-07-01','yyyy-mm-dd'),'张三');
INSERT INTO sales_orders VALUES(102,1,560.00,TO_DATE('2026-07-02','yyyy-mm-dd'),'李四');
INSERT INTO sales_orders VALUES(103,2,180.20,TO_DATE('2026-07-02','yyyy-mm-dd'),'王五');

COMMIT;

-- 查询1：各店铺总销售额，多表JOIN + GROUP BY
SELECT s.store_name, SUM(o.sale_amount) AS total_sales
FROM stores s
LEFT JOIN sales_orders o ON s.store_id = o.store_id
GROUP BY s.store_name;

-- 查询2：筛选大额订单
SELECT * FROM sales_orders WHERE sale_amount > 200;

-- 查询3：统计每个城市门店数量
SELECT city, COUNT(store_id) AS store_count
FROM stores
