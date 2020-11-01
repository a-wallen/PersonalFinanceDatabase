SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0;
/* TRANSAACTION_4
Purchase 100 shares of MSFT stock on 1/1/20 at $200 per share (and reduce account balance by $20,000)*/

START TRANSACTION;
SET @balance = (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 6789);
SET @units = 100;
SET @purch_date = '2020-01-01';
SET @price = 200;

INSERT INTO TRANSACTION VALUES(2, 6789, @balance - (@units * @price), @purch_date, 'PUR');
INSERT INTO INVESTMENT VALUES(1, 2, 6789);
INSERT INTO PURCHASE VALUES(2, 1, 6789);

INSERT INTO INVEST_HISTORY VALUES(1, @purch_date, @price, DIVIDEND, 'MSFT', @units);
INSERT INTO SECTOR VALUES('T1', 'MSFT', 'Y');
INSERT INTO INVEST_SECTORS VALUES(1, 'T1');

UPDATE ACCOUNT
SET BALANCE = BALANCE - (@units * @price)
WHERE ACCOUNT_NUM = 6789;

INSERT INTO ACCT_HISTORY VALUES(2, 6789, @purch_date, @balance - (@units * @price));

COMMIT;
