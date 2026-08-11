## 项目简介
模拟线下门店销售业务，完成Oracle数据表设计，主键、外键约束；结合Python实现CSV批量导入、多表关联统计查询，输出销售分析报表。

## 技术栈
- Oracle SQL
- Python 3
- oracledb
- Pandas

- ## 文件说明
1. `store_sales_oracle.sql`：建表语句、测试插入数据、业务查询SQL
2. `oracle_data_tool.py`：Python连接Oracle，数据导入、统计导出脚本
3. `sample_sales.csv`：模拟订单测试CSV数据源
4. `requirements.txt`：Python依赖清单

## 核心功能
1. Oracle表结构设计，主键、外键完整性约束
2. 多表JOIN、GROUP BY分组聚合销售统计
3. CSV批量数据入库
4. 查询结果导出JSON分析报表

## 简历描述参考
> SQL‑Oracle销售数据管理项目
- 使用Oracle SQL完成业务表设计，设置主键与外键约束，编写多表联查、分组统计SQL
- Python结合oracledb+pandas实现CSV批量导入数据库，完成业务统计，导出分析报表
