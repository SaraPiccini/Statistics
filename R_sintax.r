print("Hello World!")

5 + 5 # addition
5 - 5 # subtraction
5 * 2 # multiplication
5 / 2 # division (and addition)
5^2 # exponentiation, also "**" works, e.g. 2**5
5%%2 # modulo
5%/%2 # integer division

# This is a comment
1 + 1 # this is a comment as well

x <- 42 # assignment and variable creation
x # print the variable content
x <- 21 # reassign the variable
x # check the new values

my_apples <- 5
my_apples
my_oranges <- 6
my_apples + my_oranges # sum two variables
my_fruit <- my_apples + my_oranges
my_fruit

# What if a want to remove a variable?
rm(x)
x # now x is missing!

my_numeric <- 42 # numeric variable
my_integer <- 42L # integer variable
my_double <- 42.24 # numeric variable
my_character <- "universe" # character variable
my_logical <- FALSE # logical or boolean variable (n.b. T = TRUE; F = FALSE)

class(my_numeric) # check the variable type, using one of your first functions!
class(my_character)
class(my_logical)

numeric_vector <- c(1, 10, 49) # create a numeric vector
numeric_vector
character_vector <- c("a", "b", "c") # create a character vector
character_vector
character_vector <- c("a", "b", "c", my_numeric)
character_vector
boolean_vector <- c(TRUE, FALSE, T) # create a boolean vector
boolean_vector
apples_vector <- c(40, 50, 20, 120, 240)
apples_vector
oranges_vector <-  c(24, 50, 100, 350, 10)
oranges_vector
my_fruit_vector <- my_oranges_vector + my_apples_vector # if both vectors are the same size, the operation is "paired"
apples_vector <- c(40, 50, 20, 120)
oranges_vector <-  c(24, 50)

my_fruit_vector <- apples_vector + oranges_vector # if the vectors have different lengths, the shortest one is "recycled" until the longest ones ends (e.g. for a vector of length four and a vector of length two, it would be: first of A with first of B, second of A with second of B, third of A with first of B, fourth of A with second of B)
my_fruit_vector + 50 # in this case the operation is applied the same way to all vector's elements

1:10 # sequence of integer numbers from one to ten
10:1 # sequence of integer numbers from ten to one

rep(c("a", "b", "c"), 2) # this repeats the whole vector two times
rep(c("a", "b", "c"), times = 2) # this is the same as the above command
rep(c("a", "b", "c"), each = 2) # this repeats each vectors element twice before moving onto the next one

### How to get help in R ###

?mean
help("sum")

### Another way to create vectors (numeric only) ###

seq(1, 10, by = 1) # note that it's equal to "1:10"
seq(1, 10, by = 2) # note that the ending point "is not reached" as the sequence stops at 9, indeed 10 would be out of the sequence as 9 -> 10 has a step of 1 and not 2, whereas 11 is out of the given interval

### Other functions to work on vectors)

apples_vector <- c(20, 50, 30, 40, 100)
oranges_vector <- c(70, 70, 50, 20, 80)

