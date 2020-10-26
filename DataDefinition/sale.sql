CREATE TABLE SALE(
    TRANSACTION_ID VARCHAR(20) NOT NULL,
    INVESTMENT_ID VARCHAR(20) NOT NULL,
    AMOUNT INT NOT NULL,
    ACCOUNT_NUM VARCHAR(1) NOT NULL,
    PRIMARY KEY(TRANSACTION_ID),
    FOREIGN KEY(INVESTMENT_ID)
        REFERENCES INVESTMENT(INVESTMENT_ID)
        ON UPDATE RESTRICT ON DELETE RESTRICT,
    FOREIGN KEY(ACCOUNT_NUM)
        REFERENCES ACCOUNT(ACCOUNT_NUM)
        ON UPDATE RESTRICT ON DELETE RESTRICT
);