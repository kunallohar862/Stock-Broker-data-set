# Stock Broker Database Management System (SQL Project)

## 📌 Project Overview
This project demonstrates the **relational database design of a stock brokerage system** using SQL.  
It models how a broker manages **client information, demat accounts, bank details, stock master data, holdings, and buy/sell transactions** in a structured and normalized manner.

The project focuses on:
- Financial data integrity
- Real-world brokerage workflows
- Relational database design best practices
- Analytical readiness for portfolio and transaction analysis

This project is ideal for **SQL practice, data modeling, backend system understanding, and analytics use cases in finance**.

---

## 🎯 Business Objective
The objective of this project is to simulate a **brokerage firm's core database**, enabling:
- Tracking of client accounts and KYC information  
- Monitoring of stock holdings and portfolio value  
- Recording buy/sell transactions  
- Linking market prices with holdings for valuation  
- Supporting analytical queries for reporting and insights  

---

## 🏦 Real-World Use Case
A stock broker needs to:
- Maintain **user KYC & contact details**
- Manage **demat and bank accounts**
- Track **client-wise stock holdings**
- Record **each trade (BUY / SELL)**
- Compute **invested value, current value, and P&L**

This database schema reflects these exact operational requirements.

---

## 🗂️ Database Schema Overview
The system consists of **six core tables**, each representing a key business entity.

### 1️⃣ `user_details`
Stores **client personal and KYC information**.

**Key Fields:**
- `user_id` (Primary Key)
- `name`
- `email_id`
- `phone_no`
- `pan_no`
- `ckyc_no`

➡️ Acts as the **master table** for all user-related mappings.

---

### 2️⃣ `dmat_details`
Maintains **demat account information** of users.

**Key Fields:**
- `BOID` (Beneficial Owner ID)
- `user_id` (Foreign Key)
- `depository` (NSDL / CDSL)

➡️ Each user can have **one demat account**.

---

### 3️⃣ `bank_details`
Stores **linked bank account details** for settlements.

**Key Fields:**
- `bank_id`
- `user_id` (Foreign Key)
- `bank_name`
- `acc_no`
- `ifsc_code`
- `micr_code`
- `account_type`

➡️ Used for **fund transfers and settlements**.

---

### 4️⃣ `stock_table`
Acts as the **stock master table**.

**Key Fields:**
- `ticker_id` (Primary Key)
- `stock_name`
- `previous_close`
- `current_price`

➡️ Represents **market price reference data**.

---

### 5️⃣ `holding_table`
Tracks **current portfolio holdings** of users.

**Key Fields:**
- `ticker_id` (Foreign Key)
- `qty`
- `avg_price`
- `invested`
- `LTP`
- `BOID` (Foreign Key)

➡️ Enables:
- Portfolio valuation  
- Unrealized profit/loss calculation  

---

### 6️⃣ `transaction_table`
Stores **all buy and sell transactions**.

**Key Fields:**
- `transaction_id`
- `trade_date`
- `user_id`
- `ticker_id`
- `qty`
- `price`
- `trans_type` (BUY / SELL)
- `trade_type` (Delivery / Intraday)

➡️ Forms the **transactional backbone** of the system.

---

## 🔗 Entity Relationships
- One **User** → One **Demat Account**
- One **User** → One or More **Bank Accounts**
- One **User** → Multiple **Transactions**
- One **Stock** → Multiple **Holdings**
- Holdings are linked via **BOID** and **Ticker ID**

The schema ensures:
- **Referential integrity**
- **Minimal redundancy**
- **Scalability for analytics**

---

## 📊 Analytical Capabilities
This database supports queries such as:
- Portfolio value per client
- Client-wise invested vs current value
- Stock-wise holding concentration
- Transaction history analysis
- Buy/Sell volume analysis
- Unrealized P&L calculation

---

## 🛠️ Tech Stack
- **Database:** MySQL / PostgreSQL (ANSI SQL compatible)
- **Concepts Used:**
  - Primary & Foreign Keys
  - Normalization
  - Financial data modeling
  - ENUM constraints
  - Decimal precision for monetary values

---

## 🔮 Future Enhancements
- Stored procedures for trade execution  
- Triggers for automatic holding updates  
- P&L calculation views  
- Indexing for performance optimization  
- Integration with Power BI / Tableau  
- Risk metrics and exposure analysis  

---

## 👤 Author
**Kunal Lohar**  
B.Tech (AI & ML)  
Interest Areas: Finance, Data Analytics, Databases, Market Systems  

---

## ⭐ Conclusion
This project provides a **practical and realistic SQL-based implementation** of a stock brokerage database.  
It bridges **business logic and technical database design**, making it valuable for:
- Data Analysts  
- Business Analysts  
- Backend Developers  
- Finance & FinTech learners  

---

📌 *If you found this project useful, consider starring ⭐ the repository!*