names(apples_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday") # assign names to vector elements
apples_vector
names(oranges_vector) <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")
days_vector <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday")

names(apples_vector) <-  days_vector
apples_vector
names(oranges_vector) <- days_vector
oranges_vector

apples_vector + oranges_vector # note that names are "inherited" from apples_vector and oranges_vector

typeof(oranges_vector) # you can check the "type" of a given object with typeof (note that the given "classes" are slightly different to those printed by class() function)
is.numeric(oranges_vector) # with the is.___ functions you can test the types of objects
is.character(oranges_vector)
is.double(oranges_vector)
is.integer(oranges_vector)
as.character(oranges_vector) # with the as.___ functions you coerce data types into other data types
as.logical(oranges_vector)

typeof(days_vector)
is.character(days_vector)
is.logical(days_vector)
is.vector(days_vector)
as.logical(days_vector)
as.numeric(days_vector)

logical_vector <- c(T, T, F)
typeof(logical_vector)
is.logical(logical_vector)
is.numeric(logical_vector)
as.numeric(logical_vector)
as.character(logical_vector)

typeof(c(1.1, 2.3, 4))
length(oranges_vector)
length(1:3)

total_daily <- apples_vector + oranges_vector # sum two vectors
total_daily
total_apples <- sum(apples_vector) # sum the elements of a vector
total_apples
total_oranges <-  sum(oranges_vector)
total_week <- apples_vector + oranges_vector
total_week
total_apples > total_oranges # > major than

### Vectors indexing ###

apples_wednesday <- apples_vector["Wednesday"] # select elements by name
apples_wednesday
apples_vector[2:4] # select element by index/position
apples_vector[c("Monday", "Tuesday")]
selection_vector <- apples_vector > 100
selection_vector
apples_vector[selection_vector]
apples_vector[apples_vector < 100] # "<" means "minor than"
apples_vector[apples_vector < 100] # ">" means "minor than"
apples_vector[apples_vector == 120] # "==" means "is equal"
apples_vector[apples_vector != 120] # "!=" means "is not equal"
# "<=" means "minor or equal than"
# ">=" means "major or equal than"

### Matrices ###

matrix(1:9, nrow = 3) # your first matrix!
matrix(1:9, byrow = TRUE, nrow = 3) # by default byrow = FALSE, therefore the matrix is filled column-wise, by specifying byrow = TRUE the matrix is filled row-wise

# here we create our very first community matrix! A community matrix contains occurrences of species within sites. Typically, species are represented by columns and sites by rows. The value at the intersection between a species and a site tells us if the species was found at the site and in certain cases also the abundance of the species at the site
# in this case we create a matrix where values represent the number of individuals of a given species found in a given site (i.e. abundances). If we would have had only 1s and 0s, we would have called it a presence/absence community matrix (where 1 means we found the species and 0 means we didn't found the species)
garden <- c(10, 2) # in our garden site we found 10 individuals of the first species and two individuals of the second species
forest <- c(8, 3) # here we found 8 individuals of the first species and 3 of the second species
hedgerow <- c(1, 12) # see above
community_matrix <- matrix(c(garden, forest, hedgerow), nrow = 3, byrow = TRUE) # here we build our community matrix by providing a vector made by combining our previous 3 vectors and filling the matrix row-wise -> each row is a site and has two fields (i.e. columns)
species <- c("Parus major", "Erithacus rubecula") # here we create a vector for columns' names (i.e. species' names)
sites <- c("Garden", "Forest", "Hedgerow") # vector for rows' names (i.e. sites' names)
colnames(community_matrix) <- species # we assign names to the columns
rownames(community_matrix) <- sites # the same with rows
community_matrix # our nicely formatted community matrix

# we can also expand our matrix by "binding" other vectors or matrices to our original matrix

passer <- c(15, 2, 5) # we create a vector for another species we sampled but we previously forgot to add to the matrix
community_matrix <- cbind(community_matrix, passer) # here we add (bind) a new column (cbind -> column bind)
park <- c(10, 1, 8) # we also want to add another sampling site where we collected data on the three species we're studying
community_matrix <- rbind(community_matrix, park) # here we add a new row (rbind -> row bind)
community_matrix

colnames(community_matrix)[3] <- "Passer domesticus" # by using vector indexing we only modify the third column name
rownames(community_matrix)[4] <- "Park" # as above with the fourth row name
community_matrix

### Matrices ###

matrix(1:9, byrow = TRUE, nrow = 3) # default is byrow = FALSE

garden <- c(10, 2)
forest <- c(8, 3)
hedgerow <- c(1, 12)
community_matrix <- matrix(c(garden, forest, hedgerow), nrow = 3, byrow = TRUE)
species <- c("Parus major", "Erithacus rubecula")
sites <- c("Garden", "Forest", "Hedgerow")
colnames(community_matrix) <- species
rownames(community_matrix) <- sites
community_matrix

passer <- c(15, 2, 5)
community_matrix <- cbind(community_matrix, passer)
park <- c(10, 1, 8)
community_matrix <- rbind(community_matrix, park)
community_matrix

colnames(community_matrix)[3] <- "Passer domesticus"
rownames(community_matrix)[4] <- "Park"
community_matrix

dim(community_matrix) # check matrix's dimensions, first comes the number of rows, second comes the number of columns
nrow(community_matrix) # check the number of rows
ncol(community_matrix] # check the number of columns

colSums(community_matrix) # calculate column sums (this and the latter works for matrices, whereas for vectors you can use the sum() function)
rowSums(community_matrix) # calculate row sums

community_matrix + 2
community_matrix * 2 # note that this is NOT the standard matrix multiplications for which you should use %*% in R

community_matrix[, "Parus major"] # select the "Parus major" row
community_matrix["Park", ] # select the "Park" row
community_matrix[1, ] # this subset the first row of the matrix
community_matrix[, 2] # second column (note that as for the dim() function, the first number always refers to rows and the second to columns)
community_matrix[, 2, drop = FALSE] # keep the matrix structure by using the "drop = FALSE" argument
# indeed you can cross check it
class(community_matrix[, 2])
class(community_matrix[, 2, drop = FALSE])

community_matrix[2, 3] # select the element found at the intersection between the second row and the third column
community_matrix[1:2, ] # select the first two rows
community_matrix[, 2:ncol(community_matrix)] # select the second to the last columns by taking advantage of the ncol() function


### Factors ###

plants_vector <- c("Tree", "Grass", "Forb", "Grass", "Tree") # create a vector of names (or labels)
factor_plants_vector <- factor(plants_vector) # create the actual factor from the character vector
factor_plants_vector

temperature_vector <- c("High", "Low", "High","Low", "Medium")
factor_temperature_vector <- factor(temperature_vector, order = TRUE, levels = c("Low", "Medium", "High")) # note here we specified that the factor is an ordered one (factors can be ordered or not), as we specified it is ordered we have to specify
factor_temperature_vector
summary(factor_temperature_vector) # calculate the frequency of each element (i.e. a summary statistic, note that the summary() function can be used with several other data structures and objects)

substrate_vector <- c("L", "S", "S", "L", "L")
factor_substrate_vector <- factor(substrate_vector)
levels(factor_substrate_vector) <- c("Limestone", "Siliceous") # here we assign factor levels by means of levels() function
summary(factor_substrate_vector)

### Data frames ###

# the line below creates a 6 rows and 5 columns dataframe, note that different columns may contain different data types but a column can have only one data type. Moreover, all columns must have the same length
dat <- data.frame(
	id = 1:6,
	name = c("Eokochia saxicola", "Cytisus aeolicus", "Anthemis aeolica", "Centaurea aeolica", "Silene hicesiae", "Genista tyrrhena"),
	has_legumes = c(F, T, F, F, F, T),
	population_size = c(50, 2000, 5000, 10000, 200, 3000),
	growth_form = factor(c("Herb", "Tree", "Herb", "Shrub", "Herb", "Tree"))
	)

### Data frames ###

dat <- data.frame(
	id = 1:6,
	name = c("Eokochia saxicola", "Cytisus aeolicus", "Anthemis aeolica", "Centaurea aeolica", "Silene hicesiae", "Genista tyrrhena"),
	has_legumes = c(F, T, F, F, F, T),
	population_size = c(50, 2000, 5000, 10000, 200, 3000),
	growth_form = factor(c("Herb", "Tree", "Herb", "Shrub", "Herb", "Tree"))
	)

dat
dat$id # extracts a vector
dat[2, 3] # extracts a vector
dat[2, 3, drop = FALSE] # extracts a data frame thanks to the "drop = FALSE" argument
dat[, 3] # extracts a vector
dat[, 3, drop = FALSE] # extracts a data frame, this case and the three above explain also how a matrix behave, e.g. if you have a matrix "m <- matrix(1:9, ncol = 3)" if you do "m[2, 3]" or "m[2, ]" or "m[, 3]" you will end up with vectors, however if you do "m[2, 3, drop = F]" or "m[2, , drop = FALSE]" or "m[, 3, drop = FALSE]" you will end with data frames
dat[1, ] # however, even if you only extract just one row, you end up with a data frame, as different columns can host different data types, hence even a single row cannot be converted to a vector for sure without forcing coercion (unless all the columns host the same data type)
dat[2, 3:4] # extracts a data frame
dat[2:3, ] # extracts a data frame
dat["id"] # extracts a data frame
dat[["id"]] # extracts a vector	
class(dat["id"]) # in this way you can cross check the structure of your output
class(dat[["id"]]) # as above, AAA try to experiment with elements/components indexing/subsetting on differnt data types and see how the outputs change
dat[c("id", "name")]
dat[, c("id", "name")]
dat[1:2, c("id", "name")]
dat[dat$has_legumes == T, ]
dat[dat$population_size < 3000, ]
dat$growth_form <- NULL # by assigning NULL to a column you can erase it, this is equivalent to "dat <- dat[, -5]" and "dat <- dat[-5]"
dat


str(dat) # check the structure of dat (you can use dat on different data structure, not only data frames!)
summary(dat) # check summary statistics for each column
dim(dat) # check the number of rows and columns (as for the dim() function applied to a matrix)

class(dat)

cbind(dat, 6:1) # you can add a new column to a data frame with cbind
cbind(dat, id.2 = 6:1) # the same as above but providing a name to our new column
dat$id.2 <- 6:1 # this brings the same result as the previous line of code
new_data <- data.frame(
	id = 7,
	name = "Limonium minutiflorum",
	has_legumes = F,
	population_size = 2000,
	) # if you want to add one or more rows you have to build a data frame before with the same number of columns of the other data frame, their names and types have to match as well
rbind(dat, new_data) # now you can use rbind on the two "matched" data frames

### Lists ###

vec <- 1:10
mat <- matrix(1:9, ncol = 3)
dat <- mtcars[1:10, ]
my_list <- list(vec, mat, dat) # here we create a list providing the components as arguments of the list function
my_list
my_list <- list(my_vector = vec, my_matrix = mat, my_df = dat) # in this way you can create a list with named components
my_list
my_list[["my_vector"]] # to index a component of a list you need to use "[[" rather than "[", as with other data structures you can refer to it with its name or its index, also beware that when using "[[" you can extract only one component at timem
my_list[[1]]
my_list$my_vector
my_list[["my_vector"]][3] # to index an element of a component you can chain "[[" with "[", here indeed we first extract "my_vector" component and then we extract its third element
my_list[[1]][3]
my_list[["my_vector"]] <- 10:1 # in this way you can update a component or create one from scratch (to create one from scratch the new component has to have a name not used before, you can also do it with components' indices, e.g. "my_list[[4]] <- 1:2")
my_list
my_list[[3]] <- NULL # in this way you can remove a component from a list
my_list

my_list$my_other_vector <- 1:100
my_list

my_new_list <- list("A", 1:3, c(T, F, F), mat, dat)
names(my_new_list) <- c("First letter", "Integer vector", "Some logical", "A matrix...", "...and a data frame") # here you can name a list's components by using the names() function as you did with vectors
my_new_list

c(my_list, my_new_list)
str(c(my_list, my_new_list)) # notice that the list has been merged, i.e. the components of the list are now the components of a list
list(my_list, my_new_list) # notice you have now a list with two components, i.e. the two lists we provided to the list function, each composed by its components

length(my_list)

list(1, 2, 3)
unlist(list(1, 2, 3))

### The Null Object ###

NULL #NULL represents the null object in R. NULL is used mainly to represent the lists (and vectors) with zero length, and is often returned by expressions and functions whose value is undefined.
class(NULL)
typeof(NULL)
as.null(1:3)
is.null(NULL)
is.null(1:3)
is.null(pairlist())
is.null(vector())
as.null(1:3)
length(NULL)

### Other special values ###

# Missing values
NA # meaning not applicable or not available
class(NA)
typeof(NA)
vec <- c(1, NA, 4, 6, 10)
is.na(vec)
10 + NA
sqrt(NA) # sqrt(n) function calculates the square root of n (it is equivalent to "n^(1/2)")
sum(1:3) # this is the same as "1 + 2 + 3"
sum(c(1, 2, 3, NA)) # this is the same as "1 + 2 + 3 + NA"
sum(c(1, 2, 3, NA), na.rm = T) # this remove the NA value(s) before doing the sum of all values (indeed "na.rm" means "NA remove")
na.omit(c(1, 2, 3, NA))
FALSE & NA # special case, due to every state of NA matched with "FALSE &" will produce FALSE
TRUE | NA # special case, due to every state of NA matched with "TRUE |" will produce TRUE
length(NA)

# Not a number
NaN
class(NaN)
typeof(NaN)
0/0
0/0 == NaN
is.nan(0/0)
is.na(0/0)
length(NaN)

# Infinite
Inf
-Inf
class(Inf)
typeof(-Inf)
1/0
-1/0
length(Inf)

### Installing and loading packages ###
# always remember, you install a package once but load it every session (and the functions are install.package() and library(), respectively)

install.package("swirl")
library(swirl)
rm(list = ls())
swirl()

install.package("vegan")
library(vegan)
vignette(package = "vegan")
vignette("intro-vegan")
vignette("diversity-vegan")

# https://rstudio.github.io/learnr/examples.html
# https://rstudio.cloud/learn/primers
# https://www.dataquest.io/ here you can sign up for free and access the basic tutorials (advanced tutorials require paying, but the most basic are free! hence, it could be helpful to review)
# https://intro2r.com/ nice free book introducing R programming made by biostatisticians and ecoligists

### Pipes ###

# rather than putting one function call inside the other, or storing intermediate variables/objects, you can "pipe" something into a function and then "pipe" its output inside another function, and so on

# below an example showing you the logic of a pipe

x <- 42

log(x) # calculate the logarithm of x (by default it's the natural logarithm, but you can do it otherwise by specifying other arguments or using related functions, see ?log)

x |> log() # this is the same as the above command, although it is not much useful this way, it becomes handy when you have 2 or more passages you like to do in just one go, see the below example

# now let's calculate the logarithm of x and then the square root of the logarithm

sqrt(log(x)) # this is one way and it's achieved by nesting functions

log_x <- log(x) # this is another way which requires to (at least temporarily) store a variable and reused it in a second line of code, it's more readable than the above but uses more memory and typing
sqrt(log_x)

x |> log() |> sqrt() # this is the same, doesn't require storing intermediates and it's more readable than nesting functions as we can read the actual order of the functions from left to right rather than from the inside to the outside


