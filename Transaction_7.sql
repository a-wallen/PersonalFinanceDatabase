/* TRANSACTION_7
Transfer $10000 from your Individual Account to your IRA on 8/1/20*/
SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0;


START TRANSACTION;
SET @balance = (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 6789);
SET @balance2 = (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 321);
SET @transfer_amt = 10000;
SET @transfer_date = '2020-08-01';

#WITHDRAWAL
INSERT INTO TRANSACTION VALUES(5, 6789, (@balance - @transfer_amt), @transfer_date, 'WIT'); 
INSERT INTO WITHDRAWAL VALUES(5, @transfer_amt, 6789); 

UPDATE ACCOUNT
SET BALANCE = BALANCE - @transfer_amt
WHERE ACCOUNT_NUM = 6789;
INSERT INTO ACCT_HISTORY VALUES(5, 6789, @transfer_date, (@balance - @transfer_amt));

#DEPOSIT
INSERT INTO TRANSACTION VALUES(6, 321, (@balance2 + @transfer_amt), @transfer_date, 'DEP');
INSERT INTO DEPOSIT VALUES(6, @transfer_amt, 321); 

UPDATE ACCOUNT
SET BALANCE = BALANCE + @transfer_amt
WHERE ACCOUNT_NUM = 321;
INSERT INTO ACCT_HISTORY VALUES(6, 321, @transfer_date, (@balance2 + @transfer_amt));

COMMIT;
#ROLLBACK; #MATCH WITH SET AUTOCOMMIT = 0;