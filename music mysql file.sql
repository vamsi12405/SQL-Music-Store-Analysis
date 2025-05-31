-- Create a record label table
CREATE TABLE record_label(
id INT UNSIGNED NOT NULL PRIMARY KEY,
name VARCHAR(50) NOT NULL,
UNIQUE KEY uk_name_in_record_label (name)
);

-- Record label data 
INSERT INTO record_label VALUES
								(1,'Blackened'),
                                (2,'Warner Bros'),
                                (3,'Universal'),
                                (4,'MCA'),
                                (5,'Elektra'),
                                (6,'Capitol');

-- Create Artist Table
CREATE TABLE artist(
id INT UNSIGNED NOT NULL PRIMARY KEY,
record_label_id INT UNSIGNED NOT NULL,
name VARCHAR(50) NOT NULL,
KEY fk_record_label_in_artist (record_label_id),
CONSTRAINT fk_record_label_in_artist FOREIGN KEY (record_label_id) REFERENCES record_label(id),
UNIQUE KEY uk_name_in_artist (record_label_id,name)
);

-- Insert reecords into artist table 
INSERT INTO artist VALUES
						(1,1,'Metallica'),
                        (2,1,'Megadeth'),
                        (3,1,'Anthrax'),
                        (4,2,'Eric Clapton'),
                        (5,2,'ZZ Top'),
                        (6,2,'Van Halen'),
                        (7,3,'Lynyrd Skynyrd'),
                        (8,3,'AC/DC'),
                        (9,6,'The Beatles');

-- Album table creation
CREATE TABLE album (
  id 	int unsigned not null,
  artist_id  int unsigned not null,
  name     varchar(50)  not null,
  year     int unsigned not null,
  PRIMARY KEY (id),
  KEY fk_artist_in_album (artist_id),
  CONSTRAINT fk_artist_in_album FOREIGN KEY (artist_id) REFERENCES artist (id),
  UNIQUE KEY uk_name_in_album (artist_id, name)
);

-- Album table insertion
INSERT INTO album VALUES(1, 1, '...And Justice For All',1988);
INSERT INTO album VALUES(2, 1, 'Black Album',1991);
INSERT INTO album VALUES(3, 1, 'Master of Puppets',1986);
INSERT INTO album VALUES(4, 2, 'Endgame',2009);
INSERT INTO album VALUES(5, 2, 'Peace Sells',1986);
INSERT INTO album VALUES(6, 3, 'The Greater of 2 Evils',2004);
INSERT INTO album VALUES(7, 4, 'Reptile',2001);
INSERT INTO album VALUES(8, 4, 'Riding with the King',2000);
INSERT INTO album VALUES(9, 5, 'Greatest Hits',1992);
INSERT INTO album VALUES(10, 6, 'Greatest Hits',2004);
INSERT INTO album VALUES(11, 7, 'All-Time Greatest Hits',1975);
INSERT INTO album VALUES(12, 8, 'Greatest Hits',2003);
INSERT INTO album VALUES(13, 9, 'Sgt. Pepper''s Lonely Hearts Club Band', 1967);

-- Create song table 
CREATE TABLE song (
  id int unsigned not null,
  album_id int unsigned not null,
  name varchar(50) not null,
  duration real not null,
  PRIMARY KEY (id),
  KEY fk_album_in_song (album_id),
  CONSTRAINT fk_album_in_song FOREIGN KEY (album_id) REFERENCES album (id),
  UNIQUE KEY uk_name_in_song (album_id, name)
);

