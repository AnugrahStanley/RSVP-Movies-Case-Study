USE imdb;

/* Now that you have imported the data sets, let’s explore some of the tables. 
 To begin with, it is beneficial to know the shape of the tables and whether any column has null values.
 Further in this segment, you will take a look at 'movies' and 'genre' tables.*/



-- Segment 1:




-- Q1. Find the total number of rows in each table of the schema?
-- Type your code below:

SELECT 'director_mapping' 	AS Table_Names,
       Count(*)           	AS Total_Rows
FROM   director_mapping
UNION ALL
SELECT 'genre'  			AS Table_Names,
       Count(*) 			AS Total_Rows
FROM   genre
UNION ALL
SELECT 'movie'  			AS Table_Names,
       Count(*) 			AS Total_Rows
FROM   movie
UNION ALL
SELECT 'names'  			AS Table_Names,
       Count(*) 			AS Total_Rows
FROM   names
UNION ALL
SELECT 'ratings' 			AS Table_Names,
       Count(*)  			AS Total_Rows
FROM   ratings
UNION ALL
SELECT 'role_mapping' 		AS Table_Names,
       Count(*)       		AS Total_Rows
FROM   role_mapping; 


/*
The total number of rows in each table of the schema is as shown in the table below-
		+-----------------------+---------------+
		|	    Table_Names		|	Table_Rows	|		
		+-----------------------+---------------+
        |	director_mapping	|	 3867		|
        |	genre				|	 14662		|
        |	movie				|	 7997		|
        |	names				|	 25735		|
		|	ratings				|	 7997		|
        |	role_mapping		|	 15615		|
		+-----------------------+---------------+*/



-- Q2. Which columns in the movie table have null values?
-- Type your code below:

SELECT 'title'  				AS Column_Names,
       Sum(CASE
             WHEN title IS NULL THEN 1
             ELSE 0
           END) 				AS Null_Count
FROM   movie
UNION ALL
SELECT 'year'   				AS Column_Names,
       Sum(CASE	
             WHEN year IS NULL THEN 1
             ELSE 0
           END) 				AS Null_Count
FROM   movie
UNION ALL
SELECT 'date_published' 		AS Column_Names,
       Sum(CASE
             WHEN date_published IS NULL THEN 1
             ELSE 0
           END)         		AS Null_Count
FROM   movie
UNION ALL
SELECT 'duration' 				AS Column_Names,
       Sum(CASE
             WHEN duration IS NULL THEN 1
             ELSE 0
           END)   				AS Null_Count
FROM   movie
UNION ALL
SELECT 'country' 				AS Column_Names,
       Sum(CASE
             WHEN country IS NULL THEN 1
             ELSE 0
           END)  				AS Null_Count
FROM   movie
UNION ALL
SELECT 'worlwide_gross_income' 	AS Column_Names,
       Sum(CASE
             WHEN worlwide_gross_income IS NULL THEN 1
             ELSE 0
           END) 	           	AS Null_Count
FROM   movie	
UNION ALL
SELECT 'languages' 				AS Column_Names,
       Sum(CASE
             WHEN languages IS NULL THEN 1
             ELSE 0
           END)    				AS Null_Count
FROM   movie
UNION ALL
SELECT 'production_company' 	AS Column_Names,
       Sum(CASE
             WHEN production_company IS NULL THEN 1
             ELSE 0
           END)             	AS Null_Count
FROM   movie; 

/*
The total number of rows in each column of the movie table is as shown in the table below-
		+---------------------------+---------------+
		|		Column_Names		|   Null_Count	|	
		+---------------------------+---------------+
        |	title					|	  0			|
        |	year					|	  0			|
		|	date_published			|	  0			|
        |	duration				|	  0			|
        |	country					|	  20		|
        |	worlwide_gross_income	|	  3724		|
		|	languages				|	  194		|
        |	production_company		|	  528		|
		+---------------------------+---------------+
	Note: 	There are 4 columns, namely country,worlwide_gross_income,languages and production_company in movie table having null values.*/



-- Now as you can see four columns of the movie table has null values. Let's look at the at the movies released each year. 
-- Q3. Find the total number of movies released each year? How does the trend look month wise? (Output expected)

/* Output format for the first part:

+---------------+-------------------+
| Year			|	number_of_movies|
+-------------------+----------------
|	2017		|	2134			|
|	2018		|		.			|
|	2019		|		.			|
+---------------+-------------------+


Output format for the second part of the question:
+---------------+-------------------+
|	month_num	|	number_of_movies|
+---------------+----------------
|	1			|	 134			|
|	2			|	 231			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

-- Part 1
SELECT year      AS Year,
       Count(id) AS number_of_movies
FROM   movie
GROUP  BY year; 

/* Output for the first part of the question:
			+-----------+-------------------+
			|	Year	|  number_of_movies |
			+-----------+-------------------+
			|	2017	|		3052		|
			|	2018	|		2944		|
			|	2019	|		2001		|
			+-----------+-------------------+
		Note:	The highest number of movies(3057) were produced in the year 2017.*/


-- Part 2
SELECT Month(date_published) AS month_num,
       Count(id)             AS number_of_movies
FROM   movie
GROUP  BY month_num
ORDER  BY month_num; 

/*
Output for the second part of the question:
			+---------------+-------------------+
			|	month_num	|  number_of_movies	|
			+---------------+-------------------+
			|	1			|		804			|
			|	2			|	 	640			|
			|	3			|		824			|
			|	4			|		680			|
			|	5			|		625			|
			|	6			|		580			|
			|	7			|		493			|
			|	8			|		678			|
			|	9			|		809			|
			|	10			|		801			|
			|	11			|		625			|
			|	12			|		438			|
			+---------------+-------------------+
		Note:	The highest number of movies(824) were produced in the month of March.*/



/*The highest number of movies is produced in the month of March.
So, now that you have understood the month-wise trend of movies, let’s take a look at the other details in the movies table. 
We know USA and India produces huge number of movies each year. Lets find the number of movies produced by USA or India for the last year.*/
  
-- Q4. How many movies were produced in the USA or India in the year 2019??
-- Type your code below:

SELECT Count(id) AS Movie_Count
FROM   movie
WHERE  year = 2019
       AND country REGEXP 'USA|INDIA'; 

/*
Output:
			+---------------+
			|	Movie_Count	| 
			+---------------+
			|	   1059		|
			+---------------+
		Note: India and the USA have produced 1059 movies in the year 2019.*/



