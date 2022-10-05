PartB

1.Write a CTE 'Histogram' that counts the number of loans for each risk score. Write a simple query to display the results of the CTE in descending order of the count.

Query:
	With Histogram (Risk_score,Count_loan) as (Select risk_score,count(Loan_title)as Count_loan from Loan group by risk_score order by Count_loan desc) Select * from Histogram ;


2.Spot the risk score(s) with the minimum number of loans. Call this CTE as RiskScoresWithMinLoans.

Query:
	With RiskScoresWithMinLoans (Risk_score,Count_of_loan) as (Select Risk_score, Count(Risk_Score) as Count_of_Loan from Loan 
group by risk_score having count(risk_score)=(Select min(count(risk_score)) from loan group by risk_score)) Select Risk_score from Loan where Risk_Score in (Select Risk_Score from RiskScoresWithMinLoans);


3.Using your Histogram and RiskScoresWithMinLoans CTE, write a SQL query to find description of loans which have a risk score spotted in (ii).

Query:
	
With Histogram (Risk_score,Count_loan) as(Select risk_score,count(Loan_title) from Loan group by risk_score),RiskScoresWithMinLoans (Risk_score,Count_of_loan) as
(Select Risk_score, Count(Risk_Score) as Count_of_Loan from Loan 
group by risk_score having count(risk_score)=(Select min(count(risk_score)) from loan group by risk_score))
Select * from loan where Risk_Score in (Select Risk_Score from RiskScoresWithMinLoans);