/*
Write, test, and execute the following transactions in your group database.  Submit screen shots of your successful results.

1.	Create an Individual Account

2.	Create an IRA account

3.	Deposit $100,000 in the Individual Account

4.	Purchase 100 shares of MSFT stock on 1/1/20 at $200 per share 
	(and reduce account balance by $20,000)
    
5.	Deposit a 1% dividend in MSFT stock on 4/1/20 at $220 per share.  
	This is a separate investment
    
6.	Sell 40 shares of MSFT stock on 7/1/20 at $240 per share.  
	There should be a remaining investment of 60 shares.  
	Add proceeds (cash) to account balance.
    
7.	Transfer $10000 from your Individual Account to your IRA on 8/1/20

8.	Purchase 50 shares of AMZN stock in your IRA on 9/1/20


*/
/* TRANSACTION_1
	1.	Create an Individual Account
		A. CREATE BROKERAGE
		B. CREATE ACCOUNT
        C. EXTEND ACCOUNT TO INDIVIDUAL 
        CONSIDERATIONS: ACCOUNT TYPE(THE 5 types as a number instead 1-5 instead? Same for Transaction?
 */
START TRANSACTION;
INSERT INTO BROKERAGE VALUES(12345, 'FIDELITY', '1518 6TH AVE SEATTLE WA 98101', 0.05, 'B/D', 'N');
INSERT INTO ACCOUNT VALUES(12345, 6789, 0.00, 'JOHN DOE', 'IND');
INSERT INTO INDIVIDUAL VALUES(6789, 'N', 0.10);
COMMIT;





