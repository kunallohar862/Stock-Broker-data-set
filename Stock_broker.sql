create database Stock_broker;
use Stock_broker;

-- 1️⃣ Stock Table
CREATE TABLE stock_table (
    ticker_id VARCHAR(10) PRIMARY KEY,
    stock_name VARCHAR(100) NOT NULL,
    previous_close DECIMAL(10,2),
    current_price DECIMAL(10,2)
);

-- 2️⃣ User Details Table
CREATE TABLE user_details (
    user_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email_id VARCHAR(100) UNIQUE NOT NULL,
    phone_no VARCHAR(15),
    pan_no VARCHAR(15) UNIQUE,
    ckyc_no VARCHAR(20) UNIQUE
);

-- 3️⃣ DMAT Details Table
CREATE TABLE dmat_details (
    BOID INT PRIMARY KEY,
    user_id INT UNIQUE,  -- 1-to-1 relationship with user_details
    depository ENUM('NSDL', 'CDSL'),
    FOREIGN KEY (user_id) REFERENCES user_details(user_id)
        ON DELETE CASCADE
);

-- 4️⃣ Holding Table
CREATE TABLE holding_table (
    BOID varchar(20),
    ticker_id VARCHAR(10),
    qty INT NOT NULL,                   -- Total quantity currently held
    avg_price DECIMAL(10,2) NOT NULL,  -- Weighted average buy price
    invested DECIMAL(12,2) AS (qty * avg_price) STORED,  -- Computed total investment
    LTP DECIMAL(10,2),                 -- Last traded price (current market price)
    PRIMARY KEY (BOID, ticker_id),
    FOREIGN KEY (BOID) REFERENCES dmat_details(BOID) ON DELETE CASCADE,
    FOREIGN KEY (ticker_id) REFERENCES stock_table(ticker_id) ON DELETE CASCADE
);


-- 5️⃣ Transaction Table
CREATE TABLE transaction_table (
    transaction_id BIGINT PRIMARY KEY,
    trade_date DATETIME,
    user_id INT,
    ticker_id VARCHAR(10),
    qty INT NOT NULL,
    price DECIMAL(10,2),
    trans_type ENUM('BUY', 'SELL'),
    trade_type ENUM('Intra_day', 'Delivery'),
    FOREIGN KEY (user_id) REFERENCES user_details(user_id)
        ON DELETE CASCADE,
    FOREIGN KEY (ticker_id) REFERENCES stock_table(ticker_id)
        ON DELETE CASCADE
);


-- 6️⃣ Bank Details Table
CREATE TABLE bank_details (
    bank_id INT PRIMARY KEY,
    user_id INT,
    bank_name VARCHAR(100),
    acc_no BIGINT,
    ifsc_code VARCHAR(15),
    micr_code BIGINT,
    account_type ENUM('PRIMARY', 'SECONDARY'),
    FOREIGN KEY (user_id) REFERENCES user_details(user_id)
        ON DELETE CASCADE
);


INSERT INTO stock_table (ticker_id, stock_name, previous_close, current_price) VALUES
('TCS', 'Tata Consultancy Services', 3830.00, 3855.50),
('INFY', 'Infosys Ltd', 1620.00, 1642.25),
('RELI', 'Reliance Industries', 2860.00, 2899.00),
('HDFB', 'HDFC Bank', 1530.00, 1542.00),
('SBIN', 'State Bank of India', 765.00, 772.10),
('ICIC', 'ICICI Bank', 1030.00, 1044.50),
('ITC', 'ITC Ltd', 450.00, 454.25),
('WIPR', 'Wipro Ltd', 490.00, 492.50),
('ADAN', 'Adani Enterprises', 2820.00, 2838.75),
('LT', 'Larsen & Toubro', 3560.00, 3585.25);

insert into stock_table values
('BHARTI', 'Bharti Airtel Ltd', 1230.25, 1242.75),
('ONGC', 'Oil & Natural Gas Corp', 208.50, 210.20);

