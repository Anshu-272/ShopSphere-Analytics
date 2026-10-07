🛒 ShopSphere — E-Commerce Sales & Profitability Analytics

An end-to-end Data Analytics project analyzing e-commerce sales, profitability, customer behavior, product performance, shipping operations, and returns using Excel, SQL, Python, and Power BI.

📌 Project Overview

ShopSphere is an e-commerce analytics project designed to answer real-world business questions such as:

Which products and categories generate the most revenue?

Which products are the most profitable?

Which categories have the highest profit margins?

How effective are delivery operations?

Which states experience more delivery delays?

What are the major reasons for product returns?

Which customers generate the most revenue?

How does customer purchase frequency affect revenue?

How do discounts affect profitability?

The project follows a complete analytics workflow:

Raw Data → Data Cleaning → SQL Analysis → Python EDA → Power BI Dashboard → Business Insights

🗂️ Dataset

The project uses six interconnected datasets covering 2024–2025:

Dataset

Records

Customers

20,000

Products

496

Orders

100,000

Order Items

172,097

Shipping

95,783

Returns

4,946

The datasets represent an India-based e-commerce business with customers, products, orders, shipping information, and returns.

🧹 Data Cleaning

Data cleaning was performed before analysis to improve data quality and consistency.

Key cleaning steps included:

Removed duplicate customer records

Resolved duplicate Customer IDs

Removed duplicate order-item records

Handled missing discount values

Standardized categorical values

Converted date columns to proper datetime format

Filled missing shipping status based on delivery timing

Checked missing values and duplicate records

Validated relationships between the six datasets

🛠️ Tools & Technologies

Excel — Initial data inspection and cleaning

MySQL / SQL — Data querying and business analysis

Python

Pandas

NumPy

Matplotlib

Seaborn

Power BI — Interactive dashboard and visualization

GitHub — Project version control and documentation

📊 Power BI Dashboard

The Power BI dashboard contains four analytical pages:

1. Executive Overview

Total Revenue

Total Profit

Total Orders

Total Customers

Average Order Value

Profit Margin

Monthly Revenue Trend

Revenue by Category

Revenue by State



2. Product & Category Analysis

Top 10 Products by Revenue

Top 10 Products by Profit

Profit Margin by Category

Profit by Discount Range



3. Operations & Returns Analysis

On-Time vs Late Deliveries

Average Delivery Days

Late Delivery Rate by Shipping Method

Late Delivery Rate by State

Refund Amount by Return Reason

Top 10 Returned Products



4. Customer Analytics

New vs Returning Customers

Customer Revenue by Segment

Top 10 Customers by Revenue

Customer Purchase Frequency vs Revenue



📈 Key Business Results

Overall Performance

Net Revenue: ₹673.45M

Total Profit: ₹172.27M

Total Orders: 100K

Customers: 20K

Average Order Value: ₹6.73K

Profit Margin: 25.58%

Product & Category Insights

Electronics generated the highest revenue and profit.

Home & Kitchen achieved the highest category profit margin at approximately 28%.

Wireless Mouse Max was the top product by profit.

Higher discount ranges were associated with substantially lower profit.

Delivery Insights

81.89% of deliveries were on time.

18.11% of deliveries were late.

Average delivery time was approximately 3.79 days.

Punjab recorded the highest late-delivery rate among the analyzed states.

Same Day shipping had the fastest average delivery time but still showed a relatively high late-delivery rate, indicating potential SLA/operational issues.

Returns Insights

The largest return reasons were:

Size/Fit Issue

Product Not as Expected

Damaged

Poor Quality

These four reasons accounted for roughly 66% of returns.

Late deliveries showed only a small difference in return rate compared with on-time deliveries, suggesting that delivery delays were not the primary driver of returns in this dataset.

Customer Insights

Returning customers generated the vast majority of revenue during the analysis period.

Rahul Patel was the highest-revenue customer at approximately ₹402.6K.

Customer purchase frequency showed a positive relationship with revenue, although revenue varied considerably among customers with similar order counts.

🔎 SQL Analysis

SQL was used to perform business-focused analysis including:

Revenue and profit analysis

Product performance

Category performance

Customer analysis

State-level performance

Shipping performance

Delivery delays

Return analysis

Return reasons

Customer segmentation

SQL queries are available in:

shopsphere_analysis.sql

🐍 Python EDA

Python was used for exploratory data analysis and deeper investigation.

The notebook includes:

Data loading and validation

Dataset merging

Revenue calculation

Profit calculation

Profit margin analysis

Monthly trends

Category analysis

Product analysis

State analysis

Discount analysis

Delivery analysis

Return analysis

Customer analysis

RFM-based customer segmentation

Notebook:

Python_EDA.ipynb

📁 Repository Structure

ShopSphere-Analytics/
│
├── README.md
├── Python_EDA.ipynb
├── shopsphere_analysis.sql
│
├── customers_clean.csv
├── products_clean.csv
├── orders_clean.csv
├── order_items_clean.csv
├── shipping_clean.csv
├── returns_clean.csv
│
├── dashboard_overview.png
├── product_category_analysis.png
├── operations_returns_analysis.png
└── customer_analytics.png

💡 Business Recommendations

Based on the analysis:

Focus on high-profit products such as Wireless Mouse Max and other strong-margin products.

Review high-discount products because larger discounts are associated with significantly lower profit.

Improve delivery operations in states with higher late-delivery rates.

Investigate product quality and sizing issues because they are major contributors to returns.

Strengthen customer retention strategies because returning customers contribute most of the revenue.

Monitor high-value customers and develop targeted offers to improve retention and lifetime value.

Improve product descriptions and expectations to reduce "Product Not as Expected" returns.

🎯 Project Objective

The primary objective of ShopSphere is to demonstrate an end-to-end Data Analytics workflow:

Data Cleaning → SQL → Python EDA → Power BI → Business Insights

The project focuses not only on creating visualizations but also on converting data into actionable business recommendations.

👨‍💻 Author

Abhishek Panchal

B.Tech — Artificial Intelligence & Data Science

GitHub: Anshu-272