/* USA and India produced more than a thousand movies(you know the exact number!) in the year 2019.
Exploring table Genre would be fun!! 
Let’s find out the different genres in the dataset.*/

-- Q5. Find the unique list of the genres present in the data set?
-- Type your code below:

SELECT genre AS Unique_Genres
FROM   genre
GROUP  BY genre; 

/*
Output:
			+-------------------+
			|	Unique_Genres	| 
			+-------------------+
			|	   Drama		|
			|	   Fantasy		|
			|	   Thriller		|
			|	   Comedy		|
			|	   Horror		|
			|	   Family		|
			|	   Romance		|
			|	  Adventure		|
			|	   Action		|
			|	   Sci-Fi		|
			|	   Crime		|
			|	   Mystery		|
			|	   Others		|
			+-------------------+
		Note: There are 13 unique_genres present in the data set.*/



/* So, RSVP Movies plans to make a movie of one of these genres.
Now, wouldn’t you want to know which genre had the highest number of movies produced in the last year?
Combining both the movie and genres table can give more interesting insights. */

-- Q6.Which genre had the highest number of movies produced overall?
-- Type your code below:

WITH genre_summary AS 
(
	SELECT g.genre,
		   Count(m.id)                    AS Number_of_Movies,
		   RANK()
			 OVER(
			   ORDER BY Count(m.id) DESC) AS genre_rank
	FROM   movie m
		   INNER JOIN genre g
				   ON m.id = g.movie_id
	GROUP  BY g.genre
)
SELECT genre,
       number_of_movies
FROM   genre_summary
WHERE  genre_rank = 1; 

/*
Output :
			+-----------+-------------------+
			|	genre	|  number_of_movies	|
			+-----------+-------------------+
			|	Drama	|		4285		|
			+-----------+-------------------+
		Note: "Drama" genre has the highest number of movies(4285) produced overall. */



/* So, based on the insight that you just drew, RSVP Movies should focus on the ‘Drama’ genre. 
But wait, it is too early to decide. A movie can belong to two or more genres. 
So, let’s find out the count of movies that belong to only one genre.*/

-- Q7. How many movies belong to only one genre?
-- Type your code below:

WITH genre_summary AS
(
	SELECT m.id,
		   Count(g.genre) AS genre_per_movie
	FROM   movie m
		   INNER JOIN genre g
				   ON m.id = g.movie_id
	GROUP  BY m.id 
)
SELECT Count(*) AS One_Genre_Movie_Count
FROM   genre_summary
WHERE  genre_per_movie = 1; 

/*
Output:
			+---------------------------+
			|	One_Genre_Movie_Count	| 
			+---------------------------+
			|	   		3289			|
			+---------------------------+
		Note: 3289 movies belong to only one genre. */



/* There are more than three thousand movies which has only one genre associated with them.
So, this figure appears significant. 
Now, let's find out the possible duration of RSVP Movies’ next project.*/

-- Q8.What is the average duration of movies in each genre? 
-- (Note: The same movie can belong to multiple genres.)


/* Output format:

+---------------+-------------------+
| genre			|	avg_duration	|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT g.genre,
       Round(AVG(m.duration)) AS avg_duration
FROM   movie m
       INNER JOIN genre g
               ON m.id = g.movie_id
GROUP  BY g.genre
ORDER  BY g.genre DESC; 


/* Output:
				+---------------+-------------------+
                |	  genre		|	avg_duration	|
				+---------------+-------------------+
                |	Thriller	|		102			|
			    |	Sci-Fi		|		98			|
            	|	Romance		|		110			|
            	|	Others		|		100			|
            	|	Mystery		|		102			|
            	|	Horror		|		93			|
            	|	Fantasy		|		105			|
            	|	Family		|		101			|
            	|	Drama		|		107			|
            	|	Crime		|		107			|
            	|	Comedy		|		103			|
            	|	Adventure	|		102			|
            	|	Action		|		113			|
                +---------------+-------------------+
		Note: "Drama" genre has the rounded average movie duration as 107 mins. */



/* Now you know, movies of genre 'Drama' (produced highest in number in 2019) has the average duration of 106.77 mins.
Lets find where the movies of genre 'thriller' on the basis of number of movies.*/

-- Q9.What is the rank of the ‘thriller’ genre of movies among all the genres in terms of number of movies produced? 
-- (Hint: Use the Rank function)


/* Output format:
+---------------+-------------------+---------------------+
| genre			|		movie_count	|		genre_rank    |	
+---------------+-------------------+---------------------+
|drama			|	2312			|			2		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

WITH genre_summary AS 
(
	SELECT genre,
		   Count(movie_id)                    AS movie_count,
		   RANK()
			 OVER(
			   ORDER BY Count(movie_id) DESC) AS genre_rank
	FROM   genre
	GROUP  BY genre 
)
SELECT *
FROM   genre_summary
WHERE  genre = 'Thriller'; 


/* Output:
			+---------------+-------------------+-----------------+
			| 	  genre		|	 movie_count	|	genre_rank    |	
			+---------------+-------------------+-----------------+
			|	Thriller	|		1484		|		3		  |
			+---------------+-------------------+-----------------+
		Note: The rank of the ‘Thriller’ genre of movies among all the genres in terms of number of movies produced(1484) is Three(3).*/



/*Thriller movies is in top 3 among all genres in terms of number of movies
 In the previous segment, you analysed the movies and genres tables. 
 In this segment, you will analyse the ratings table as well.
To start with lets get the min and max values of different columns in the table*/




-- Segment 2:




-- Q10.  Find the minimum and maximum values in  each column of the ratings table except the movie_id column?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes 	 |min_median_rating|min_median_rating|
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+
|		0		|			5		|	       177		  |	   2000	    		 |		0	       |	8			 |
+---------------+-------------------+---------------------+----------------------+-----------------+-----------------+*/
-- Type your code below:

SELECT Round(Min(avg_rating))   AS min_avg_rating,
       Round(Max(avg_rating))   AS max_avg_rating,
       Round(Min(total_votes))  AS min_total_votes,
       Max(total_votes)   		AS max_total_votes,
       Min(median_rating) 		AS min_median_rating,
       Max(median_rating) 		AS max_median_rating
FROM   ratings; 

