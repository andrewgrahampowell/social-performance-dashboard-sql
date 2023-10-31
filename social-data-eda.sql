-- This script performs an exploratory data analysis on a dummy social media dataset

-- Select all to view data

SELECT 
    *
FROM
    social_data.dummy_social_media_data_v2;

-- Find highest average reach by platform (TikTok) and lowest (Twitter)

SELECT platform, PostDate, AVG(reach) 
FROM dummy_social_media_data
GROUP BY platform, PostDate
ORDER BY AVG(reach) DESC;

-- Best performing post type by reach (Video)

SELECT PostType, PostDate, AVG(reach)
FROM dummy_social_media_data_v2
GROUP BY PostType, PostDate
ORDER BY AVG(reach) DESC;

-- Highest average engagements by post type (Image)

SELECT PostType, PostDate, AVG(Likes + Shares + Comments) AS avg_total_engagements
FROM dummy_social_media_data_v2
GROUP BY PostType, PostDate
ORDER BY avg_total_engagements DESC;

-- Best performing post type by reach, by platform (TikTok Video)

SELECT Platform, PostType, PostDate, AVG(reach)
FROM dummy_social_media_data_v2
GROUP BY Platform, PostType, PostDate
ORDER BY AVG(reach) DESC;

-- Best performing post type by engagements, by platform (Twitter Video)

SELECT Platform, PostType, PostDate, AVG(Likes + Shares + Comments) AS avg_total_engagements
FROM dummy_social_media_data_v2
GROUP BY Platform, PostType, PostDate
ORDER BY avg_total_engagements DESC;

-- Calculate engagement rate by post, by platform (Highest - #7187, 99.97%, Instagram)

SELECT PostContent, PostType, PostDate, Platform,
       (SUM(likes + comments + shares) / SUM(reach)) AS engagement_rate
FROM dummy_social_media_data_v2
GROUP BY PostContent, PostType, PostDate, Platform
ORDER BY engagement_rate DESC;

-- Calculate average engagement rate by post type, by platform, expressed as percentage

SELECT PostType, Platform, PostDate, 
       CONCAT(ROUND(AVG((likes + comments + shares) / reach) * 100, 2), '%') AS avg_engagement_rate
FROM dummy_social_media_data_v2
GROUP BY PostType, Platform, PostDate
ORDER BY avg_engagement_rate DESC;

-- 20 highest reach posts

SELECT PostContent, PostType, PostDate, SUM(reach) AS total_reach
FROM dummy_social_media_data_v2
GROUP BY PostContent, PostType, PostDate
ORDER BY total_reach DESC
LIMIT 20;

-- 20 lowest reach posts

SELECT PostContent, PostType, PostDate, SUM(reach) AS total_reach
FROM dummy_social_media_data_v2
GROUP BY PostContent, PostType, PostDate
ORDER BY total_reach ASC
LIMIT 20;

-- Top 20 posts with most engagements

SELECT 
    PostContent,
    PostType,
    PostDate,
    SUM(likes + comments + shares) AS total_engagements
FROM
    dummy_social_media_data_v2
GROUP BY PostContent, PostType, PostDate
ORDER BY total_engagements DESC
LIMIT 20;

-- Top 20 posts with fewest engagements 

SELECT 
    PostContent,
    PostType,
    PostDate,
    SUM(likes + comments + shares) AS total_engagements
FROM
    dummy_social_media_data_v2
GROUP BY PostContent, PostType, PostDate
ORDER BY total_engagements ASC
LIMIT 20;
