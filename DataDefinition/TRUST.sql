USE jw_group05_db;

CREATE TABLE IF NOT EXISTS TRUST (
    ACCOUNT_NUM VARCHAR(10) PRIMARY KEY,
    TAX_UPON_WITHDRAWL DECIMAL(3,2)
);
