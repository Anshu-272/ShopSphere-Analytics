# 🛒 ShopSphere — E-Commerce Sales & Profitability Analytics

An end-to-end **Data Analytics project** analyzing e-commerce sales, profitability, customer behavior, product performance, shipping operations, and returns using **Excel, SQL, Python, and Power BI**.

---

## 📌 Project Overview

**ShopSphere** is an e-commerce analytics project designed to answer real-world business questions such as:

- Which products and categories generate the most revenue?
- Which products are the most profitable?
- Which categories have the highest profit margins?
- How effective are the company's delivery operations?
- Which states experience more delivery delays?
- What are the major reasons for product returns?
- Which customers generate the most revenue?
- How does customer behavior affect revenue?
- How do discounts affect profitability?

The project follows a complete analytics workflow:

**Raw Data → Data Cleaning → SQL Analysis → Python EDA → Power BI Dashboard → Business Insights**

---

## 🎯 Business Objectives

The main objectives of the analysis were to:

1. Analyze overall sales and profitability.
2. Identify high-performing products and categories.
3. Evaluate profit margins and discount impact.
4. Analyze customer purchasing behavior.
5. Measure delivery performance.
6. Identify return patterns and major return reasons.
7. Identify regional performance differences.
8. Generate actionable business recommendations.

---

## 🗂️ Dataset

The project uses a synthetic e-commerce dataset representing an Indian online marketplace for **2024–2025**.

| Table | Records |
|---|---:|
| Customers | 20,000 |
| Products | 496 |
| Orders | 100,000 |
| Order Items | 172,097 |
| Shipping | 95,783 |
| Returns | 4,946 |

### Data Model

The project contains six connected tables:

- `customers_clean`
- `products_clean`
- `orders_clean`
- `order_items_clean`
- `shipping_clean`
- `returns_clean`

Main relationships:

```text
Customers
    │
    └── Orders
           │
           ├── Order Items ─── Products
           │
           ├── Shipping
           │
           └── Returns
```

---

## 🛠️ Tools & Technologies

- **Excel** — Initial data inspection and cleaning
- **SQL / MySQL** — Data analysis and business queries
- **Python**
  - Pandas
  - NumPy
  - Matplotlib
  - Seaborn
- **Power BI** — Interactive dashboard and visualization
- **GitHub** — Project documentation and version control

---

## 🧹 Data Cleaning

The raw datasets were cleaned before analysis.

Major cleaning activities included:

- Removed duplicate customer records.
- Resolved duplicate `Customer_ID` values.
- Standardized categorical values.
- Handled missing customer attributes.
- Converted date columns to proper datetime format.
- Removed duplicate order-item records.
- Replaced missing discount values with `0%`.
- Filled missing delivery-status values using delivery timing.
- Validated relationships between orders, products, customers, shipping and returns.

After cleaning, the main order-item analysis dataset contained:

**172,097 records and 22 analytical columns.**

---

## 📊 Key KPIs

| KPI | Result |
|---|---:|
| Net Revenue | **₹673.45M** |
| Total Profit | **₹172.27M** |
| Total Orders | **100,000** |
| Customers | **20,000** |
| Average Order Value | **₹6.73K** |
| Profit Margin | **25.58%** |
| Average Delivery Time | **3.79 days** |
| On-Time Delivery Rate | **81.89%** |
| Late Delivery Rate | **18.11%** |

---

# 📈 Power BI Dashboard

The final Power BI dashboard contains four analytical pages.

## 1️⃣ Executive Overview

Provides a high-level view of overall business performance.

### Includes:

- Revenue
- Profit
- Orders
- Customers
- Average Order Value
- Profit Margin
- Monthly Revenue Trend
- Revenue by Category
- Revenue by State

---

## 2️⃣ Product & Category Analysis

Analyzes product-level and category-level profitability.

### Includes:

- Top 10 Products by Revenue
- Top 10 Products by Profit
- Profit Margin by Category
- Profit by Discount Range

---

## 3️⃣ Operations & Returns Analysis

Evaluates logistics performance and product returns.

### Includes:

- Average Delivery Days
- On-Time vs Late Deliveries
- Late Delivery Rate by Shipping Method
- Late Delivery Rate by State
- Refund Amount by Return Reason
- Top 10 Returned Products

---

## 4️⃣ Customer Analytics

Analyzes customer purchasing behavior and revenue contribution.

### Includes:

- New vs Returning Customers
- Customer Revenue by Segment
- Top 10 Customers by Revenue
- Customer Frequency vs Revenue

---

# 🔍 Key Business Insights

### 1. Electronics is the largest revenue contributor

Electronics generated approximately **₹303.8M in revenue** and **₹76.7M in profit**, making it the strongest category by both revenue and absolute profit.

**Recommendation:** Maintain strong inventory availability for high-performing electronics while closely monitoring supplier costs and margins.

---

### 2. Home & Kitchen has the highest profit margin

Home & Kitchen achieved approximately **28% profit margin**, the highest among the major categories.

