# MovieSearchApp
Movie Search app using navigation bars, tab bars, and collection views, and remote API

# Basic functionality

A movie-searching app, which allows users to find information about movies. Data is pulled from The Movie Database’s (TMDb) API (http://www.themoviedb.org).  
- User can search for movies and see the results populated in a collection view.  
- Select one movie will pop up a new ViewController with more details about the movie.  
- User can add movie to favourite list.  
- Favourite movies are stored in user default.  

# Creative explain: 

## 1. Sort by tab bar

The sort by tab allow users to sort all movies based on 4 criteria: Popularity, Date, Score (Vote Average) and Vote Count.

Also, there is a text field where user can enter the minimum number of vote count they want to filter out the unpopular movies.
Since there are a lot of unpopular movies with for example no image or 0 or 1 ratings, which really affect the result of the filter. For example, after sorting by score, user may encouter a movie with only 1 rating and score = 10 (that only rating gives the movie score 10). Thus, having the option to filter the movies with high vote count only will allow user to see popular movies.

The movie with highest vote count is Inception with 25545 rating. 
The 500th highest vote count has about 5000 ratings.
The 1000th highest vote count has about 3000 ratings.

It is up to user to choose how many vote a movie should have to be displayed. The default value is 5000 vote counts.

## 2. Enhance user experience in movies search

### a. Seeing more than 20 movies (navigating between pages)
Seeing only 20 movies may not very sastifying for users. 1 page have 20 movies, and user can view the next or previous page (if there exists one) by pressing button Next Page and Previous Page. The associating next/previous 20 movies will show up. This applied to "sort by" tab also. 
** Please wait for a page to finish loading before navigating to another page. If you do not wait the image and the name will not be in correct position. (if you accidentally do so, then just navigate to another page and come back - you will see the movies get updated to the correct entries).
### b. Default page for movie recommendation
When user first launches the app, they will see a list of popular movies for recommendation. Of course, they can navigate to see more than 20 movies at these default page also 

## 3. Enhance user experience in favourite

### a. See movie details for favourite movies
User can tap in the table cell that holds the movie and see the movie's details (same as tapping on collection cell in movies search).

### b. Clear all favourite movies
There is a clear button in navigation bar that allows user to delete all favourite movies.


# Demo

## Movie search
![](demo/movie_search.png width="50")

## Favourite list
![](demo/favorite_list.png width="50")

## Movie details
![](demo/movie_detail.png width="50")

## Movie sort
![](demo/movies_sort.png width="50")