/* Output:
			+---------------+-------------------+---------------------+------------------+-----------------+-----------------+
			| min_avg_rating|	max_avg_rating	|	min_total_votes   |	max_total_votes  |min_median_rating|min_median_rating|
			+---------------+-------------------+---------------------+------------------+-----------------+-----------------+
			|		1		|		  10		|	       100		  |	    725138	   	 |		  1	       |	    10		 |
			+---------------+-------------------+---------------------+------------------+-----------------+-----------------+
		Note: The minimum and maximum values in each column of the ratings table are in the expected range, implying the absence of outliers.*/


    
/* So, the minimum and maximum values in each column of the ratings table are in the expected range. 
This implies there are no outliers in the table. 
Now, let’s find out the top 10 movies based on average rating.*/

-- Q11. Which are the top 10 movies based on average rating?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		movie_rank    |
+---------------+-------------------+---------------------+
| Fan			|		9.6			|			5	  	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:
-- It's ok if RANK() or DENSE_RANK() is used too

WITH top_movies AS
(
	SELECT m.title,
		   r.avg_rating,
		   RANK()
			 OVER(
			   ORDER BY r.avg_rating DESC) AS movie_rank
	FROM   movie m
		   INNER JOIN ratings r
				   ON m.id = r.movie_id
	GROUP BY m.title,r.avg_rating
)
SELECT title,
	   avg_rating,
	   movie_rank
FROM   top_movies
WHERE  movie_rank < 11; 

/* Output:
			+-----------------------------------+-----------+-----------+
			|				title				| avg_rating| movie_rank|
			+-----------------------------------+-----------+-----------+
			|	Kirket							|	 10		|	  1		|
			|   Love in Kilnerry				|	 10		|	  1		|
			|   Gini Helida Kathe				|	 9.8	|	  3		|
			|   Runam							|	 9.7	|	  4		|
            |	Fan								|	 9.6	|	  5		|
            |	Android Kunjappan Version 5.25	|	 9.6	|	  5		|
            |	Yeh Suhaagraat Impossible		|	 9.5	|	  7		|
            |	Safe							|	 9.5	|	  7		|
            |	The Brighton Miracle			|	 9.5	|	  7		|
            |	Shibu							|	 9.4	|	 10		|
            |	Our Little Haven				|	 9.4	|	 10		|
            |	Zana							|	 9.4	|	 10		|
            |	Family of Thakurganj			|	 9.4	|	 10		|
            |	Ananthu V/S Nusrath				|	 9.4	|	 10		|
            +-----------------------------------+-----------+-----------+    
		Note: "Kirket" and "Love in Kilnerry" top the rankings among the top 10 movies based on average rating.*/



/* Do you find you favourite movie FAN in the top 10 movies with an average rating of 9.6? If not, please check your code again!!
So, now that you know the top 10 movies, do you think character actors and filler actors can be from these movies?
Summarising the ratings table based on the movie counts by median rating can give an excellent insight.*/

-- Q12. Summarise the ratings table based on the movie counts by median ratings.
/* Output format:

+---------------+-------------------+
| median_rating	|	movie_count		|
+-------------------+----------------
|	1			|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:
-- Order by is good to have

SELECT median_rating,
       Count(movie_id) AS movie_count
FROM   ratings 
GROUP  BY median_rating
ORDER  BY median_rating; 


/* Output:
			+---------------+---------------+
			| median_rating	|  movie_count	|
			+---------------+---------------+
			|	   	1		|		94		|
			|	 	2		|	 	119		|
			|		3		|		283		|
			|		4		|		479		|
			|		5		|		985		|
			|		6		|		1975	|
			|		7		|		2257	|
			|		8		|		1030	|
			|		9		|		429		|
			|	   10		|		346		|
			+---------------+---------------+
		Note: Movies with a median rating of 7 is highest in number i.e. 2257. */



/* Movies with a median rating of 7 is highest in number. 
Now, let's find out the production house with which RSVP Movies can partner for its next project.*/

-- Q13. Which production house has produced the most number of hit movies (average rating > 8)??
/* Output format:
+------------------+-------------------+---------------------+
|production_company|movie_count	       |	prod_company_rank|
+------------------+-------------------+---------------------+
| The Archers	   |		1		   |			1	  	 |
+------------------+-------------------+---------------------+*/
-- Type your code below:

WITH top_prod AS 
(
	SELECT m.production_company,
		   Count(m.id)                    AS movie_count,
		   RANK()
			 OVER(
			   ORDER BY Count(m.id) DESC) AS prod_company_rank
	FROM   movie m
		   INNER JOIN ratings r
				   ON m.id = r.movie_id
	WHERE  r.avg_rating > 8
		   AND production_company IS NOT NULL
	GROUP  BY production_company 
)
SELECT *
FROM   top_prod
WHERE  prod_company_rank = 1;  

/* Output:
			+---------------------------+---------------+-------------------+
			|	  production_company	|  movie_count	| prod_company_rank	|
			+---------------------------+---------------+-------------------+
			|  Dream Warrior Pictures	|	    3	   	|		   1	 	|
            |  National Theatre Live	|	    3	   	|		   1	 	|
			+---------------------------+---------------+-------------------+
		Note: 	The production houses " Dream Warrior Pictures" and "National Theatre Live" have produced 
				the most number(3) of hit movies (average rating > 8).*/


-- It's ok if RANK() or DENSE_RANK() is used too
-- Answer can be Dream Warrior Pictures or National Theatre Live or both

-- Q14. How many movies released in each genre during March 2017 in the USA had more than 1,000 votes?
/* Output format:

+---------------+-------------------+
| genre			|	movie_count		|
+-------------------+----------------
|	thriller	|		105			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

SELECT g.genre,
       Count(m.id) AS movie_count
FROM   genre g
       INNER JOIN movie m
               ON m.id = g.movie_id
       INNER JOIN ratings r
               ON m.id = r.movie_id
WHERE  Month(m.date_published) = 3
       AND Year(m.date_published) = 2017
       AND m.country regexp 'USA'
       AND r.total_votes > 1000
GROUP  BY g.genre
ORDER  BY g.genre DESC; 

/* Output:
			+---------------+-----------+
			|	  genre		|movie_count|
			+---------------+-----------+
			|	Thriller	|	  8		|		
			|	Sci-Fi		|	  7		|
			|	Romance		|	  4		|
			|	Mystery		|	  4		|
			|	Horror		|	  6		|
			|	Fantasy		|	  3		|
			|	Family		|	  1		|
			|	Drama		|	  24	|
			|	Crime		|	  6		|
			|	Comedy		|	  9		|
			|	Adventure	|	  3		|
			|	Action		|	  8		|
			+---------------+-----------+
		Note: 	During March 2017 most movies(24) released in the USA having more than 1,000 votes were of the genre "Drama" 
				and the least(1) was of genre "Family".*/



