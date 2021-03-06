USE jw_group05_db;

CREATE TABLE TRANSACTION(
    TRANSACTION_ID	VARCHAR(20)	PRIMARY KEY,
    ACCOUNT_NUM		  VARCHAR(1)	NOT NULL,
    ACCOUNT_BALANCE	UNSIGNED INT,
    TRANSACT_DATE		DATE    		NOT NULL,
    TRANSACT_TYPE		VARCHAR(3),
    FOREIGN KEY (ACCOUNT_NUM) REFERENCES ACCOUNT(ACCOUNT_NUM)
);
