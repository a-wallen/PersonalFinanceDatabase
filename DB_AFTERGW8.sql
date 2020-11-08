USE jw_morrisonanti_db;

CREATE TABLE IF NOT EXISTS BROKERAGE (
                 PAYOR_ID              VARCHAR(10)  NOT NULL,
                     NAME              VARCHAR(20)  NOT NULL,
                  ADDRESS              VARCHAR(30)  NOT NULL,
               COMMISSION             DECIMAL(3,2)  NOT NULL,
           BROKERAGE_TYPE               VARCHAR(3)  NOT NULL,
              INDEPENDENT               VARCHAR(1)  NOT NULL,
                                    PRIMARY KEY (PAYOR_ID)
);

CREATE TABLE IF NOT EXISTS ACCOUNT (
                 PAYOR_ID             VARCHAR (10)  NOT NULL,
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
                  BALANCE            DECIMAL(10,2)  NOT NULL,
          TRUSTED_CONTACT              VARCHAR(30)  NOT NULL,
             ACCOUNT_TYPE               VARCHAR(3)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM),
                                       FOREIGN KEY (PAYOR_ID)
                               REFERENCES BROKERAGE(PAYOR_ID)
);

CREATE TABLE IF NOT EXISTS INDIVIDUAL (
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
              TAXABLE_NOW               VARCHAR(1)  NOT NULL,
               PROFIT_TAX             DECIMAL(3,2)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM, PROFIT_TAX),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS JOINT (
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
  JOINT_OWNER_CREDENTIALS              VARCHAR(20)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS TRUST (
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
      TAX_UPON_WITHDRAWAL             DECIMAL(3,2)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS IRA (
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
              DEPOSIT_CAP         INTEGER UNSIGNED  NOT NULL,
      TAX_UPON_WITHDRAWAL             DECIMAL(3,2)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS 401K (
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
              DEPOSIT_CAP         INTEGER UNSIGNED  NOT NULL,
                     FEES             DECIMAL(3,2)  NOT NULL,
                   INCOME            DECIMAL(10,2)  NOT NULL,
                  SPONSOR              VARCHAR(20)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS HSA (
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
        TAX_UPON_WITHDRAW             DECIMAL(3,2)  NOT NULL,
                                    PRIMARY KEY (ACCOUNT_NUM),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS TRANSACTION (
           TRANSACTION_ID               INT(20) NOT NULL AUTO_INCREMENT,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
          ACCOUNT_BALANCE         INTEGER UNSIGNED  NOT NULL,
            TRANSACT_DATE                     DATE  NOT NULL,
            TRANSACT_TYPE               VARCHAR(3)  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS ACCT_HISTORY (
           TRANSACTION_ID               INT(20)  NOT NULL,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
                     DATE                     DATE  NOT NULL,
                  BALANCE            DECIMAL(10,2)  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID)
);


CREATE TABLE IF NOT EXISTS PURCHASE (
           TRANSACTION_ID              INT(20)  NOT NULL,
            INVESTMENT_ID              VARCHAR(20)  NOT NULL,
              ACCOUNT_NUM              VARCHAR(10)  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID)
);

CREATE TABLE IF NOT EXISTS WITHDRAWAL (
           TRANSACTION_ID              INT(20)  NOT NULL,
          AMOUNT_WITHDRAW         INTEGER UNSIGNED  NOT NULL,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS INVESTMENT (
            INVESTMENT_ID              INT(20)  NOT NULL AUTO_INCREMENT,
           TRANSACTION_ID              INT(20)  NOT NULL,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
                                    PRIMARY KEY (INVESTMENT_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS DIVIDEND (
           TRANSACTION_ID              INT(20)  NOT NULL,
            INVESTMENT_ID              INT(20)  NOT NULL,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
                   AMOUNT         INTEGER UNSIGNED  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID),
                                  FOREIGN KEY (INVESTMENT_ID)
                         REFERENCES INVESTMENT(INVESTMENT_ID),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS SALE (
           TRANSACTION_ID              INT(20)  NOT NULL,
            INVESTMENT_ID              INT(20)  NOT NULL,
                   AMOUNT                      INT  NOT NULL,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID),
                                  FOREIGN KEY (INVESTMENT_ID)
                         REFERENCES INVESTMENT(INVESTMENT_ID),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS DEPOSIT (
           TRANSACTION_ID              INT(20)  NOT NULL,
           AMOUNT_DEPOSIT         INTEGER UNSIGNED  NOT NULL,
              ACCOUNT_NUM               VARCHAR(10)  NOT NULL,
                                    PRIMARY KEY (TRANSACTION_ID),
                                 FOREIGN KEY (TRANSACTION_ID)
                       REFERENCES TRANSACTION(TRANSACTION_ID),
                                    FOREIGN KEY (ACCOUNT_NUM)
                              REFERENCES ACCOUNT(ACCOUNT_NUM)
);

CREATE TABLE IF NOT EXISTS INVEST_HISTORY (
            INVESTMENT_ID              INT(20)  NOT NULL,
              INVEST_DATE                     DATE  NOT NULL,
                    PRICE       MEDIUMINT UNSIGNED  NOT NULL,
                 DIVIDEND            DECIMAL(3, 3)  NOT NULL,
                   TICKER                  CHAR(4)  NOT NULL,
                    UNITS         INTEGER UNSIGNED  NOT NULL,
                                    PRIMARY KEY (INVESTMENT_ID),
                                  FOREIGN KEY (INVESTMENT_ID)
                         REFERENCES INVESTMENT(INVESTMENT_ID)
);

CREATE TABLE IF NOT EXISTS SECTOR (
                SECTOR_ID               VARCHAR(10)  NOT NULL,
              SECTOR_NAME              VARCHAR(30)  NOT NULL,
                  TAXABLE            VARCHAR(1)  NOT NULL,
                                    PRIMARY KEY (SECTOR_ID)
                                      
);

CREATE TABLE IF NOT EXISTS INVEST_SECTORS (
            INVESTMENT_ID               INT(20)  NOT NULL,
                SECTOR_ID               VARCHAR(10)  NOT NULL,
                                    PRIMARY KEY (INVESTMENT_ID, SECTOR_ID),
                                  FOREIGN KEY (INVESTMENT_ID)
                         REFERENCES INVESTMENT(INVESTMENT_ID),
                                      FOREIGN KEY (SECTOR_ID)
                                 REFERENCES SECTOR(SECTOR_ID)
);