INSERT INTO user_details (user_id, name, email_id, phone_no, pan_no, ckyc_no) VALUES
(1001, 'Rohan Mehta', 'rohan.mehta@gmail.com', '9876543210', 'ABCDE1234F', 'CKYC0001'),
(1002, 'Priya Sharma', 'priya.sharma@yahoo.com', '9898123456', 'BCDEA4321H', 'CKYC0002'),
(1003, 'Kunal Patel', 'kunal.patel@outlook.com', '9922334455', 'CDEAB2345J', 'CKYC0003'),
(1004, 'Neha Verma', 'neha.verma@gmail.com', '9812345678', 'DEABC3456K', 'CKYC0004'),
(1005, 'Aman Singh', 'aman.singh@gmail.com', '9933445566', 'EABCD4567L', 'CKYC0005'),
(1006, 'Ishita Das', 'ishita.das@hotmail.com', '9988776655', 'FABCD5678M', 'CKYC0006'),
(1007, 'Ravi Nair', 'ravi.nair@gmail.com', '9765432180', 'GABCD6789N', 'CKYC0007'),
(1008, 'Sneha Iyer', 'sneha.iyer@yahoo.com', '9822233344', 'HABCD7890P', 'CKYC0008'),
(1009, 'Arjun Reddy', 'arjun.reddy@gmail.com', '9898776655', 'IABCD8901Q', 'CKYC0009'),
(1010, 'Megha Kapoor', 'megha.kapoor@gmail.com', '9811198765', 'JABCD9012R', 'CKYC0010'),
(1011, 'Rahul Jain', 'rahul.jain@gmail.com', '9876501234', 'KABCD0123S', 'CKYC0011'),
(1012, 'Pooja Sinha', 'pooja.sinha@yahoo.com', '9845123456', 'LABCD1234T', 'CKYC0012'),
(1013, 'Ankit Gupta', 'ankit.gupta@gmail.com', '9823456789', 'MABCD2345U', 'CKYC0013'),
(1014, 'Tanya Rao', 'tanya.rao@gmail.com', '9911223344', 'NABCD3456V', 'CKYC0014'),
(1015, 'Harsh Bansal', 'harsh.bansal@gmail.com', '9877123456', 'OABCD4567W', 'CKYC0015'),
(1016, 'Aditi Kulkarni', 'aditi.kulkarni@gmail.com', '9833344556', 'PABCD5678X', 'CKYC0016'),
(1017, 'Varun Joshi', 'varun.joshi@outlook.com', '9899554433', 'QABCD6789Y', 'CKYC0017'),
(1018, 'Shruti Menon', 'shruti.menon@gmail.com', '9812349988', 'RABCD7890Z', 'CKYC0018'),
(1019, 'Karan Malhotra', 'karan.malhotra@gmail.com', '9977886655', 'SABCD8901A', 'CKYC0019'),
(1020, 'Ritika Chatterjee', 'ritika.chatterjee@gmail.com', '9811122233', 'TABCD9012B', 'CKYC0020');


INSERT INTO dmat_details (user_id, BOID, depository) VALUES
(1001, '12012345', 'NSDL'),
(1002, '12012346', 'NSDL'),
(1003, '12012347', 'CDSL'),
(1004, '12012348', 'NSDL'),
(1005, '12012349', 'CDSL'),
(1006, '12012350', 'NSDL'),
(1007, '12012351', 'NSDL'),
(1008, '12012352', 'CDSL'),
(1009, '12012353', 'NSDL'),
(1010, '12012354', 'CDSL'),
(1011, '12012355', 'NSDL'),
(1012, '12012356', 'CDSL'),
(1013, '12012357', 'NSDL'),
(1014, '12012358', 'CDSL'),
(1015, '12012359', 'NSDL'),
(1016, '12012360', 'NSDL'),
(1017, '12012361', 'CDSL'),
(1018, '12012362', 'CDSL'),
(1019, '12012363', 'NSDL'),
(1020, '12012364', 'NSDL');


