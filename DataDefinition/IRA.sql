USE jw_group05_db;

CREATE TABLE IRA (
    ACCOUNT_NUM VARCHAR(10) PRIMARY KEY,
    DEPOSIT_CAP INTEGER UNSIGNED,
    TAX_UPON_WITHDRAWL DECIMAL(3,2)
);
