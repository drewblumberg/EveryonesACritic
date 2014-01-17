User Stories
============

## Critic

1. As a critic I want to see a list of movies with a high rating for a particular year so that I can make comprehensive lists for my readers.

  Usage: ./eac movies by-rating 2000

  Acceptance Criteria:
    * Prints out movies in the year 2000 by rating

2. As a critic I want to create a record of a movie in the database so I can make reviews against it.

  Usage: ./eac create movie "Title" "Genre" "Year" "Length" "Budget" 

  Acceptance Criteria:
    * Creates a record of a movie with each piece of information
    * If a movie with the title already exists, deny creation of movie.

3. As a critic I want to create a record of a rating in the database so I can make multiple reviews for a movie if necessary.

  Usage: ./eac create rating "Title" "Rating"

  Acceptance Criteria:
    * Creates a record of a rating for a movie
    * If no title exists display like-named movies

4. As a critic I want to view budgets for films so that I can assess the economic impact of the film.

  Usage: ./eac movie "Title"

  Acceptance Criteria:
    * Prints out movie with all information (Including budget)
    * If no movie found it prints out similarly-named movies
    * Multiple records can be created for the same movie

5. As a critic I want to be able to find MPAA ratings so that I can make lists of movies recommended for particular age groups.

  Usage: ./eac movies by-MPAA R 

  Acceptance Criteria:
    * Prints out a list of movies with that MPAA rating
    * Excludes unrated movies
    * No rating argument will return all movies with ratings sorted by G, PG, PG-13, R
    * Could add other options like year

6. As a critic I want to categorize my ratings by genre to make it easier on my readers who only enjoy certain genres.

  Usage: ./eac movies by-genre Comedy

  Acceptance Criteria:
    * Prints out a list of movies with that genre
    * No genre argument will return all movies sorted by alphabetical genre
    * Could add other options like year

7. As a critic I want to be able to update my ratings if I make an error in logging a film so that I can be as accurate as possible.

  Usage: ./eac update rating "Title" "new_rating" [id: optional] 

  Acceptance Criteria:
    * Updates the rating for a movie with that title
    * If multiple results for that movie, supply ratingsID for each entry

8. As a critic I want to be able to delete my ratings if I make an error in logging a film so that I can be as accurate as possible.

  Usage: ./eac delete rating "Title" [id: optional] 

  Acceptance Criteria:
    * Deletes the rating record for a movie with that title
    * If multiple results for that movie, supply ratingsID for each entry

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