INSERT INTO bank_details (bank_id, user_id, bank_name, acc_no, ifsc_code, micr_code, account_type) VALUES
(2001, 1001, 'HDFC Bank', 12345678901, 'HDFC0001234', 400240002, 'PRIMARY'),
(2002, 1002, 'ICICI Bank', 12345678902, 'ICIC0004321', 400240003, 'PRIMARY'),
(2003, 1002, 'SBI Bank', 12345678903, 'SBIN0000543', 400240004, 'SECONDARY'),
(2004, 1003, 'Axis Bank', 12345678904, 'UTIB0000021', 400240005, 'PRIMARY'),
(2005, 1003, 'Kotak Bank', 12345678905, 'KKBK0000312', 400240006, 'SECONDARY'),
(2006, 1004, 'HDFC Bank', 12345678906, 'HDFC0001201', 400240007, 'PRIMARY'),
(2007, 1005, 'ICICI Bank', 12345678907, 'ICIC0007654', 400240008, 'PRIMARY'),
(2008, 1006, 'SBI Bank', 12345678908, 'SBIN0008765', 400240009, 'PRIMARY'),
(2009, 1007, 'Axis Bank', 12345678909, 'UTIB0000098', 400240010, 'PRIMARY'),
(2010, 1007, 'HDFC Bank', 12345678910, 'HDFC0009876', 400240011, 'SECONDARY'),
(2011, 1008, 'SBI Bank', 12345678911, 'SBIN0001111', 400240012, 'PRIMARY'),
(2012, 1009, 'ICICI Bank', 12345678912, 'ICIC0002222', 400240013, 'PRIMARY'),
(2013, 1010, 'HDFC Bank', 12345678913, 'HDFC0003333', 400240014, 'PRIMARY'),
(2014, 1010, 'Axis Bank', 12345678914, 'UTIB0004444', 400240015, 'SECONDARY'),
(2015, 1011, 'Kotak Bank', 12345678915, 'KKBK0005555', 400240016, 'PRIMARY'),
(2016, 1011, 'ICICI Bank', 12345678916, 'ICIC0006666', 400240017, 'SECONDARY'),
(2017, 1012, 'SBI Bank', 12345678917, 'SBIN0007777', 400240018, 'PRIMARY'),
(2018, 1012, 'Axis Bank', 12345678918, 'UTIB0008888', 400240019, 'SECONDARY'),
(2019, 1013, 'HDFC Bank', 12345678919, 'HDFC0009999', 400240020, 'PRIMARY'),
(2020, 1013, 'ICICI Bank', 12345678920, 'ICIC0000001', 400240021, 'SECONDARY'),
(2021, 1014, 'ICICI Bank', 12345678921, 'ICIC0000001', 400240022, 'PRIMARY'),
(2022, 1014, 'HDFC Bank', 12345678922, 'HDFC0009999', 400240023, 'SECONDARY'),
(2023, 1015, 'SBI Bank', 12345678923, 'SBIN0007777', 400240024, 'PRIMARY'),
(2024, 1015, 'Axis Bank', 12345678924, 'UTIB0008888', 400240025, 'SECONDARY'),
(2025, 1016, 'Axis BanK', 12345678925, 'UTIB0008888', 400240026, 'PRIMARY'),
(2026, 1017, 'Kotak Bank', 12345678926, 'UTIB0008888', 400240027, 'PRIMARY'),
(2027, 1018, 'Kotak Bank', 12345678927, 'UTIB0008888', 400240028, 'PRIMARY'),
(2028, 1019, 'HDFC Bank', 12345678928, 'HDFC0009999', 400240029, 'PRIMARY'),
(2029, 1020, 'HDFC Bank', 12345678929, 'HDFC0009999', 400240030, 'PRIMARY'),
(2030, 1020, 'Kotak Bank', 12345678930, 'UTIB0008888', 400240031, 'SECONDARY');


