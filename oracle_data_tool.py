import oracledb
import pandas as pd
import json

# 数据库配置，使用者本地自行填写，不要上传真实密码到仓库
DB_CONFIG = {
    "user": "your_username",
    "password": "your_password",
    "dsn": "localhost/XEPDB1"
}

def get_db_connection():
    """获取Oracle数据库连接"""
    try:
        conn = oracledb.connect(**DB_CONFIG)
        return conn
    except Exception as e:
        print(f"数据库连接失败: {e}")
        return None

def get_store_sales_statistics():
    """多表关联查询店铺销售统计"""
    conn = get_db_connection()
    if not conn:
        return None
    sql = """
        SELECT s.store_name, SUM(o.sale_amount) total_sales
        FROM stores s
        LEFT JOIN sales_orders o ON s.store_id = o.store_id
        GROUP BY s.store_name
    """
    df = pd.read_sql(sql, conn)
    conn.close()
    print(df)
    df.to_json("sales_report.json", orient="records", force_ascii=False)
    return df

def import_csv_to_db(file_path: str):
    """将CSV测试数据批量导入Oracle订单表"""
    df = pd.read_csv(file_path)
    conn = get_db_connection()
    cursor = conn.cursor()
    for _, row in df.iterrows():
        cursor.execute("""
            INSERT INTO sales_orders(order_id,store_id,sale_amount,sale_time,customer_name)
            VALUES(:1,:2,:3,TO_DATE(:4,'yyyy-mm-dd'),:5)
        """, (row.order_id, row.store_id, row.sale_amount, row.sale_time, row.customer_name))
    conn.commit()
    cursor.close()
    conn.close()
    print("CSV数据导入完成")

if __name__ == "__main__":
    get_store_sales_statistics()
