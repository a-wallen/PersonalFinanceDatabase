USE jw_group05_db;

CREATE TABLE ACCOUNT (
    ACCOUNT_NUM  VARCHAR(10) PRIMARY KEY,
    PAYOR_ID     VARCHAR(10),
    INVESTMENT_ID  VARCHAR(5),
    TRANSACTION_ID VARCHAR(5),
    BALANCE DECIMAL(10,2),
    TRUSTED_CONTACT VARCHAR(30),
    ACCOUNT_TYPE VARCHAR(3),
    FOREIGN KEY(PAYOR_ID) REFERENCES BROKERAGE(PAYOR_ID)
);