-- Lets try to analyse with a unique problem statement.
-- Q15. Find movies of each genre that start with the word ‘The’ and which have an average rating > 8?
/* Output format:
+---------------+-------------------+---------------------+
| title			|		avg_rating	|		genre	      |
+---------------+-------------------+---------------------+
| Theeran		|		8.3			|		Thriller	  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
|	.			|		.			|			.		  |
+---------------+-------------------+---------------------+*/
-- Type your code below:

SELECT m.title,
       r.avg_rating,
       g.genre
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
       INNER JOIN genre g
               ON m.id = g.movie_id
WHERE  m.title REGEXP '^The'
       AND r.avg_rating > 8
ORDER  BY g.genre DESC; 

/* Output:
			+---------------------------------------+-----------+-----------+
			|				 title					|avg_rating	|	 genre  |
			+---------------------------------------+-----------+-----------+
			|Theeran Adhigaaram Ondru				|	 8.3	| Thriller	|
			|The King and I							|	 8.2	| Romance	|
			|The Blue Elephant 2					|	 8.8	| Mystery	|
			|The Blue Elephant 2					|	 8.8	|  Horror	|
			|The Blue Elephant 2					|	 8.8	|  Drama	|
			|The Brighton Miracle					|	 9.5	|  Drama	|
			|The Irishman							|	 8.7	|  Drama	|
			|The Colour of Darkness					|	 9.1	|  Drama	|
			|The Mystery of Godliness: The Sequel	|	 8.5	|  Drama	|
			|The Gambinos							|	 8.4	|  Drama	|
			|The King and I							|	 8.2	|  Drama	|
			|The Irishman							|	 8.7	|  Crime	|
			|Theeran Adhigaaram Ondru				|	 8.3	|  Crime	|
			|The Gambinos							|	 8.4	|  Crime	|
			|Theeran Adhigaaram Ondru				|	 8.3	|  Action	|
			+---------------------------------------+-----------+-----------+
		Note: Most of the movies are from "Drama" genre. */

-- You should also try your hand at median rating and check whether the ‘median rating’ column gives any significant insights.
-- Q16. Of the movies released between 1 April 2018 and 1 April 2019, how many were given a median rating of 8?
-- Type your code below:

SELECT Count(m.id) AS movie_count
FROM   movie m
       INNER JOIN ratings r
               ON m.id = r.movie_id
WHERE  r.median_rating = 8
       AND m.date_published BETWEEN '2018-04-01' AND '2019-04-01'; 


/*
Output:
			+---------------+
			|  movie_count	| 
			+---------------+
			|	  361		|
			+---------------+
		Note: Of the movies released between 1 April 2018 and 1 April 2019, 361 were given a median rating of 8. */



-- Once again, try to solve the problem given below.
-- Q17. Do German movies get more votes than Italian movies? 
-- Hint: Here you have to find the total number of votes for both German and Italian movies.
-- Type your code below:

WITH german_summary AS
(
		SELECT Sum(r.total_votes) 	AS german_movies
        FROM   movie m
			   INNER JOIN ratings r
					   ON m.id = r.movie_id
		WHERE  m.languages regexp "german" 
), 
italian_summary AS
(
		SELECT Sum(r.total_votes) 	AS italian_movies
		FROM   movie m
			   INNER JOIN ratings r
					   ON m.id = r.movie_id
		WHERE  m.languages regexp "italian" 
)
SELECT g.german_movies,
       i.italian_movies,
       CASE
              WHEN g.german_movies>i.italian_movies THEN 'Yes'
              ELSE 'No'
       END 							AS 'German>Italian'
FROM   german_summary g
JOIN   italian_summary i;

/* Output:
			+-------------------+-------------------+-------------------+
			|	german_movies	|	italian_movies	|	German>Italian	|
			+-------------------+-------------------+-------------------+
			|		4421525		|		2559540		|		 Yes		|			
			+-------------------+-------------------+-------------------+
		Note: Yes, German movies(4421525) beat Italian movies(2559540) in terms of total votes. */


-- Answer is Yes

/* Now that you have analysed the movies, genres and ratings tables, let us now analyse another table, the names table. 
Let’s begin by searching for null values in the tables.*/




-- Segment 3:



-- Q18. Which columns in the names table have null values??
/*Hint: You can find null values for individual columns or follow below output format
+---------------+-------------------+---------------------+----------------------+
| name_nulls	|	height_nulls	|date_of_birth_nulls  |known_for_movies_nulls|
+---------------+-------------------+---------------------+----------------------+
|		0		|			123		|	       1234		  |	   12345	    	 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

SELECT Sum(CASE
             WHEN NAME IS NULL THEN 1
             ELSE 0
           END) AS name_nulls,
       Sum(CASE
             WHEN height IS NULL THEN 1
             ELSE 0
           END) AS height_nulls,
       Sum(CASE
             WHEN date_of_birth IS NULL THEN 1
             ELSE 0
           END) AS date_of_birth_nulls,
       Sum(CASE
             WHEN known_for_movies IS NULL THEN 1
             ELSE 0
           END) AS known_for_movies_nulls
FROM   names; 

/* Output:
			+---------------+-------------------+---------------------+----------------------+
			| name_nulls	|	height_nulls	| date_of_birth_nulls |known_for_movies_nulls|
			+---------------+-------------------+---------------------+----------------------+
			|		0		|		17335		|	      13431		  |	       15226    	 |
			+---------------+-------------------+---------------------+----------------------+
		Note: The columns height, date_of_birth and known_for_movies have null values.*/



/* There are no Null value in the column 'name'.
The director is the most important person in a movie crew. 
Let’s find out the top three directors in the top three genres who can be hired by RSVP Movies.*/