-- Insert data into song table
INSERT INTO song VALUES(1,1,'One',7.25);
INSERT INTO song VALUES(2,1,'Blackened',6.42);
INSERT INTO song VALUES(3,2,'Enter Sandman',5.3);
INSERT INTO song VALUES(4,2,'Sad But True',5.29);
INSERT INTO song VALUES(5,3,'Master of Puppets',8.35);
INSERT INTO song VALUES(6,3,'Battery',5.13);
INSERT INTO song VALUES(7,4,'Dialectic Chaos',2.26);
INSERT INTO song VALUES(8,4,'Endgame',5.57);
INSERT INTO song VALUES(9,5,'Peace Sells',4.09);
INSERT INTO song VALUES(10,5,'The Conjuring',5.09);
INSERT INTO song VALUES(11,6,'Madhouse',4.26);
INSERT INTO song VALUES(12,6,'I am the Law',6.03);
INSERT INTO song VALUES(13,7,'Reptile',3.36);
INSERT INTO song VALUES(14,7,'Modern Girl',4.49);
INSERT INTO song VALUES(15,8,'Riding with the King',4.23);
INSERT INTO song VALUES(16,8,'Key to the Highway',3.39);
INSERT INTO song VALUES(17,9,'Sharp Dressed Man',4.15);
INSERT INTO song VALUES(18,9,'Legs',4.32);
INSERT INTO song VALUES(19,10,'Eruption',1.43);
INSERT INTO song VALUES(20,10,'Hot For Teacher',4.43);
INSERT INTO song VALUES(21,11,'Sweet Home Alabama',4.45);
INSERT INTO song VALUES(22,11,'Free Bird',14.23);
INSERT INTO song VALUES(23,12,'Thunderstruck',4.52);
INSERT INTO song VALUES(24,12,'T.N.T',3.35);
INSERT INTO song VALUES(25,13,'Sgt. Pepper''s Lonely Hearts Club Band', 2.0333);
INSERT INTO song VALUES(26,13,'With a Little Help from My Friends', 2.7333);
INSERT INTO song VALUES(27,13,'Lucy in the Sky with Diamonds', 3.4666);
INSERT INTO song VALUES(28,13,'Getting Better', 2.80);
INSERT INTO song VALUES(29,13,'Fixing a Hole', 2.60);
INSERT INTO song VALUES(30,13,'She''s Leaving Home', 3.5833);
INSERT INTO song VALUES(31,13,'Being for the Benefit of Mr. Kite!',2.6166);
INSERT INTO song VALUES(32,13,'Within You Without You',5.066);
INSERT INTO song VALUES(33,13,'When I''m Sixty-Four',2.6166);
INSERT INTO song VALUES(34,13,'Lovely Rita', 2.7);
INSERT INTO song VALUES(35,13,'Good Morning Good Morning', 2.6833);
INSERT INTO song VALUES(36,13,'Sgt. Pepper''s Lonely Hearts Club Band (Reprise)', 1.3166);
INSERT INTO song VALUES(37,13,'A Day in the Life', 5.65);

-- Show list of tables
SHOW TABLES;

-- List all artists for each record label sorted by artist name
SELECT A.name,B.name FROM artist AS A INNER JOIN record_label AS B ON A.record_label_id = B.id WHERE A.record_label_id = B.id ORDER BY A.name ASC;

-- Which record labels have no artist?
SELECT R.name FROM record_label AS R LEFT JOIN artist AS A ON R.id = A.record_label_id WHERE A.record_label_id IS NULL;

-- List the number of songs per artist in descending order 
SELECT * FROM artist;
SELECT * FROM song;

SELECT A2.name,COUNT(*) AS no_of_songs FROM song AS S INNER JOIN album AS A1 ON S.album_id = A1.id INNER JOIN artist AS A2 ON A1.artist_id=A2.id GROUP BY A2.name ORDER BY COUNT(*) DESC;

-- Which artist or artists have recorded the most number of songs?
SELECT A2.name,COUNT(*) AS no_of_songs FROM song AS S INNER JOIN album AS A1 ON S.album_id = A1.id INNER JOIN artist AS A2 ON A1.artist_id=A2.id GROUP BY A2.name ORDER BY COUNT(*) DESC LIMIT 1;

