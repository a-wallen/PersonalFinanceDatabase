

/* TRANSACTION_5
Deposit a 1% dividend in MSFT stock on 4/1/20 at $220 per share.  This is a separate investment*/
#Should DIVIDEND be a subtyoe of deposit? Also, how should we represent it as a record in the invest-history table?
SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0;

START TRANSACTION;
SET @balance = (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 6789);
SET @units = (SELECT UNITS FROM INVEST_HISTORY WHERE TICKER = 'MSFT');
SET @div_date = '2020-04-01';
SET @price = 220;
SET @dividend = 0.01;

INSERT INTO TRANSACTION VALUES(3, 6789, @balance + (@price * @price * @dividend), @div_date, 'DIV'); 
INSERT INTO INVESTMENT VALUES(2, 3, 6789); 

INSERT INTO DIVIDEND VALUES(3, 2, 6789, (@price * @price * @dividend));
INSERT INTO DEPOSIT VALUES(3, (@price * @price * @dividend), 6789);
INSERT INTO INVEST_HISTORY VALUES(2, @div_date, @price, @dividend, 'MSFT', @units);

UPDATE ACCOUNT
SET BALANCE = BALANCE + (@price * @price * @dividend)
WHERE ACCOUNT_NUM = 6789;
INSERT INTO ACCT_HISTORY VALUES(3, 6789, @div_date, @balance + (@price * @price * @dividend));
COMMIT;

#ROLLBACK; MATCH WITH SET AUTOCOMMIT = 0;