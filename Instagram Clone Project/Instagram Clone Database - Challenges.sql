
USE insta;
/*We want to reward our users who have been around the longest.  
Find the 5 oldest users.*/
SELECT *
FROM users
ORDER BY created_at
LIMIT 5;

/*What day of the week do most users register on?
We need to figure out when to schedule an ad campgain*/
SELECT date_format(created_at,'%W') AS 'day of the week', COUNT(*) AS 'total registration'
FROM users
GROUP BY 1
ORDER BY 2 DESC;

/*version 2*/
SELECT DAYNAME(created_at) AS day, COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total DESC
LIMIT 2;


/*We want to target our inactive users with an email campaign.
Find the users who have never posted a photo*/
SELECT users.id, username
FROM users
LEFT JOIN photos ON users.id = photos.user_id
WHERE photos.id IS NULL;


/*We're running a new contest to see who can get the most likes on a single photo.
WHO WON??!!*/
SELECT users.username,photos.id,photos.image_url,COUNT(*) AS Total_Likes
FROM likes
JOIN photos ON photos.id = likes.photo_id
JOIN users ON users.id = likes.user_id
GROUP BY photos.id
ORDER BY Total_Likes DESC
LIMIT 1;

/*version 2*/
SELECT username, photos.id, photos.image_url, COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON likes.photo_id = photos.id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;


/*Our Investors want to know...
How many times does the average user post?*/
/*total number of photos/total number of users*/
SELECT ROUND((SELECT COUNT(*)FROM photos)/(SELECT COUNT(*) FROM users),2);

/*user ranking by postings higher to lower*/
SELECT users.username,COUNT(photos.image_url) AS Total_postings
FROM users
JOIN photos ON users.id = photos.user_id
GROUP BY users.id
ORDER BY 2 DESC;

/*total numbers of users who have posted at least one time */
SELECT COUNT(DISTINCT(users.id)) AS total_number_of_users_with_posts
FROM users
JOIN photos ON users.id = photos.user_id;

/*A brand wants to know which hashtags to use in a post
What are the top 5 most commonly used hashtags?*/
SELECT tag_name, COUNT(tag_name) AS total
FROM tags
JOIN photo_tags ON tags.id = photo_tags.tag_id
GROUP BY tags.id
ORDER BY total DESC;