-- Q19. Who are the top three directors in the top three genres whose movies have an average rating > 8?
-- (Hint: The top three genres would have the most number of movies with an average rating > 8.)
/* Output format:

+---------------+-------------------+
| director_name	|	movie_count		|
+---------------+-------------------|
|James Mangold	|		4			|
|	.			|		.			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_genres AS
(
	SELECT g.genre,
		   Count(m.id)                    				AS movie_count,
		   RANK()
			 OVER(
			   ORDER BY Count(m.id) DESC) 				AS genre_rank
	FROM   movie m
		   INNER JOIN genre g
				   ON g.movie_id = m.id
		   INNER JOIN ratings r
				   ON r.movie_id = m.id
	WHERE  r.avg_rating > 8
	GROUP  BY g.genre 
    ),
top_directors AS
(
	SELECT n.NAME                               		AS director_name,
		   Count(r.movie_id)                    		AS movie_count,
		   RANK()
			 OVER(
			   ORDER BY Count(r.movie_id) DESC) 		AS director_rank
	FROM   director_mapping d
		   INNER JOIN genre g
				   ON d.movie_id = g.movie_id
		   INNER JOIN names n
				   ON n.id = d.name_id
		   INNER JOIN top_genres t
				   ON g.genre = t.genre
		   INNER JOIN ratings r
				   ON r.movie_id = g.movie_id
	WHERE  t.genre_rank <= 3
		   AND r.avg_rating > 8
	GROUP  BY name
)
SELECT director_name,
       movie_count
FROM   top_directors
WHERE  director_rank <= 3; 

/* Output:
			+---------------+---------------+
			| director_name	|  movie_count	|
			+---------------+---------------|
			|James Mangold	|		4		|
			|Anthony Russo	|		3		|
			|Joe Russo		|		3		|
            |Soubin Shahir	|		3		|
            +---------------+---------------+ 
		Note: The top director in the top three genres whose movies have an average rating > 8 is "James Mangold".*/



/* James Mangold can be hired as the director for RSVP's next project. Do you remeber his movies, 'Logan' and 'The Wolverine'. 
Now, let’s find out the top two actors.*/

-- Q20. Who are the top two actors whose movies have a median rating >= 8?
/* Output format:

+---------------+-------------------+
| actor_name	|	movie_count		|
+-------------------+----------------
|Christain Bale	|		10			|
|	.			|		.			|
+---------------+-------------------+ */
-- Type your code below:

WITH top_actors AS
(
	SELECT n.NAME                               AS actor_name,
		   Count(r.movie_id)                    AS movie_count,
		   RANK()
			 OVER(
			   ORDER BY Count(r.movie_id) DESC) AS actor_rank
	FROM   names n
		   INNER JOIN role_mapping rm
				   ON n.id = rm.name_id
		   INNER JOIN ratings r
				   ON r.movie_id = rm.movie_id
	WHERE  r.median_rating >= 8
		   AND rm.category = 'actor'
	GROUP  BY n.NAME
)
SELECT actor_name,
       movie_count
FROM   top_actors
WHERE  actor_rank < 3; 

/* Output:
			+-----------+-----------+
			|actor_name	|movie_count|
			+-----------+-----------+
			| Mammootty	|	 8		|
			| Mohanlal	|	 5		|
			+-----------+-----------+ 
		Note: "Mammootty" and "Mohanlal" are the top two actors whose movies have a median rating >= 8. */
	


/* Have you find your favourite actor 'Mohanlal' in the list. If no, please check your code again. 
RSVP Movies plans to partner with other global production houses. 
Let’s find out the top three production houses in the world.*/

-- Q21. Which are the top three production houses based on the number of votes received by their movies?
/* Output format:
+------------------+--------------------+---------------------+
|production_company|vote_count			|		prod_comp_rank|
+------------------+--------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

WITH top_prod AS
(
	SELECT m.production_company,
		   Sum(r.total_votes)                    AS vote_count,
		   RANK()
			 OVER(
			   ORDER BY Sum(r.total_votes) DESC) AS prod_comp_rank
	FROM   movie m
		   INNER JOIN ratings r
				   ON m.id = r.movie_id
	GROUP  BY m.production_company 
)
SELECT *
FROM   top_prod
WHERE  prod_comp_rank <= 3; 

/* Output:
			+-----------------------+-----------+---------------+
			|   production_company	| vote_count| prod_comp_rank|
			+-----------------------+-----------+--------+------+
			|	Marvel Studios		|  2656967	|		1	  	|
			| Twentieth Century Fox	|  2411163	|		2		|
			|	Warner Bros.		|  2396057	|		3		|
			+-----------------------+-----------+---------------+
		Note: :	Marvel Studios", "Twentieth Century Fox", "Warner Bros." are the top three production houses 
				based on the number of votes received by their movies. */


/*Yes Marvel Studios rules the movie world.
So, these are the top three production houses based on the number of votes received by the movies they have produced.

Since RSVP Movies is based out of Mumbai, India also wants to woo its local audience. 
RSVP Movies also wants to hire a few Indian actors for its upcoming project to give a regional feel. 
Let’s find who these actors could be.*/

-- Q22. Rank actors with movies released in India based on their average ratings. Which actor is at the top of the list?
-- Note: The actor should have acted in at least five Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actor_name	|	total_votes		|	movie_count		  |	actor_avg_rating 	 |actor_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Yogi Babu	|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

SELECT     n.NAME 																									AS actor_name,
           sum(r.total_votes)																						AS total_votes,
           Count(r.movie_id)                                                                                		AS movie_count,
           Round(Sum(r.avg_rating*r.total_votes)/Sum(r.total_votes),2)                                      		AS actor_avg_rating,
		   RANK()
			 OVER(
			   ORDER BY Round(Sum(r.avg_rating*r.total_votes)/Sum(r.total_votes),2) DESC,Sum(r.total_votes) DESC)	AS actor_rank
FROM   names n
       INNER JOIN role_mapping rm
               ON n.id = rm.name_id
       INNER JOIN ratings r
               ON rm.movie_id = r.movie_id
       INNER JOIN movie m
               ON m.id = r.movie_id
WHERE  m.country REGEXP "india"
       AND rm.category = 'actor'
GROUP  BY n.name
HAVING Count(r.movie_id) >= 5; 

