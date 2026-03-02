create database if not exists banking_loan_system;

show databases;

use banking_loan_system;

create table loan_system(
id int primary key,
address_state varchar(50),
application_type varchar(50),
emp_length varchar(50),
emp_title varchar(100),
grade varchar(50),
home_ownership varchar(50),
issue_date date,
last_credit_pull_date date,
last_payment_date date,
loan_status varchar(50),
next_payment_date date,
member_id int,
purpose varchar(50),
sub_grade varchar(50),
term varchar(50),
verification_status varchar(50),
annual_income float,
dti float,
installment float,
int_rate float,
loan_amount int,
total_acc smallint,
total_payment int);


select * from loan_system;


-- KPI BUILD --

select count(id) as total_applications from loan_system;                    -- Total Loan Applications

select count(id) as total_applications from loan_system where month(issue_date)=12;  -- MTD Loan Applications

select count(id) as total_applications from loan_system where month(issue_date)=11;      -- PMTD Loan Applications

select sum(loan_amount) as total_funded_amount from loan_system;           -- Total Funded Amount

select sum(loan_amount) as total_funded_amount from loan_system          -- MTD Total Funded Amount
where month(issue_date)=12;

select sum(loan_amount) as total_funded_amount from loan_system         -- PMTD Total Funded Amount
where month(issue_date)=11;

select sum(total_payment) as total_amount_collected from loan_system;   --  Total Amount Received

select sum(total_payment) as total_amount_collected from loan_system     -- MTD Total Amount Received
where month(issue_date)=12;

select sum(total_payment) as total_amount_collected from loan_system     -- PMTD Total Amount Received
where month(issue_date)= 11;

select avg(int_rate)*100 as avg_int_rate from loan_system;       -- Average Interest Rate

select avg(int_rate)*100 as MTD_avg_int_rate from loan_system    -- MTD Average Interest
where month(issue_date)=12;

select avg(int_rate)*100 as PMTD_int_rate from loan_system       -- PMTD Average Interest
where month(issue_date)=11;


select avg(dti)*100 as avg_dti from loan_system;    -- Avg DTI

select avg(dti)*100 as MTD_avg_dti from loan_system    -- MTD Avg DTI
where month(issue_date)=12;

select avg(dti)*100 as PMTD_avg_dti from loan_system     -- PMTD Avg DTI
where month(issue_date)=11;

select                                                    -- Good Loan Percentage
      (count(case when loan_status="Fully paid" or loan_status="Current" then id end) * 100.0)/
      count(id) as good_loan_percentage 
	from loan_system;

select count(id) as good_loan_application from loan_system          -- Good Loan Applications
where loan_status="Fully Paid" or loan_status="Current";

select sum(loan_amount) as good_loan_funded_amount from loan_system     --  Good Loan Funded Amount
where loan_status="Fully Paid" or loan_status="Current";

select sum(total_payment) as good_loan_amount_received from loan_system      -- Good Loan Amount Received
where loan_status="Fully Paid" or loan_status="Current"; 

select                                                    -- Bad Loan Percentage
      (count(case when loan_status="Charged Off" then id end) * 100.0)/
      count(id) as bad_loan_percentage 
	from loan_system;


select count(id) as bad_loan_applications from loan_system       -- Bad Loan Applications
where loan_status="Charged Off";

select sum(loan_amount) as bad_loan_funded_amount from loan_system     -- Bad Loan Funded Amount
where loan_status="Charged Off";

select sum(total_payment) as bad_loan_amount_received from loan_system       -- Bad Loan Amount Received
where loan_status="Charged Off";

-- LOAN STATUS

	select
        loan_status,
        count(id) as loan_count,
        sum(total_payment) as total_amount_received,
        sum(loan_amount) as total_funded_amount,
        avg(int_rate * 100) as interest_rate,
        avg(dti * 100) as DTI
    from
        loan_system
    GROUP BY
        loan_status;
        
        
select 
	loan_status, 
	sum(total_payment) as MTD_total_amount_received, 
	sum(loan_amount) as MTD_total_funded_amount 
from loan_system
where month(issue_date) = 12 
group by loan_status;


--  B.	BANK LOAN REPORT | OVERVIEW

-- MONTHLY

select
	month(issue_date) as month_number, 
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from loan_system
group by month(issue_date)
order by month(issue_date);


-- STATES

select 
	address_state as state, 
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from loan_system
group by address_state
order by address_state;


-- TERM

select
	term,  
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from loan_system
group by term
order by term;


-- EMPLOYEE LENGTH

select 
	emp_length as employee_length, 
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from loan_system
group by emp_length
order by emp_length;


-- PURPOSE

select 
	purpose, 
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from loan_system
group by purpose
order by purpose;


--   HOME OWNERSHIP

select 
	home_ownership, 
	count(id) as total_loan_applications,
	sum(loan_amount) as total_funded_amount,
	sum(total_payment) as total_amount_received
from loan_system
group by home_ownership
order by home_ownership;







