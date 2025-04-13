create database Marketing_campaign;

use Marketing_campaign;

create table Campaigns(CampaignID int primary key,	CampaignName varchar(40),	Channel	varchar(40),
StartDate Date,	EndDate	date, Budget int);

insert into Campaigns(CampaignID, CampaignName, Channel, StartDate, EndDate, Budget)
values(1,	'Summer Sale',	'Social Media', '2023-06-01', '2023-06-30', 50000),
(2,	'Diwali Bonanza',	'Email',	'2023-10-15',	'2023-11-15',	70000),
(3,	'New Year Deals',	'TV Ads',	'2023-12-20',	'2024-01-05',	120000),
(4,	'Flash Sale',	'Social Media',	'2023-09-10',	'2023-09-20',	30000),
(5,	'Festive Offers',	'Google Ads',	'2023-08-01',	'2023-08-31',	60000),
(6,	'End of Season',	'Influencer',	'2023-11-01',	'2023-11-30',	90000);

create table Leads(LeadID int primary key, CampaignID int,	`Date` date, LeadsGenerated int, Revenue int
,foreign key(CampaignID) references Campaigns(CampaignID));

insert into Leads(LeadID,CampaignID,`Date`,LeadsGenerated,Revenue)
values(101,	1,	'2023-06-05',	120,	25000),
(102,	1,	'2023-06-15',	150,	32000),
(103,	2,	'2023-10-20',	180,	40000),
(104,	2,	'2023-11-05',	210,	46000),
(105,	3,	'2023-12-25',	300,	70000),
(106,	3,	'2024-01-03',	250,	62000),
(107,	4,	'2023-09-12',	100,	22000),
(108,	5,	'2023-08-10',	170,	35000),
(109,	6,	'2023-11-10', 200,	48000),
(110,	6,	'2023-11-25',	230,	52000);

select * from Campaigns;
select * from Leads;

-- Easy Questions
-- Write a query to categorize campaigns as "High Budget" if the budget is more than 80,000, "Medium Budget" if between 50,000 and 80,000, and "Low Budget" otherwise.

select *,
case when Budget > 80000 then 'High Budget'
when Budget between 80000 and 50000 then 'Medium Budget'
Else 'Low Budget'
end as category
from Campaigns;

-- Create a query to display each campaign’s name along with a new column that says "Long Duration" if the campaign lasted more than 30 days, otherwise "Short Duration".

select CampaignName,
case when Datediff(EndDate,StartDate)>30 then 'Long Duration'
else 'Short Duration'
end as Duration_Period
from Campaigns;

-- Write a query to classify the leads generated as "High Leads" if more than 200 leads were generated, "Moderate Leads" if between 150 and 200, and "Low Leads" otherwise.

select *,
case when LeadsGenerated > 200 then "High Leads"
when LeadsGenerated between 150 and 200 then "Moderate Leads"
else "Low Leads"
end as Leads_Category
from Leads;

-- Display each campaign name along with a column that labels the channel as "Digital" for "Social Media", "Google Ads", or "Influencer", and "Traditional" otherwise.
select CampaignName,
case when `Channel` = "Social Media" OR `Channel` = "Google Ads" OR `Channel` = "Influencer" then "Digital"
else "Traditional"
end as `channel_type`
from Campaigns;

-- Medium Questions
-- Create a query that displays each campaign name, its budget, and a new column "ROI Category" that categorizes campaigns as "High ROI" if the total revenue generated from leads is at least twice the budget, "Moderate ROI" if revenue is between budget and twice the budget, and "Low ROI" otherwise.
SELECT C.CAMPAIGNNAME,C.BUDGET,
CASE WHEN SUM(REVENUE) >= 2*BUDGET THEN "High ROI"
WHEN SUM(REVENUE) > BUDGET AND SUM(REVENUE) < 2* BUDGET THEN "Moderate ROI"
ELSE "Low ROI"
END AS "ROI Category"
FROM LEADS l
JOIN CAMPAIGNS c ON c.CAMPAIGNID=l.CAMPAIGNID
group by C.CAMPAIGNNAME,C.BUDGET;

