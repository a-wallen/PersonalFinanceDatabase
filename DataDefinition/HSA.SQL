USE jw_group05_db;

CREATE TABLE IF NOT EXISTS HSA (
    ACCOUNT_NUM         VARCHAR(10)  PRIMARY KEY,
    TAX_UPON_WITHDRAW	DECIMAL(3,2),
);