INSERT INTO transaction_table (transaction_id, trade_date, user_id, ticker_id, qty, price, trans_type, trade_type) VALUES
(3001, '2025-10-10', 1001, 'TCS', 5, 3820.00, 'BUY', 'Delivery'),
(3002, '2025-10-11', 1005, 'TCS', 2, 3850.00, 'SELL', 'Delivery'),
(3003, '2025-10-13', 1001, 'INFY', 10, 1625.00, 'BUY', 'Intra_day'),
(3004, '2025-10-14', 1002, 'RELI', 8, 2855.00, 'BUY', 'Delivery'),
(3005, '2025-10-15', 1008, 'RELI', 8, 2900.00, 'SELL', 'Delivery'),
(3006, '2025-10-12', 1003, 'ITC', 20, 445.00, 'BUY', 'Delivery'),
(3007, '2025-10-14', 1003, 'ITC', 10, 454.00, 'SELL', 'Delivery'),
(3008, '2025-10-10', 1010, 'HDFB', 15, 1520.00, 'BUY', 'Delivery'),
(3009, '2025-10-13', 1005, 'HDFB', 5, 1540.00, 'SELL', 'Delivery'),
(3010, '2025-10-10', 1005, 'RELI', 10, 2860.00, 'BUY', 'Delivery'),
(3011, '2025-10-15', 1005, 'RELI', 10, 2895.00, 'SELL', 'Delivery'),
(3012, '2025-10-09', 1007, 'ICIC', 25, 1020.00, 'BUY', 'Delivery'),
(3013, '2025-10-14', 1007, 'ICIC', 10, 1040.00, 'SELL', 'Delivery'),
(3014, '2025-10-11', 1009, 'WIPR', 30, 485.00, 'BUY', 'Delivery'),
(3015, '2025-10-14', 1009, 'WIPR', 15, 492.00, 'SELL', 'Delivery'),
(3016, '2025-10-12', 1010, 'ADAN', 10, 2800.00, 'BUY', 'Intra_day'),
(3017, '2025-10-13', 1015, 'LT', 5, 3570.00, 'BUY', 'Delivery'),
(3018, '2025-10-14', 1015, 'LT', 2, 3580.00, 'SELL', 'Delivery'),
(3019, '2025-10-11', 1017, 'ITC', 50, 450.00, 'BUY', 'Delivery'),
(3020, '2025-10-14', 1017, 'ITC', 30, 454.00, 'SELL', 'Delivery'),
(3021, '2025-10-13', 1018, 'RELI', 10, 2880.00, 'BUY', 'Intra_day'),
(3022, '2025-10-14', 1020, 'TCS', 12, 1286.00, 'BUY', 'Delivery'),
(3023, '2025-10-20', 1020, 'ITC', 4, 2408.00, 'BUY', 'Intra_day'),
(3024, '2025-10-16', 1020, 'ITC', 16, 3365.00, 'BUY', 'Delivery'),
(3025, '2025-10-14', 1004, 'TCS', 23, 3815.00, 'SELL', 'Delivery'),
(3026, '2025-10-18', 1006, 'TCS', 15, 1835.00, 'BUY', 'Intra_day'),
(3027, '2025-10-14', 1006, 'WIPR', 15, 3890.00, 'BUY', 'Delivery'),
(3028, '2025-10-14', 1011, 'TCS', 4, 3897.00, 'BUY', 'Delivery'),
(3029, '2025-10-28', 1016, 'ADAN', 15, 1268.00, 'BUY', 'Delivery'),
(3030, '2025-10-19', 1006, 'LT', 12, 5683.00, 'SELL', 'Delivery'),
(3031, '2025-10-16', 1011, 'RELI', 8, 3835.00, 'SELL', 'Intra_day'),
(3032, '2025-10-22', 1012, 'ONGC', 8, 3962.00, 'BUY', 'Delivery'),
(3033, '2025-10-14', 1014, 'BHARTI', 3, 2952.00, 'SELL', 'Intra_day'),
(3034, '2025-10-16', 1014, 'RELI', 8, 3835.00, 'BUY', 'Delivery'),
(3035, '2025-10-16', 1006, 'INFY', 15, 1620.50, 'SELL', 'Intra_day'),
(3036, '2025-10-16', 1011, 'TCS', 5, 3950.75, 'BUY', 'Delivery'),
(3037, '2025-10-16', 1012, 'ICIC', 12, 1080.25, 'SELL', 'Intra_day'),
(3038, '2025-10-16', 1013, 'ITC', 20, 465.40, 'BUY', 'Delivery'),
(3039, '2025-10-16', 1016, 'SBIN', 10, 770.60, 'BUY', 'Intra_day'),
(3040, '2025-10-16', 1019, 'BHARTI', 25, 1285.00, 'SELL', 'Delivery'),
(3041, '2025-10-16', 1006, 'ADAN', 6, 3210.30, 'BUY', 'Delivery'),
(3042, '2025-10-16', 1012, 'HDFB', 18, 1585.90, 'SELL', 'Delivery'),
(3043, '2025-10-16', 1013, 'ONGC', 30, 212.50, 'BUY', 'Intra_day'),
(3044, '2025-10-16', 1011, 'LT', 10, 3580.75, 'SELL', 'Delivery'),
(3045, '2025-10-16', 1016, 'WIPR', 22, 530.25, 'BUY', 'Delivery'),
(3046, '2025-10-16', 1019, 'INFY', 14, 1618.90, 'BUY', 'Intra_day'),
(3047, '2025-10-16', 1014, 'TCS', 9, 3978.50, 'SELL', 'Delivery'),
(3048, '2025-10-16', 1006, 'ICIC', 16, 1072.65, 'BUY', 'Delivery'),
(3049, '2025-10-16', 1013, 'ADAN', 7, 3195.40, 'SELL', 'Intra_day'),
(3050, '2025-10-16', 1014, 'RELI', 8, 3835.00, 'BUY', 'Delivery');


