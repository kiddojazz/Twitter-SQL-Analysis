-- drop table twitter;

CREATE TABLE TWITTER(
User_name varchar(30),
Time TimeStamp,
Tweet varchar(300),
Location varchar(30),
Verified varchar(10),
Tweet_Source varchar(30),
Followers INT,
Retweet_Count INT,
Tweet_ID varchar(50),
Sentiment INT,
Insight varchar(20)
);

select * from twitter;

-- Step 1: LOVEDAMINI Sentiment Score
SELECT insight, count(insight) as insight_value
from twitter
group by 1;

-- Step 2: Top 20 Fans by Tweet Count
SELECT user_name, count(user_name) as Top_Users
from twitter
group by 1
order by 2 desc
limit 20;

-- Step 3: Tweet by Location
SELECT location, count(location) as Areas
from twitter
group by 1
order by 2 desc
limit 20;

-- Users by Top followers
/* As we can see Burna boy came first having the highest number of followers*/
SELECT user_name, sum(followers) as follower_count
from twitter
group by 1
order by 2 desc
limit 30;

-- Number of device used
SELECT tweet_source, count(tweet_source) as Device_source
from twitter
group by 1
order by 2 desc
--limit 3; -- This gets you the Top 3 device.

-- Tweet Count by Day
/* Firstly, you need to convert the TimeStamp to Date only*/
--SELECT time::TIMESTAMP::DATE as calendar, count(user_name) /* Used to convert the timestamp to date*/
select date(time) as calendar, count(user_name) as user_name
from twitter
group by 1
ORDER by 1;

select * from twitter;

-- New Column for the Insight Clause
select sentiment,
	case
		when sentiment = 2 then 'Pos'
		when sentiment = 1 then 'Neu'
		else 'Neg'
end as Insight_overview
from twitter;



---------
-- Using Subquery in SQL

select insight_overview, count(insight_overview)
from (select sentiment,
	case
		when sentiment = 2 then 'Pos'
		when sentiment = 1 then 'Neu'
		else 'Neg'
end as Insight_overview
from twitter) as twitter_df
group by 1
;

-- Using CTE (Common Table Expression)
with cte as (
	select sentiment,
	case
		when sentiment = 2 then 'Pos'
		when sentiment = 1 then 'Neu'
		else 'Neg'
end as Insight_overview
from twitter
)
select insight_overview, count(insight_overview)
from cte
group by all;
