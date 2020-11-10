# MovieSearchApp
Movie Search app using navigation bars, tab bars, and collection views, and remote API

# Creative explain: 

## 1. Explore tab bar

The explore tab allow users to sort movies based on 4 criteria: Popularity, Date, Score (Vote Average) and Vote Count.

Also, there is a text field where user can enter the minimum number of vote count they want to filter out the unpopular movies.
Since there are a lot of unpopular movies with no image, 0 or 1 ratings, which really affect the result of the filter. For example, after sorting by score, user may encouter a movie with only 1 rating and score = 10 (that only rating gives the movie score 10). Thus, having the filter to choose only the movies with high vote count solve the problem. 
The movie with highest vote count is Inception with 25545 rating. 
The 500th highest vote count has about 5000 ratings.
The 1000th highest vote count has about 3000 ratings.

It is up to user to choose how many vote a movie should have to be displayed. The default value is 5000 vote counts.

## 2. Enhance user experience in movies search

### a. Seeing more than 20 movies (navigating between pages)
Seeing only 20 movies may not very sastifying for users. 1 pagl have 20 movies, and user can view the next or previous page (if there exists one) by pressing button Next Page and Previous Page. The associating next/previous 20 movies will show up. This applied to "Explore" tab also. 
** Please wait for a page to finish loading before navigating to another page. If you do not wait the image and the name will not be in correct position. (if you accidentally do so, then just navigate to another page and come back - you will see the movies get updated to the correct entries).
### b. Default page for movie recommendation
When user first launch the app, they will see a list of popular movies for recommendation. Of course, they can navigate to see more than 20 movies at these default page also 

## 3. Enhance user experience in favourite

### a. See movie details for favourite movies
User can tap in the table cell that holds the movie and see the movie's details (same as tapping on collection cell in movies search).

### b. Clear all favourite movies
There is a button clear in search bar where user can use to delete all favourite movies.

