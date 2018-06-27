CREATE TABLE album (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(128) NOT NULL,
    release_year INTEGER
);

CREATE TABLE artist (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE Track(
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   Title VARCHAR(128),
   AlbumId INTEGER NOT NULL,
   FOREIGN KEY (AlbumId) REFERENCES album(id));
                                          
CREATE TABLE artist_album(
   ArtistId INT NOT NULL,
   AlbumId  INT NOT NULL,
   FOREIGN KEY (ArtistId) REFERENCES artist(id),
   FOREIGN KEY (AlbumId) REFERENCES album(id));
                                          
/* Show all albums. */
select * from album;
/* Show all albums made between 1975 and 1990. */                                          
select * from album where release_year >= 1975 and release_year <= 1990;
 /* Show all albums whose names start with Super D */                                         
select * from album where title like 'Super D%';
/* Show all albums that have no release year. */                                          
SELECT * FROM album WHERE release_year IS NULL;
/* Show all track titles from Super Funky Album. */                                          
select Title from Track where AlbumId in (select id from album where title = 'Super Funky Album');
/* Same query as above, but rename the column from title to Track_Title in the output. */                                          
select Title as Track_Title from Track where AlbumId in (select id from album where title = 'Super Funky Album');
/* Select all album titles by Han Solo. */                                          
select Title from album where id in(select AlbumId from artist_album where ArtistId in (select id from artist where name = 'Han Solo'));select avg(release_year) from album;
/* Select the average year all albums were released. */
SELECT AVG(release_year) FROM album;
/* Select the average year all albums by Leia and the Ewoks were released. */                                                                                        
select avg(release_year) from album where id in(select AlbumId from artist_album where ArtistId in (select id from artist where name = 'Leia and the Ewoks'));
/* Select the number of artists. */
select count(distinct(id)) from artist;
/* Select the number of tracks on Super Dubstep Album. */
select count(distinct(id)) from Track where AlbumId in (select id from album where title = 'Super Dubstep Album'); 
                      
CREATE TABLE author (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(128) NOT NULL
);

CREATE TABLE note (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    content VARCHAR(256) NOT NULL,
    timestamp DEFAULT CURRENT_TIMESTAMP,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (author_id) REFERENCES author(id)
);

CREATE TABLE authors_notes (
    note_id INTEGER NOT NULL,
    author_id INTEGER NOT NULL,
    FOREIGN KEY (note_id) REFERENCES note(id),
    FOREIGN KEY (author_id) REFERENCES author(id)
);

/* Insert authors to the author table. */
INSERT INTO author (name) VALUES ("Ainz Ooal Gown");
INSERT INTO author (name) VALUES ("Mare Bello Fiore");
INSERT INTO author (name) VALUES ("Aura Bella Fiora");
INSERT INTO author (name) VALUES ("Demiurge");
INSERT INTO author (name) VALUES ("Pandora's Actor");

/* Insert notes to the note table. */
INSERT INTO note (content, author_id) VALUES ("Umu.", 1);
INSERT INTO note (content, author_id) VALUES ("I, I would rather not have to meet intruders...they, they're scary...", 2);
INSERT INTO note (content, author_id) VALUES ("...I'm only 76, and I've got lots more time to grow, unlike an undead with no future like you.", 3);
INSERT INTO note (content, author_id) VALUES ("Perfume is essential for ladies? Isn't it just for stinky people?", 3);
INSERT INTO note (content, author_id) VALUES ("This is still too irrational, naive; a purely emotional judgment.", 4);
INSERT INTO note (content, author_id) VALUES ("Reading the movements of a slightly-above-average intellect that imagines himself a genius is easier than trying to predict the actions of a complete moron.", 4);
INSERT INTO note (content, author_id) VALUES ("Indeed! I burst with energy every day!", 5);

/* Select all notes by an author's name. */
SELECT * FROM note 
WHERE author_id = (SELECT id FROM author
                   WHERE name = "Demiurge");

/* Select author for a particular note by note ID. */
SELECT * FROM author
WHERE id = (SELECT author_id FROM note
            WHERE id = 3);

/* Select the names of all the authors along with the number of notes they each have. */
SELECT name, Count(note_id)
FROM authors_notes
INNER JOIN author on authors_notes.author_id = author.id
group by author_id;

/* Delete authors from the author table. */
DELETE FROM author
WHERE name = ("Ainz Ooal Gown"); 