-- Write a query to classify leads based on revenue as "Premium" if revenue is above 50,000, "Standard" if between 30,000 and 50,000, and "Basic" otherwise.
SELECT *,
CASE WHEN REVENUE>50000 THEN 'PREMIUM'
WHEN REVENUE BETWEEN 30000 AND 50000 THEN 'STANDARD'
ELSE 'BASIC'
END AS Class
from leads;
-- Write a query to pivot the total number of leads generated for each campaign across different channels. The result should have campaign names as rows and separate columns for each channel (Social Media, Email, TV Ads, Google Ads, Influencer) showing the total leads generated.
SELECT 
  c.CAMPAIGNNAME AS CampaignName,
  SUM(CASE WHEN c.Channel = 'Social Media' THEN l.LeadsGenerated ELSE 0 END) AS `Social Media`,
  SUM(CASE WHEN c.Channel = 'Email' THEN l.LeadsGenerated ELSE 0 END) AS Email,
  SUM(CASE WHEN c.Channel = 'TV Ads' THEN l.LeadsGenerated ELSE 0 END) AS `TV Ads`,
  SUM(CASE WHEN c.Channel = 'Google Ads' THEN l.LeadsGenerated ELSE 0 END) AS `Google Ads`,
  SUM(CASE WHEN c.Channel = 'Influencer' THEN l.LeadsGenerated ELSE 0 END) AS Influencer
FROM LEADS l
JOIN CAMPAIGNS c ON c.CAMPAIGNID = l.CAMPAIGNID
GROUP BY c.CAMPAIGNNAME;

-- Create a query that pivots the revenue generated from leads for each campaign. The output should have campaign names as rows and separate columns for each month (June, August, September, October, November, December, January), showing the total revenue generated in that month.
select CampaignName,
sum(case when month(l.date)=6 then l.revenue else 0 end) as June,
sum(case when month(l.date)=8 then l.revenue else 0 end) as August,
sum(case when month(l.date)=9 then l.revenue else 0 end) as September,
sum(case when month(l.date)=10 then l.revenue else 0 end) as October,
sum(case when month(l.date)=11 then l.revenue else 0 end) as November,
sum(case when month(l.date)=12 then l.revenue else 0 end) as December,
sum(case when month(l.date)=1 then l.revenue else 0 end) as January
FROM LEADS l
JOIN CAMPAIGNS c ON c.CAMPAIGNID = l.CAMPAIGNID
GROUP BY c.CAMPAIGNNAME;


-- Write a query to display the number of leads generated per campaign, categorized by budget range. The output should have three columns: "Low Budget", "Medium Budget", and "High Budget", with the total leads generated under each category.

select c.CampaignName,
  SUM(CASE WHEN c.Budget < 50000 THEN l.LeadsGenerated ELSE 0 END) AS `Low Budget`,
  SUM(CASE WHEN c.Budget BETWEEN 50000 AND 80000 THEN l.LeadsGenerated ELSE 0 END) AS `Medium Budget`,
  SUM(CASE WHEN c.Budget > 80000 THEN l.LeadsGenerated ELSE 0 END) AS `High Budget`
FROM LEADS l
JOIN CAMPAIGNS c ON c.CAMPAIGNID = l.CAMPAIGNID
GROUP BY c.CAMPAIGNNAME;

-- Hard Question
-- Write a query that displays each campaign’s name, the total number of leads generated, and a new column "Performance" that categorizes the campaign as "Excellent" if the average revenue per lead is above 300, "Good" if between 200 and 300, and "Needs Improvement" otherwise.

with total_number_of_leads_generated as (
SELECT 
  c.CAMPAIGNNAME,
  SUM(l.LeadsGenerated) AS TotalLeads,
  round(sum(l.Revenue)/sum(l.LeadsGenerated),0) AS Avg_Revenue_per_lead
FROM LEADS l
JOIN CAMPAIGNS c ON c.CAMPAIGNID = l.CAMPAIGNID
GROUP BY c.CAMPAIGNNAME )

select CampaignName,TotalLeads,
  CASE 
    WHEN Avg_Revenue_per_lead > 300 THEN 'Excellent'
    WHEN Avg_Revenue_per_lead BETWEEN 200 AND 300 THEN 'Good'
    ELSE 'Needs Improvement'
  END AS Performance
  from total_number_of_leads_generated;




