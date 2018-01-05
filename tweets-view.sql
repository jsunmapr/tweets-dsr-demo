create or replace view dfs.tmp.tweets-view as select
cast(to_timestamp(cast(t.ts as BIGINT)/1000) as timestamp) as `tweet_time`,
date_part('year',to_timestamp(cast(t.ts as BIGINT)/1000)) as `year`,
date_part('month',to_timestamp(cast(t.ts as BIGINT)/1000)) as `month`,
date_part('day',to_timestamp(cast(t.ts as BIGINT)/1000)) as `day`,
date_part('hour',to_timestamp(cast(t.ts as BIGINT)/1000)) as `hour`,
cast(t._id as varchar(40)) as id,
cast(t.retweet_count as int) as retweet_count,
cast(t.screen_name as varchar(20)) as screen_name,
cast(t.text as varchar(140)) as text,
cast(t.followers_count as int) as followers_count,
cast(t.utc_offset as varchar(20)) as utc_offset,
cast(t.location as varchar(20)) as location,
cast(t.time_zone as varchar(10)) as time_zone,
cast(t.hashtags as varchar(100)) as hashtags
from dfs.`tmp`.tweets t
