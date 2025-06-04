SELECT *
FROM personality_staging;

-- Who spends more time alone? 
SELECT Personality, AVG(Time_spent_Alone), MIN(Time_spent_Alone), MAX(Time_spent_Alone)
FROM personality_staging
GROUP BY Personality;
-- From the results of this query here, on average introverts spend more time alone. 


-- this was to see if there was was a corrolation between the average friend group size and amount posted, with the social battery of average people. 
SELECT Drained_after_socializing, AVG(Friends_circle_size), AVG(Post_frequency)
FROM personality_staging
WHERE Drained_after_socializing is NOT NULL
GROUP BY Drained_after_socializing;
-- On average, those that feel more socially drained are more likely to have smaller friend groups and do not post offter

-- stage fear vs social event attendance. 
SELECT Stage_fear, AVG(Social_event_attendance)
FROM personality_staging
WHERE Stage_fear is NOT NULL
GROUP BY Stage_fear;
-- Those that have stage fear then to not attend social events

-- Does friend group size affect the average time spent alone 
SELECT Friends_circle_size, AVG(Time_spent_alone)
FROM personality_staging
GROUP BY Friends_circle_size
ORDER BY Friends_circle_size;
-- in general the trend is that as the friend size increases the time spent alone decreases. 

-- is there a corrolation between stage fear vs being drained after socializing
SELECT Stage_fear, Drained_after_socializing, COUNT(*)
FROM personality_staging
GROUP BY Stage_fear, Drained_after_socializing;
-- there is a strong positive corrolation between stage fear and being drained after socializing. 


