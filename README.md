# Twitter-SQL-Analysis

In this article I will should you how to analyze Tweet data gotten from Twitter API.

## Step 1: Scrape data from Twitter API
This takes a longer process and I will recommend you go through two articles I have on going about that.
- Web Scraping and Sentiment Analysis Using Twint Library [Twint](https://heartbeat.comet.ml/web-scraping-and-sentiment-analysis-using-twint-library-5dac52f5de53).
- Music Sentiment Analysis With the Twitter API and 🤗 Transformers [Tweepy](https://heartbeat.comet.ml/music-sentiment-analysis-with-the-twitter-api-and-transformers-9b1135016bcb).

Any of this two article will help you in getting Twitter data and data cleaning process.

## Step 2: Create a Table and import Data into PostgreSQL data table

### Create SQL Table
The PostgreSQL is used for this project, we will need to create a data in our query.
```
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
```

### Import Dataset into table.
Follow the GIF below on how to go about it.

&&&& Image

## Data Visualization
Now, that all is done we need to get insight about our data. The following visualize and analysis will be done below.

**i: View Entire Table**
```
/* This will display the entire data table*/
select * from twitter;
```
&&& Image

**ii: Get top Fan**

```
-- Step 2: Top 20 Fans by Tweet Count
SELECT user_name, count(user_name) as Top_Users
from twitter
group by 1 -- Aggregate by column 1
order by 2 desc -- Sort by Column 2
limit 20; -- first 20 rows
```
&&& Image
***iii: Top Tweet by Location***

```
-- Step 3: Tweet by Location
SELECT location, count(location) as Areas
from twitter
group by 1
order by 2 desc
limit 20;
```

&&& Image

***iv: Top Influencers by Followers count**

```
-- Users by Top followers
/* As we can see Burna boy came first having the highest number of followers*/
SELECT user_name, sum(followers) as follower_count
from twitter
group by 1
order by 2 desc
limit 20;
```
&&& Image

**v: Top Device Used**

```
-- Number of device used
SELECT tweet_source, count(tweet_source) as Device_source
from twitter
group by 1
order by 2 desc
limit 3; -- This gets you the Top 3 device.
```

&&& Image

**vi: Tweet by Day**

```
-- Tweet Count by Day
/* Firstly, you need to convert the TimeStamp to Date only*/
--SELECT time::TIMESTAMP::DATE as calendar, count(user_name) /* Used to convert the timestamp to date*/
select date(time) as calendar, count(user_name) as user_name
from twitter
group by 1
ORDER by 1;
```

`select * from twitter;`

**vii: Get the Insight**
To to this we have to group/bin the values of `sentiment` score.
- `2 = Postive`.
- `1 = Neutral`.
- `0 = Negative`.

Use the `WHEN CASE` clause in SQL to create a condtion for new column

```
-- New Column for the Insight Clause
select sentiment,
	case
		when sentiment = 2 then 'Pos'
		when sentiment = 1 then 'Neu'
		else 'Neg'
end as Insight_overview
from twitter;
```

Lastly, create a nested subquery to anayze and get visuals 
```
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
```