/* Output:
			+-------------------+----------	+-----------+-------------------+-----------+
			|     actor_name	|total_votes|movie_count|actor_avg_rating 	|actor_rank	|   
			+-------------------+-----------+-----------+-------------------+-----------+
			|Vijay Sethupathi	|	23114	|	  5	  	|	   8.42	 		|	   1	|
			|Fahadh Faasil		|	13557	|	  5     |	   7.99	    	|	   2	|
			|Yogi Babu			|	8500	|	  11    |	   7.83	    	|	   3	| 
			|		.			|			|	  .		|	   .	    	|		.	|
			|		.			|			|	  .	  	|	   .	    	|		.	|
			+-------------------+-----------+-----------+-------------------+-----------+
		Note: 	Vijay Sethupathi tops the list of actors with movies released in India based on their average ratings.
				His total movie count is 5.*/


-- Top actor is Vijay Sethupathi

-- Q23.Find out the top five actresses in Hindi movies released in India based on their average ratings? 
-- Note: The actresses should have acted in at least three Indian movies. 
-- (Hint: You should use the weighted average based on votes. If the ratings clash, then the total number of votes should act as the tie breaker.)
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |	actress_avg_rating 	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Tabu		|			3455	|	       11		  |	   8.42	    		 |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH actress_ranking AS
(
	SELECT n.NAME       									                                                    	AS actress_name,
		   Sum(r.total_votes)																						AS total_votes,
		   Count(r.movie_id)                                                										AS movie_count,
		   Round(Sum(r.avg_rating * r.total_votes) / Sum(r.total_votes), 2) 										AS actress_avg_rating,
		   RANK()
			 OVER(
			   ORDER BY Round(Sum(r.avg_rating*r.total_votes)/Sum(r.total_votes), 2) DESC, Sum(r.total_votes) DESC)	AS actress_rank 
	FROM   names n
		   INNER JOIN role_mapping rm
				   ON n.id = rm.name_id
		   INNER JOIN ratings r
				   ON rm.movie_id = r.movie_id
		   INNER JOIN movie m
				   ON m.id = r.movie_id
	WHERE  m.country REGEXP ".*india.*"
		   AND rm.category = 'actress'
		   AND m.languages REGEXP ".*hindi.*"
	GROUP  BY n.name
	HAVING Count(r.movie_id) >= 3 
)
SELECT *
FROM   actress_ranking
WHERE  actress_rank<=5;




/* Output:
			+---------------+---------------+---------------+-------------------+---------------+
			| actress_name	|  total_votes	|  movie_count	|actress_avg_rating	| actress_rank	|
			+---------------+---------------+---------------+-------------------+---------------+
			|Taapsee Pannu	|	   18061	|	 	3	  	|	   7.74	    	|		1	    |
			|Kriti Sanon	|	   21967	|	    3		|	   7.05	    	|		2	    |
			|Divya Dutta	|	   8579		|	    3		|	   6.88	    	|		3	    |
			|Shraddha Kapoor|	   26779	|	    3		|	   6.63	    	|		4	    |
			|Kriti Kharbanda|	   2549		|	    3		|	   4.80	    	|		5	    |
            +---------------+---------------+---------------+-------------------+---------------+
		Note: "Taapsee Pannu is the top actress in Hindi movies released in India based on their average ratings.*/



/* Taapsee Pannu tops with average rating 7.74. 
Now let us divide all the thriller movies in the following categories and find out their numbers.*/


/* Q24. Select thriller movies as per avg rating and classify them in the following category: 

			Rating > 8: Superhit movies
			Rating between 7 and 8: Hit movies
			Rating between 5 and 7: One-time-watch movies
			Rating < 5: Flop movies
--------------------------------------------------------------------------------------------*/
-- Type your code below:

SELECT m.title,
       r.avg_rating,
       CASE
       WHEN avg_rating > 8 THEN 'Superhit'
       WHEN avg_rating BETWEEN 7 AND 8 THEN 'Hit'
       WHEN avg_rating BETWEEN 5 AND 7 THEN 'One-time-watch'
       ELSE 'Flop'
       END AS movie_category
FROM   movie m
       INNER JOIN genre g
               ON m.id = g.movie_id
       INNER JOIN ratings r
               ON g.movie_id = r.movie_id
WHERE  g.genre = 'Thriller'
GROUP BY m.title,r.avg_rating;

/*	Note: Upon dividing all the thriller movies into different categories the numbers look as follows: 
			+-------------------+---------------+
            |   Movie_Category	|  Movie_Count	|
            +-------------------+---------------+
            |  Superhit			|		39		|
            |  Hit				|	   166		|
			|  One-time-watch	|	   785		|
			|  Flop				|	   492		|
			+-------------------+---------------+

/* Until now, you have analysed various tables of the data set. 
Now, you will perform some tasks that will give you a broader understanding of the data in this segment.*/

-- Segment 4:

-- Q25. What is the genre-wise running total and moving average of the average movie duration? 
-- (Note: You need to show the output table in the question.) 
/* Output format:
+---------------+-------------------+---------------------+----------------------+
| genre			|	avg_duration	|running_total_duration|moving_avg_duration  |
+---------------+-------------------+---------------------+----------------------+
|	comdy		|			145		|	       106.2	  |	   128.42	    	 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
|		.		|			.		|	       .		  |	   .	    		 |
+---------------+-------------------+---------------------+----------------------+*/
-- Type your code below:

WITH genre_wise_summary AS 
(
	SELECT g.genre,
		   Round(AVG(m.duration))                         AS avg_duration,
		   Sum(Round(AVG(m.duration), 1))
			 OVER(
			   ORDER BY g.genre ROWS UNBOUNDED PRECEDING) AS running_total_duration,
		   AVG(Round(AVG(m.duration), 2))
			 OVER(
			   ORDER BY g.genre ROWS UNBOUNDED PRECEDING) AS moving_avg_duration
	FROM   movie m
		   INNER JOIN genre g
				   ON m.id = g.movie_id
	GROUP  BY g.genre 
)
SELECT genre,
       avg_duration,
       running_total_duration,
       Round(moving_avg_duration, 2) AS moving_avg_duration
FROM   genre_wise_summary;  

