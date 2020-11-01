/* TRANSACTION_6
Sell 40 shares of MSFT stock on 7/1/20 at $240 per share.  There should be a remaining investment of 60 shares. 
 Add proceeds (cash) to account balance.
 */
SET SQL_SAFE_UPDATES = 0;
SET autocommit = 0;

START TRANSACTION;
SET @balance = (SELECT BALANCE FROM ACCOUNT WHERE ACCOUNT_NUM = 6789);
SET @units = (SELECT UNITS FROM INVEST_HISTORY WHERE TICKER = 'MSFT' and INVESTMENT_ID IN ( SELECT MAX(INVESTMENT_ID) 
				FROM INVEST_HISTORY GROUP BY TICKER ));
SET @sale_date = '2020-07-01';
SET @sold_units = 40;
SET @price = 240;

INSERT INTO TRANSACTION VALUES(4, 6789, @balance + (@price * @sold_units), @sale_date, 'SAL'); 
INSERT INTO INVESTMENT VALUES(3, 4, 6789); 
INSERT INTO SALE VALUES(4, 3, (@price * @sold_units), 6789);
INSERT INTO INVEST_HISTORY VALUES(3, @sale_date, @price, 0.00, 'MSFT', (@units - @sold_units));

UPDATE ACCOUNT
SET BALANCE = BALANCE + (@price * @sold_units)
WHERE ACCOUNT_NUM = 6789;
INSERT INTO ACCT_HISTORY VALUES(4, 6789, @sale_date, @balance + (@price * @sold_units));

COMMIT;
#ROLLBACK; #MATCH WITH SET AUTOCOMMIT = 0;