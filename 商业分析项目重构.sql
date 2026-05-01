/* ================================================================
项目名称：基于 SQL 窗口函数的 RFM 客户价值模型重构
开发日期：2026-05
开发者：[你的名字/GitHub ID]
工具：MySQL / DBeaver

项目描述：
本项目将原有的 Python RFM 处理逻辑重构为纯 SQL 实现。
核心亮点是使用 NTILE() 窗口函数进行等频分箱打分，确保了分值分布的严谨性，
并通过 CTE 结构和逻辑映射矩阵实现了高效的客户分类。
================================================================
*/

-- 1. 数据清洗与指标计算 (计算原始 R, F, M 值)
-- 此处假设你已经从订单表转化出了 rfm_metrics 表

-- 2. 核心建模与分类逻辑
WITH rfm_scoring AS (
    /* 使用 NTILE(5) 将用户按比例均匀划分为 5 个等级
    R_score: 日期越近（天数越小）分越高，故按 Recency 降序排
    F_score/M_score: 数值越大分越高，按升序排
    */
    SELECT 
        CustomerID,
        NTILE(5) OVER (ORDER BY Recency DESC) AS R_score,
        NTILE(5) OVER (ORDER BY Frequency ASC) AS F_score,
        NTILE(5) OVER (ORDER BY Monetary ASC) AS M_score
    FROM rfm_metrics
)

-- 3. 最终结果产出：应用业务逻辑矩阵
SELECT 
    *,
    CASE 
        WHEN R_score >= 4 AND F_score >= 4 AND M_score >= 4 THEN '重要价值客户'
        WHEN M_score >= 4 THEN '重要 VIP 用户'
        WHEN R_score <= 2 AND (F_score >= 3 OR M_score >= 3) THEN '重点挽留客户'
        WHEN R_score <= 2 AND F_score <= 2 AND M_score <= 2 THEN '潜在流失客户'
        ELSE '一般保持客户'
    END AS Customer_Tag
FROM rfm_scoring;

-- 4. 验证脚本：查看各分层客户占比
/*
SELECT Customer_Tag, COUNT(*) as user_count
FROM (上面那段代码的结果)
GROUP BY Customer_Tag;
*/