INSERT INTO holding_table (user_id, ticker_id, qty, avg_price, LTP) VALUES
(1001, 'TCS', 8, 3760.00, 3845.00),
(1001, 'INFY', 15, 1585.00, 1610.50),
(1001, 'RELI', 6, 2790.00, 2820.50),
(1001, 'ITC', 20, 445.00, 451.75),
(1002, 'HDFB', 10, 1508.00, 1538.25),
(1002, 'ICIC', 12, 1025.00, 1044.10),
(1002, 'WIPR', 25, 486.00, 492.80),
(1003, 'TCS', 5, 3780.00, 3845.00),
(1003, 'SBIN', 30, 720.00, 741.20),
(1003, 'RELI', 8, 2775.00, 2820.50),
(1003, 'LT', 3, 3550.00, 3580.90),
(1003, 'INFY', 10, 1590.00, 1610.50),
(1004, 'ITC', 18, 440.00, 451.75),
(1004, 'WIPR', 12, 488.00, 492.80),
(1005, 'HDFB', 6, 1500.00, 1538.25),
(1005, 'TCS', 4, 3800.00, 3845.00),
(1005, 'ICIC', 15, 1018.00, 1044.10),
(1005, 'LT', 5, 3555.00, 3580.90),
(1005, 'RELI', 7, 2785.00, 2820.50),
(1005, 'SBIN', 20, 735.00, 741.20),
(1006, 'TCS', 3, 3805.00, 3845.00),
(1006, 'INFY', 12, 1592.00, 1610.50),
(1006, 'HDFB', 5, 1512.00, 1538.25),
(1007, 'ITC', 40, 442.00, 451.75),
(1007, 'WIPR', 10, 488.00, 492.80),
(1008, 'SBIN', 25, 728.00, 741.20),
(1008, 'HDFB', 12, 1525.00, 1538.25),
(1009, 'INFY', 8, 1600.00, 1610.50),
(1009, 'WIPR', 14, 486.00, 492.80),
(1009, 'SBIN', 20, 733.00, 741.20),
(1009, 'RELI', 10, 2785.00, 2820.50),
(1009, 'ITC', 20, 442.00, 451.75),
(1010, 'LT', 6, 3565.00, 3580.90),
(1010, 'TCS', 7, 3780.00, 3845.00),
(1011, 'ICIC', 15, 1015.00, 1044.10),
(1011, 'RELI', 8, 2810.00, 2820.50),
(1011, 'WIPR', 10, 490.00, 492.80),
(1011, 'HDFB', 4, 1502.00, 1538.25),
(1012, 'TCS', 6, 3770.00, 3845.00),
(1012, 'INFY', 10, 1595.00, 1610.50),
(1012, 'ITC', 30, 440.00, 451.75),
(1012, 'SBIN', 12, 726.00, 741.20),
(1013, 'HDFB', 15, 1510.00, 1538.25),
(1013, 'TCS', 4, 3775.00, 3845.00),
(1014, 'RELI', 14, 2795.00, 2820.50),
(1014, 'LT', 3, 3555.00, 3580.90),
(1014, 'INFY', 18, 1590.00, 1610.50),
(1014, 'ITC', 25, 440.00, 451.75),
(1014, 'SBIN', 20, 732.00, 741.20),
(1015, 'ICIC', 12, 1030.00, 1044.10),
(1015, 'LT', 5, 3568.00, 3580.90),
(1015, 'WIPR', 20, 488.00, 492.80),
(1015, 'TCS', 8, 3795.00, 3845.00),
(1016, 'HDFB', 10, 1515.00, 1538.25),
(1017, 'LT', 8, 3550.00, 3580.90),
(1017, 'TCS', 4, 3780.00, 3845.00),
(1018, 'HDFB', 7, 1520.00, 1538.25),
(1018, 'ICIC', 10, 1032.00, 1044.10),
(1018, 'INFY', 12, 1598.00, 1610.50),
(1019, 'TCS', 10, 3810.00, 3845.00),
(1010, 'RELI', 6, 2790.00, 2820.50),
(1020, 'ITC', 15, 440.00, 451.75),
(1020, 'HDFB', 5, 1500.00, 1538.25),
(1020, 'LT', 5, 3558.00, 3580.90),
(1020, 'WIPR', 20, 486.00, 492.80),
(1020, 'ICIC', 15, 1020.00, 1044.10),
(1020, 'TCS', 7, 3790.00, 3845.00);

 












