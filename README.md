<<<<<<< HEAD
🚀 SQL RFM Analysis Refactor

💡 项目初衷

将原有的 Python 数据分析脚本重构为 SQL 存储过程逻辑，旨在提升大数据集下的处理性能，并利用 SQL 窗口函数实现更精确的客户分层。

🛠️ 关键技术

SQL Window Functions: 使用 NTILE() 替代了传统的均值比较法，解决了数据偏斜问题。

CTE (Common Table Expressions): 采用 WITH 语法使多层加工逻辑清晰易读。

Case When Logic Matrix: 构建了 5 维客户价值映射体系。

📊 分类标准

重要价值客户: 三项指标均处于前 20%-40%。

重要 VIP 用户: 消费金额巨大，但活跃度或频次尚有提升空间。

=======
SQL的join是纵向拼图，子查询是纵向剥洋葱。
约束：数据库的保安
多表查询：数据的“拼图”
事务：数据的后悔药
窗口函数就是带着“探测器”在表里走路
>>>>>>> 0435b6469e11ea0af3d5b4304db787020e54b3db