**Recommendation:** Explore bundles, cross-selling and targeted promotions to increase sales in this high-margin category.

---

### 3. Higher discounts are associated with lower profitability

Profit decreased sharply as discount levels increased.

| Discount Range | Profit |
|---|---:|
| 0–10% | ₹134.63M |
| 11–20% | ₹36.41M |
| 21–30% | ₹1.23M |
| 30%+ | Negligible |

**Recommendation:** Use targeted discounts instead of broad high-percentage discounts.

> Note: This shows an association in the dataset and does not prove that discounts alone caused the decline in profit.

---

### 4. Delivery performance has room for improvement

Approximately **18.11% of deliveries were late**, meaning nearly 1 in 5 deliveries missed the expected delivery target.

**Recommendation:** Focus operational improvements on high-delay regions and shipping processes.

---

### 5. Product-related issues drive most returns

The four largest return reasons were:

- Size/Fit Issue — 17.77%
- Product Not as Expected — 17.08%
- Damaged — 15.99%
- Poor Quality — 15.45%

Together they represent approximately **66% of returns**.

**Recommendation:** Improve product descriptions, sizing information, quality checks, packaging and product imagery.

---

### 6. Late delivery has only a weak relationship with returns

Return rate:

- Late delivery: **5.27%**
- On-time delivery: **5.14%**

The difference is only **0.13 percentage points**.

This suggests that late delivery alone is not a major return driver in this dataset.

---

### 7. Returning customers dominate revenue

Customers with more than one recorded order generated approximately **99.32% of revenue** during the analysis period.

**Recommendation:** Invest in customer retention, loyalty programs, personalized recommendations and cross-selling.

> In this analysis, "New Customer" means a customer with only one recorded order during the analysis period.

---

### 8. Revenue declined slightly year-over-year

Revenue showed approximately **-1.78% YoY growth**.

This indicates a need to investigate which products, categories, regions or customer segments contributed to the slowdown.

---

# 💡 Business Recommendations

Based on the analysis, ShopSphere should:

### 📦 Improve Operations
- Investigate high-delay states.
- Monitor shipping-method performance.
- Improve fulfillment planning.

### 💰 Protect Profitability
- Reduce excessive discounting.
- Monitor low-margin products.
- Promote high-margin categories.

### 🛍️ Improve Product Experience
- Improve product descriptions.
- Provide better sizing information.
- Strengthen packaging and quality control.

### 👥 Improve Customer Retention
- Build loyalty programs.
- Personalize product recommendations.
- Encourage repeat purchases.
- Identify and target at-risk customers.

### 📈 Investigate Revenue Decline
- Compare year-over-year category performance.
- Analyze regional revenue changes.
- Identify declining products.
- Study customer-segment performance.

---

# 🧮 Important Calculations

### Net Revenue

```text
Net Revenue =
Quantity × Unit Selling Price × (1 − Discount %)
```

### Profit

```text
Profit =
Net Revenue − Product Cost
```

### Profit Margin

```text
Profit Margin =
Profit / Net Revenue × 100
```

### Average Order Value

```text
AOV =
Net Revenue / Total Orders
```

---

# 📁 Suggested Project Structure

```text
ShopSphere-Analytics/
│
├── data/
│   ├── customers_clean.csv
│   ├── products_clean.csv
│   ├── orders_clean.csv
│   ├── order_items_clean.csv
│   ├── shipping_clean.csv
│   └── returns_clean.csv
│
├── sql/
│   └── shopsphere_analysis.sql
│
├── python/
│   └── shopsphere_eda.ipynb
│
├── powerbi/
│   └── ShopSphere_Analytics_v1.pbix
│
├── screenshots/
│   ├── executive_overview.png
│   ├── product_analysis.png
│   ├── operations_returns.png
│   └── customer_analytics.png
│
└── README.md
```

---

# 🚀 Project Workflow

```text
Raw E-Commerce Data
        ↓
Data Cleaning
        ↓
Excel Validation
        ↓
SQL Business Analysis
        ↓
Python EDA
        ↓
Power BI Data Model
        ↓
DAX Measures
        ↓
Interactive Dashboard
        ↓
Business Insights
        ↓
Recommendations
```

---

# 📌 Conclusion

ShopSphere demonstrates an end-to-end **Data Analytics workflow** using multiple industry-relevant tools.

The project combines:

**Data Cleaning + SQL + Python + Data Visualization + Power BI + Business Analysis**

rather than focusing only on visualization.

The analysis identified major revenue drivers, profitable categories, discount-profit relationships, delivery performance issues, return drivers and customer behavior patterns, providing actionable recommendations for improving profitability, operations and customer retention.

---

## 👨‍💻 Author

**Abhishek Panchal**

B.Tech — Artificial Intelligence & Data Science

**Skills demonstrated:**

`Excel` `SQL` `Python` `Pandas` `NumPy` `Matplotlib` `Seaborn` `Power BI` `DAX` `Data Cleaning` `Data Visualization` `Business Analytics`

---

⭐ If you find this project useful, feel free to explore the analysis and dashboard.