/* Output:
			+---------------+---------------+-----------------------+-------------------+
			|	  genre		| avg_duration	|running_total_duration |moving_avg_duration|
			+---------------+---------------+-----------------------+-------------------+
            |	Action		|	  113		|		  112.9			|	  112.88		|
			|	Adventure	|	  102		|		  214.8			|	  107.38		|
			|	Comedy		|	  103		|		  317.4			|	  105.79		|
			|	Crime		|	  107		|		  424.5			|	  106.11		|
			|	Drama		|	  107		|		  531.3			|	  106.24		|
			|	Family		|	  101		|		  632.3			|	  105.36		|
			|	Fantasy		|	  105		|		  737.4			|	  105.33		|
			|	Horror		|	  93		|		  830.1			|	  103.75		|
			|	Mystery		|	  102		|		  931.9			|	  103.54		|
			|	Others		|	  100		|		 1032.1			|	  103.20		|
			|	Romance		|	  110		|		 1141.6			|	  103.77		|
			|	Sci-Fi		|	  98		|		 1239.5			|	  103.29		|
			|	Thriller	|	  102		|		 1341.1			|	  103.16		|
			+---------------+---------------+-----------------------+-------------------+*/
	

-- Round is good to have and not a must have; Same thing applies to sorting


-- Let us find top 5 movies of each year with top 3 genres.

-- Q26. Which are the five highest-grossing movies of each year that belong to the top three genres? 
-- (Note: The top 3 genres would have the most number of movies.)

/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| genre			|	year			|	movie_name		  |worldwide_gross_income|movie_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	comedy		|			2017	|	       indian	  |	   $103244842	     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

-- Top 3 Genres based on most number of movies

WITH top_genres AS
(
	SELECT g.genre,
		   Count(g.movie_id)                    AS movie_count,
		   RANK()
			 OVER(
			   ORDER BY Count(g.movie_id) DESC) AS genre_rank
	FROM   movie m
		   INNER JOIN genre g
				   ON g.movie_id = m.id
	GROUP  BY g.genre 
),
highest_grossing AS
(
	SELECT g.genre,
		   m.year,
		   m.title                   AS movie_name,
		   Concat('$', Cast(
		   Replace(Replace(Ifnull(m.worlwide_gross_income, 0), 'INR', ''), '$', '')
		   AS
					   DECIMAL(10))) AS worlwide_gross_income,
		   Rank()
			 OVER(
			   partition BY m.year
			   ORDER BY
	Cast(Replace(Replace(Ifnull(m.worlwide_gross_income, 0), 'INR', ''), '$', '')
	AS DECIMAL(10)) DESC)   AS movie_rank
	FROM   movie m
		   INNER JOIN genre g
				   ON m.id = g.movie_id
		   INNER JOIN top_genres t
				   ON t.genre = g.genre
	WHERE  genre_rank < 4
	GROUP  BY m.title 
)
SELECT *
FROM   highest_grossing
WHERE  movie_rank < 6; 


/* Output:
			+-----------+-------+-------------------------------+-----------------------+-----------+
			|   genre	|  year	|movie_name						|worlwide_gross_income	|movie_rank	|
			+-----------+-------+-------------------------------+-----------------------+-----------+
			|Thriller	| 2017	|The Fate of the Furious		|	  $1236005118		|	  1		|
			|Comedy		| 2017	|Despicable Me 3				|	  $1034799409		|	  2		|
			|Comedy		| 2017	|Jumanji: Welcome to the Jungle	|	  $962102237		|	  3		|
			|Drama		| 2017	|Zhan lang II					|	  $870325439		|	  4		|
			|Comedy		| 2017	|Guardians of the Galaxy Vol. 2	|	  $863756051		|	  5		|
			|Thriller	| 2018	|The Villain					|	  $1300000000		|	  1		|
			|Drama		| 2018	|Bohemian Rhapsody				|	  $903655259		|	  2		|
			|Thriller	| 2018	|Venom							|	  $856085151		|	  3		|
			|Thriller	| 2018	|Mission: Impossible - Fallout	|	  $791115104		|	  4		|
			|Comedy		| 2018	|Deadpool 2						|	  $785046920		|	  5		|
			|Drama		| 2019	|Avengers: Endgame				|	  $2797800564		|	  1		|
			|Drama		| 2019	|The Lion King					|	  $1655156910		|	  2		|
			|Comedy		| 2019	|Toy Story 4					|	  $1073168585		|	  3		|
			|Drama		| 2019	|Joker							|	  $995064593		|	  4		|
			|Thriller	| 2019	|Ne Zha zhi mo tong jiang shi	|	  $700547754		|	  5		|
			+-----------+-------+-------------------------------+-----------------------+-----------+ */



-- Finally, let’s find out the names of the top two production houses that have produced the highest number of hits among multilingual movies.
-- Q27.  Which are the top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies?
/* Output format:
+-------------------+-------------------+---------------------+
|production_company |movie_count		|		prod_comp_rank|
+-------------------+-------------------+---------------------+
| The Archers		|		830			|		1	  		  |
|	.				|		.			|			.		  |
|	.				|		.			|			.		  |
+-------------------+-------------------+---------------------+*/
-- Type your code below:

WITH prod_ranking AS
(
	SELECT     m.production_company,
			   Count(m.id)                            AS movie_count,
			   RANK() OVER(ORDER BY Count(m.id) DESC) AS prod_comp_rank
	FROM       movie m
	INNER JOIN ratings r
	ON         m.id=r.movie_id
	WHERE      m.languages regexp ","
	AND        r.median_rating>=8
	AND        production_company IS NOT NULL
	GROUP BY   m.production_company
)
SELECT *
FROM   prod_ranking
WHERE  prod_comp_rank < 3; 

/* Output:
			+-----------------------+-----------+---------------+
			|production_company 	|movie_count| prod_comp_rank|
			+-----------------------+-----------+---------------+
			| Star Cinema			|	  7		|		1	  	|
			| Twentieth Century Fox	|	  4		|		2		|
			+-----------------------+-----------+---------------+
		Note:  The top two production houses that have produced the highest number of hits (median rating >= 8) among multilingual movies
				are "Star Cinema" and "Twentieth Century Fox".*/
		


-- Multilingual is the important piece in the above question. It was created using POSITION(',' IN languages)>0 logic
-- If there is a comma, that means the movie is of more than one language


-- Q28. Who are the top 3 actresses based on number of Super Hit movies (average rating >8) in drama genre?
/* Output format:
+---------------+-------------------+---------------------+----------------------+-----------------+
| actress_name	|	total_votes		|	movie_count		  |actress_avg_rating	 |actress_rank	   |
+---------------+-------------------+---------------------+----------------------+-----------------+
|	Laura Dern	|			1016	|	       1		  |	   9.60			     |		1	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
|		.		|			.		|	       .		  |	   .	    		 |		.	       |
+---------------+-------------------+---------------------+----------------------+-----------------+*/
-- Type your code below:

