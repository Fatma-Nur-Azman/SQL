CREATE TABLE tweets (
    tweet_id INTEGER,
    user_id INTEGER,
    msg VARCHAR(255),
    tweet_date TIMESTAMP
);

INSERT INTO tweets (tweet_id, user_id, msg, tweet_date) VALUES
(214252, 111, 'Am considering taking Tesla private at $420. Funding secured.', '2021-12-30 00:00:00'),
(739252, 111, 'Despite the constant negative press covfefe', '2022-01-01 00:00:00'),
(846402, 111, 'Following @NickSinghTech on Twitter changed my life!', '2022-02-14 00:00:00'),
(241425, 254, 'If the salary is so competitive why wont you tell me what it is?', '2022-03-01 00:00:00'),
(231574, 148, 'I no longer have a manager. I cant be managed', '2022-03-23 00:00:00');


/*Assume you're given a table Twitter tweet data, write a query to 
obtain a histogram of tweets posted per user in 2022. Output the 
tweet count per user as the bucket and the number of Twitter users who fall into that bucket.

In other words, group the users by the number of tweets they posted in 2022 
and count the number of users in each group.*/

-- Solution 1


SELECT 
  tweets_num AS tweet_bucket, 
  COUNT(user_id) AS users_num 
FROM (

(SELECT 
  user_id, 
  COUNT(tweet_id) AS tweets_num 
FROM tweets 
WHERE tweet_date BETWEEN '2022-01-01' AND '2022-12-31' 
GROUP BY user_id)

) AS total_tweets 
GROUP BY tweets_num;


--First, we need to find the number of tweets posted by each user in 2022 by grouping the tweet records by user ID and counting the tweets.

SELECT 
  user_id, 
  COUNT(tweet_id) AS tweet_count_per_user 
FROM tweets 
WHERE tweet_date BETWEEN '2022-01-01' 
  AND '2022-12-31'
GROUP BY user_id;

/*Based on the output, we can infer that in the year 2022, 
user 111 has posted two tweets, while users 148 and 254 have only posted one tweet each.

Next, we use the query above as a subquery, 
then we use the tweet_count_per_user field as the tweet bucket and retrieve the number of users.*/

SELECT 
  tweet_count_per_user AS tweet_bucket, 
  COUNT(user_id) AS users_num 
FROM (
  SELECT 
    user_id, 
    COUNT(tweet_id) AS tweet_count_per_user 
  FROM tweets 
  WHERE tweet_date BETWEEN '2022-01-01' 
    AND '2022-12-31'
  GROUP BY user_id) AS total_tweets 
GROUP BY tweet_count_per_user;


-- Solution 2
WITH total_tweets AS (
  SELECT 
    user_id, 
    COUNT(tweet_id) AS tweet_count_per_user
  FROM tweets 
  WHERE tweet_date BETWEEN '2022-01-01' 
    AND '2022-12-31' 
  GROUP BY user_id) 
  
SELECT 
  tweet_count_per_user AS tweet_bucket, 
  COUNT(user_id) AS users_num 
FROM total_tweets 
GROUP BY tweet_count_per_user;


