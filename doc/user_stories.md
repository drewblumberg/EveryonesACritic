User Stories
============

## Critic

1. As a critic I want to see a list of movies with a high rating for a particular year so that I can make comprehensive lists for my readers.

  Usage: "./eac list movie --order aggregateRating --year 2000"

  Acceptance Criteria:
    * Prints out movies in the year 2000 by rating

2. As a critic I want to create a record of a movie in the database so I can make reviews against it.

  Usage: ./eac create movie Anchorman2 --genre comedy --year 2013 --length 100 --budget 20000000 --mpaa R

  Acceptance Criteria:
    * Creates a record of a movie with each piece of information
    * If a movie with the title already exists, deny creation of movie.

3. As a critic I want to create a record of a rating in the database so I can make multiple reviews for a movie if necessary.

  Usage: ./eac create review "Title" --review review_score

  Acceptance Criteria:
    * Creates a record of a rating for a movie
    * If no title exists display like-named movies

4. As a critic I want to view budgets for films so that I can assess the economic impact of the film.

  Usage: ./eac search movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information (Including budget)
    * If no movie found it prints out similarly-named movies
    * Multiple records can be created for the same movie

5. As a critic I want to be able to find MPAA ratings so that I can make lists of movies recommended for particular age groups.

  Usage: ./eac list movies --mpaa R 

  Acceptance Criteria:
    * Prints out a list of movies with that MPAA rating
    * Excludes unrated movies
    * No rating argument will return all movies with ratings sorted by G, PG, PG-13, R
    * Could add other options like year

6. As a critic I want to be able to delete my ratings if I make an error in logging a film so that I can be as accurate as possible.

  Usage: ./eac delete review "Title" --id id 

  Acceptance Criteria:
    * Deletes the rating record for a movie with that title

## Movie-goer

1. As a movie-goer I want to find a list of movies that are rated highly so that I know what movies to watch.

  Usage: ./eac list movie --order aggregateRating

  Acceptance Criteria:
    * Prints out a list of movies sorted by highest rated
    * Could add other options like year

2. As a movie-goer I want to find movies that are appropriate for my family so that we can make the right choices for movie night.

  Usage: ./eac list movie --mpaa PG

  Acceptance Criteria:
    * Prints out a list of movies with that MPAA rating sorted by highest rating


3. As a movie-goer I want to know how long a movie lasts so that I can make appropriate plans around the movie.

  Usage: ./eac search movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information (Including length)
    * If no movie found it prints out similarly-named movies

4. As a movie-goer I want to discover other information about my favorite movies for my own personal entertainment.

  Usage: ./eac search movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information
    * If no movie found it prints out similarly-named movies