WITH actress_ranking AS
(
	SELECT n.NAME                                                           AS actress_name,
		   Sum(r.total_votes)												AS total_votes,
		   Count(r.movie_id)                                                AS movie_count,
		   Round(Sum(r.avg_rating * r.total_votes) / Sum(r.total_votes), 2) AS actress_avg_rating,
		   RANK()
			 OVER(
			   ORDER BY Count(r.movie_id) DESC)                             AS actress_rank
	FROM   names n
		   INNER JOIN role_mapping rm
				   ON n.id = rm.name_id
		   INNER JOIN ratings r
				   ON rm.movie_id = r.movie_id
		   INNER JOIN movie m
				   ON m.id = r.movie_id
		   INNER JOIN genre g
				   ON g.movie_id = r.movie_id
	WHERE  r.avg_rating > 8
		   AND g.genre = 'Drama'
		   AND rm.category = 'actress'
	GROUP  BY n.NAME 	
)
SELECT actress_name,
       total_votes,
       movie_count,
       actress_avg_rating,
       actress_rank
FROM   actress_ranking
WHERE  actress_rank <= 3; 


/* Output:
			+-------------------+-----------+-----------+--------------------+------------+
			|   actress_name	|total_votes|movie_count| actress_avg_rating |actress_rank|
			+-------------------+-----------+-----------+--------------------+------------+
			|Parvathy Thiruvothu|	4974	|	  2 	|	    8.25	     |		1	  |
			|Susan Brown		|	656		|	  2     |	    8.94   		 |		1	  |
			|Amanda Lawrence	|	656		|	  2     |	    8.94   		 |		1	  |
            |Denise Gough		|	656		|	  2     |	    8.94   		 |		1	  |
			+---------------+---------------+-----------+----------+----------------------+
		Note:  "Parvathy Thiruvothu is the top actress based on number of Super Hit movies (average rating >8) in drama genre*/





/* Q29. Get the following details for top 9 directors (based on number of movies)
Director id
Name
Number of movies
Average inter movie duration in days
Average movie ratings
Total votes
Min rating
Max rating
total movie durations

Format:
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
| director_id	|	director_name	|	number_of_movies  |	avg_inter_movie_days |	avg_rating	| total_votes  | min_rating	| max_rating | total_duration |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+
|nm1777967		|	A.L. Vijay		|			5		  |	       177			 |	   5.65	    |	1754	   |	3.7		|	6.9		 |		613		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
|	.			|		.			|			.		  |	       .			 |	   .	    |	.		   |	.		|	.		 |		.		  |
+---------------+-------------------+---------------------+----------------------+--------------+--------------+------------+------------+----------------+

--------------------------------------------------------------------------------------------*/
-- Type you code below:

WITH director_info AS
(
	SELECT d.name_id     																AS director_id,
		   n.NAME        																AS director_name,
		   m.id          																AS movie_id,
		   r.avg_rating  																AS avg_rating,
		   r.total_votes 																AS vote_count,
		   m.duration    																AS duration, 
           Datediff(Lead(m.date_published, 1) 
			OVER
				(PARTITION BY d.name_id ORDER BY m.date_published), m.date_published) 	AS inter_movies_duration
	FROM   movie m
		   INNER JOIN ratings r
				   ON m.id = r.movie_id
		   INNER JOIN director_mapping d
				   ON m.id = d.movie_id
		   INNER JOIN names n
				   ON n.id = d.name_id
), 
top_directors AS
(
	SELECT director_id,
		   director_name,
		   Count(movie_id)                    					AS number_of_movies,
		   Round(Avg(inter_movies_duration))  					AS avg_inter_movie_days,
		   Round(Sum(avg_rating*vote_count)/Sum(vote_count), 2) AS avg_rating,
           Sum(vote_count)                    					AS total_votes,
		   Min(avg_rating)                    					AS min_rating,
		   Max(avg_rating)                    					AS max_rating,
		   Sum(duration)                      					AS total_duration,
		   RANK()
			 OVER (
			   ORDER BY Count(movie_id) DESC) 					AS director_rank
	FROM   director_info
	GROUP  BY director_id 
)
SELECT director_id,
       director_name,
       number_of_movies,
       avg_inter_movie_days,
       avg_rating,
       total_votes,
       min_rating,
       max_rating,
       total_duration
FROM   top_directors
WHERE  director_rank < 10; 

/* Output:
+---------------+-------------------+-------------------+-----------------------+---------------+-----------+-----------+------------+----------------+
| director_id	|	director_name	| number_of_movies	| avg_inter_movie_days	|	avg_rating	|total_votes|min_rating	| max_rating | total_duration |
+---------------+-------------------+-------------------+-----------------------+---------------+-----------+-----------+------------+----------------+
|	nm1777967	|A.L. Vijay			|		  5			|		    177			|	  5.65		|	1754	|	  3.7	|	  6.9	 |		613		  |
|	nm2096009	|Andrew Jones		|		  5			|			191			|	  3.04		|	1989	|	  2.7	|	  3.2	 |		432		  |
|	nm0001752	|Steven Soderbergh	|		  4			|			254			|	  6.77		|	171684	|	  6.2	|	  7.0	 |		401		  |
|	nm0425364	|Jesse V. Johnson	|		  4			|			299			|	  6.10		|	14778	|	  4.2	|	  6.5	 |		383		  |
|	nm0515005	|Sam Liu			|		  4			|			260			|	  6.32		|	28557	|	  5.8	|	  6.7	 |		312		  |
|	nm0814469	|Sion Sono			|		  4			|			331			|	  6.31		|	2972	|	  5.4	|	  6.4	 |		502		  |
|	nm0831321	|Chris Stokes		|		  4			|			198			|	  4.32		|	3664	|	  4.0	|	  4.6	 |		352		  |
|	nm2691863	|Justin Price		|		  4			|			315			|	  4.93		|	5343	|	  3.0	|	  5.8	 |		346		  |
|	nm6356309	|Özgür Bakar		|		  4			|			112			|	  3.96		|	1092	|	  3.1	|	  4.9	 |		374		  |
+---------------+-------------------+-------------------+-----------------------+---------------+-----------+-----------+------------+----------------+*/

/*
======================================================================	END	  =========================================================================