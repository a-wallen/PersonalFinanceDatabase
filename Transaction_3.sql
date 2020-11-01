/* TRANSACTION_3
	3.	Deposit $100,000 in the Individual Account
    FUTURE: TRIGGER FOR TRANSACTIONS. ALSO, is DATE BEFORE OR AFTER the TRANSACTION
*/
SET SQL_SAFE_UPDATES = 0;

START TRANSACTION;
SET @deposit = 100000;
SET @balance = (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 6789);

INSERT INTO TRANSACTION VALUES(1, 6789, @balance + @deposit, '2020-10-30', 'DEP');
INSERT INTO DEPOSIT VALUES(1, @deposit, 6789);

UPDATE ACCOUNT
SET BALANCE = BALANCE + @deposit
WHERE ACCOUNT_NUM = 6789;

INSERT INTO ACCT_HISTORY VALUES(1, 6789, '2020-10-30', @balance + @deposit);
COMMIT;
