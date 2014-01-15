User Stories
============

## Critic

  1. As a critic I want to see a list of movies with a high rating for a particular year so that I can make comprehensive lists for my readers.

  Usage: ./eac movies by-rating 2000

  Acceptance Criteria:
    * Prints out movies in the year 2000 by rating

  2. As a critic I want to create a record of my rating of a movie so that I have a living record of my ratings.

  Usage: ./eac create "Title" "Genre" "Rating" "Year" "Length" "Budget" 

  Acceptance Criteria:
    * Creates a record of a movie with each piece of information
    * Requires first three arguments
    * Assigns a value of null to arguments 4-6 if none entered

  3. As a critic I want to view budgets for films so that I can assess the economic impact of the film.

  Usage: ./eac movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information (Including budget)
    * If no movie found it prints out similarly-named movies

  4. As a critic I want to be able to find MPAA ratings so that I can make lists of movies recommended for particular age groups.

  Usage: ./eac movies by-MPAA R 

  Acceptance Criteria:
    * Prints out a list of movies with that MPAA rating
    * Excludes unrated movies
    * No rating argument will return all movies with ratings sorted by G, PG, PG-13, R
    * Could add other options like year

  5. As a critic I want to categorize my ratings by genre to make it easier on my readers who only enjoy certain genres.

  Usage: ./eac movies by-genre Comedy

  Acceptance Criteria:
    * Prints out a list of movies with that genre
    * No genre argument will return all movies sorted by alphabetical genre
    * Could add other options like year

## Movie-goer

  1. As a movie-goer I want to find a list of movies that are rated highly so that I know what movies to watch.

  Usage: ./eac movies by-rating

  Acceptance Criteria:
    * Prints out a list of movies sorted by highest rated
    * Could add other options like year

  2. As a movie-goer I want to find movies that are appropriate for my family so that we can make the right choices for movie night.

  Usage: ./eac movies by-rating PG

  Acceptance Criteria:
    * Prints out a list of movies with that MPAA rating sorted by highest rating

  3. As a movie-goer I want to discover the best movies in my favorite genre.

  Usage: ./eac movies by-rating Comedy

  Acceptance Criteria:
    * Prints out a list of movies with that genre sorted by highest rating

  4. As a movie-goer I want to know how long a movie lasts so that I can make appropriate plans around the movie.

  Usage: ./eac movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information (Including length)
    * If no movie found it prints out similarly-named movies

  5. As a movie-goer I want to discover other information about my favorite movies for my own personal entertainment.

  Usage: ./eac movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information
    * If no movie found it prints out similarly-named movies