-- Which artist have recorded least no of songs
SELECT A2.name,COUNT(*) AS no_of_songs FROM song AS S INNER JOIN album AS A1 ON S.album_id = A1.id INNER JOIN artist AS A2 ON A1.artist_id=A2.id GROUP BY A2.name ORDER BY COUNT(*) ASC LIMIT 1;

-- Which artist have recorded songs longer than 5 minutes and how many sogns was that?
SELECT A1.name ,COUNT(A1.name) AS total_count_of_songs FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id WHERE S.duration > 5.00 GROUP BY A1.name;

-- For each artist and album how many songs were less than 5 minutes long?
SELECT A1.name,A2.name, COUNT(S.name) AS no_of_songs FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id WHERE S.duration < 5.00 GROUP BY A1.name,A2.name;

-- In which year most songs were recorded
SELECT A2.year,COUNT(S.name) AS year_of_most_songs FROM album AS A2 INNER JOIN song AS S ON A2.id = S.album_id GROUP BY year ORDER BY COUNT(S.name) DESC;

-- List the artist song , year of top 5 longest recorded songs 
SELECT A1.name ,A2.name, S.name , A2.year , S.duration FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id ORDER BY S.duration DESC LIMIT 5;

-- No of albums recorded each year
SELECT year,COUNT(name) AS no_of_album FROM album GROUP BY year;

-- What is maximum number of albums recorded across all years
SELECT MAX(no_of_album) FROM 
(SELECT year,COUNT(name) AS no_of_album FROM album GROUP BY year) AS A;

-- In which year were most number of albums recorded and how many were recorded?
SELECT A2.year,COUNT(A2.name) AS no_of_Albums FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id GROUP BY A2.year ORDER BY COUNT(A2.name) DESC;

-- Duration of all songs recorded by each artist in descending order 
SELECT A1.name AS artist_name , SUM(S.duration) AS song_duration FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.ID = S.album_id GROUP BY A1.name ORDER BY SUM(S.duration) DESC;

-- For which artist,album there are no song less than 5 minutes long?
SELECT A1.name AS artist_name,A2.name AS album_name FROM artist AS A1 LEFT JOIN album AS A2 ON A1.id = A2.artist_id LEFT JOIN song AS S ON A2.id = S.album_id AND S.duration<5.00 WHERE S.name IS NULL;

--  Display a table of all artists, albums, songs and song duration all ordered in ascending order by artist, album and song  
SELECT A1.name AS artist_name,A2.name AS album_name,S.name AS song_name,S.duration AS song_duration FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id ORDER BY A1.name ASC,A2.name ASC,S.name ASC;

-- List the top 3 artists with the longest average song duration, in descending with longest average first.
SELECT A2.name AS aRtist_name, AVG(S.duration) AS avg_duration FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id =S.album_id GROUP BY A2.name ORDER BY AVG(S.duration) DESC LIMIT 3;

-- Total album length for all songs on the Beatles Sgt. Pepper's album - in minutes and seconds.
SELECT A1.name AS aritst_name,A2.name AS album_name , SUM(S.duration) AS duration_in_minutes,CEIL((SUM(S.duration) - FLOOR(SUM(S.duration)))*60) AS duration_in_seconds FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S on A2.id = S.album_id WHERE A1.name = 'The Beatles' AND A2.name LIKE '%Lonely Hearts Club Band'  GROUP BY A1.name , A2.name;

-- Which artists did not release an album during the decades of the 1980's and the 1990's?
SELECT DISTINCT A1.name AS artist_name FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id WHERE A2.year NOT BETWEEN 1980 AND 1990 ORDER BY A1.name ASC;

-- Which artists did release an album during the decades of the 1980's and the 1990's? 
SELECT DISTINCT A1.name AS artist_name FROM artist AS A1 INNER JOIN album AS A2 ON A1.id = A2.artist_id INNER JOIN song AS S ON A2.id = S.album_id WHERE A2.year BETWEEN 1980 AND 1990 ORDER BY A1.name ASC;