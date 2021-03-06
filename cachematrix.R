## Matrix inversion is usually a costly computation 
## There may be some benefit to caching the inverse of a matrix rather than compute it repeatedly 
## (there are also alternatives to matrix inversion that we will not discuss here). 

## makeCacheMatrix contains a list containing a function to
#1. set the value of the matrix
#2. get the value of the matrix
#3. set the value of the mean
#4. get the value of the mean
makeCacheMatrix <- function(x = matrix()) {
	# initialize a local variable
	inversedMatrix <- NULL

	# set the matrix value
    set <- function(y) {
    	# set global variables if they dont exist
        x <<- y
        inversedMatrix <<- NULL
    }

    # get the matrix value
    get <- function() x

    # assign inverse of the matrix to local variable
    setinverse <- function(inversed) inversedMatrix <<- inversed

    # get the inverse from local variable
    getinverse <- function() inversedMatrix

    # return the list that contains the functions
    list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)
}


## Compute the inverse of the matrix returned by makeCacheMatrix. 
## If the inverse has already been calculated, 
## then the cachesolve should retrieve the inverse from the cache.

# This function assumes that the matrix is always invertible.
cacheSolve <- function(x, ...) {
	# retrieve the inverse from list
	inversedMatrix <- x$getinverse()

	# check if the inverse alredy exist
    if(!is.null(inversedMatrix)) { 
    	return(inversedMatrix)
    }

    # if inverse does not exist, get the matrix 
    mtrx <- x$get()

    # compute inverse
    inversedMatrix <- solve(mtrx)

    # set the inverse 
    x$setinverse(inversedMatrix)

    # return the inverse
    inversedMatrix
}


#> x <- diag(2,4)
#> x
#     [,1] [,2] [,3] [,4]
#[1,]    2    0    0    0
#[2,]    0    2    0    0
#[3,]    0    0    2    0
#[4,]    0    0    0    2
#> lst <- makeCacheMatrix(x)
#> cacheSolve(lst)
#     [,1] [,2] [,3] [,4]
#[1,]  0.5  0.0  0.0  0.0
#[2,]  0.0  0.5  0.0  0.0
#[3,]  0.0  0.0  0.5  0.0
#[4,]  0.0  0.0  0.0  0.5
#> solve(x)
#     [,1] [,2] [,3] [,4]
#[1,]  0.5  0.0  0.0  0.0
#[2,]  0.0  0.5  0.0  0.0
#[3,]  0.0  0.0  0.5  0.0
#[4,]  0.0  0.0  0.0  0.5
