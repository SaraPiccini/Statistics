### Writing functions ###

add_two <- function(x) {
	x_plus_two <- x + 2
	return(x_plus_two)
}
	
add_two(10)

cheer_me <- function(your_name) {
	cheer_string <- paste("Hello", your_name, sep = " ")
	print(cheer_string)
}

cheer_me("Piero")


# more on creating your functions at https://swcarpentry.github.io/r-novice-inflammation/02-func-R/

### Build your first R projects ###
# you can check https://r4ds.had.co.nz/workflow-projects.html
# create a project folder with a known position and inside create a subfolder called "data", inside of data you should put "dune.txt" and "dune_env.csv", beware that to correctly import the two datasets with the following lines the names of the files must be exactly "dune.txt" and "dune_env.csv"

### Import data ###

dune <- read.table("data/dune.txt")
dune.env <- read.csv("data/dune_env.csv")

# you can find these same datasets in vegan
# library(vegan)
# data(dune)
# data(dune.env)
# ?dune

### Explore data ###

?dune
str(dune) # also dim(dune)
str(dune.env) # also dim(dune.env)

# note that none of the columns within dune.env are factors, but they should (you can check it by "?dune" after calling the vegan package -> "library(vegan)")! We can fix this by using the factor function

dune.env$Management <- factor(dune.env$Management)
dune.env$Moisture <- factor(dune.env$Moisture, ordered = T)
dune.env$Manure <- factor(dune.env$Manure, ordered = T)
dune.env$Use <- factor(dune.env$Use, ordered = T, levels = c("Hayfield", "Haypastu", "Pasture"))
str(dune.env)

### exercises at https://www.w3schools.com/r/r_exercises.asp

### For loops - An iteration technique ###

for (i in 1:10) {
  print(i)
}

sr <- vector()
for (i in 1:nrow(dune)) {
  sr[i] <- sum(dune[i, ] > 0)
}
sr

calculate_sr <- function(df) {
  sr <- vector()
  for (i in 1:nrow(df)) {
    sr[i] <- sum(df[i, ] > 0)
  }
  return(sr)
}

calculate_sr(dune)

### Other examples not shown in class ###

week <- c('Sunday',
          'Monday',
          'Tuesday',
          'Wednesday',
          'Thursday',
          'Friday',
          'Saturday')
for (day in week) {
	print(day)
}

for (i in 1:10) {
  cat(i, "\n")
} # which is the difference between print() and cat()?


num <- 0
for(i in 1:3) {
  num <- num + 5
} # a loop to multiply 5 by 3 (not actually helpful as (5*3) is faster by almost an order of magnitude)


simb <- "*"
for(i in 1:5) {
  cat(simb)
  cat("\n")
  simb <- paste(simb, "*", sep = "")
} # a loop to print a right triangle whose height is 5 lines and is made by "*"


tri <- function(height, symbol) {
  simb <- symbol
  for(i in 1:height) {
    cat(simb)
    cat("\n")
    simb <- paste(simb, symbol, sep = "")
  }
} # a function taking advantage of a for loop to print a right triangle, the height and the symbol are provided by the user as function arguments


tri <- function(height = 5, symbol = "-") {
  simb <- symbol
  for(i in 1:height) {
    cat(simb)
    cat("\n")
    simb <- paste(simb, symbol, sep = "")
  }
} # the same as above with default values (as all default values, the user can override them, by specifying different values inside the function call)

# more on loops at https://swcarpentry.github.io/r-novice-inflammation/15-supp-loops-in-depth/index.html
# also here https://www.geeksforgeeks.org/loops-in-r-for-while-repeat/



### Back to our analysis ###

# First let's reload and fix our datasets (from the following line to the third str(dune.env))

library(vegan)

dune <- read.table("data/dune.txt")
dune.env <- read.csv("data/dune_env.csv",
                     stringsAsFactors = TRUE)

str(dune)
str(dune.env)

?dune

dune.env$Moisture <- factor(dune.env$Moisture, ordered = T)
dune.env$Manure <- factor(dune.env$Manure, ordered = T)
str(dune.env)

dune.env$Use <- factor(dune.env$Use, ordered = T, levels = c("Hayfield", "Haypastu", "Pasture"))
str(dune.env)

# Let's restart from here

summary(dune.env)

hist(dune.env$A1)
hist(dune.env$A1,
     xlab = "Thickness of soil A1 horizon (cm)",
     main = "",
     breaks = 10)

counts <- table(dune.env$Management)
counts
barplot(counts, 
        xlab = "Management Type")
# also barplot(table(dune.env$Management))

counts <- table(dune.env$Manure, 
                dune.env$Management)
counts
barplot(counts,
        main = "Plot Distribution by Manure and Management",
        xlab = "Management Type",
        ylab = "Manure Quantity",
        legend = rownames(counts),
        xlim = c(0, 6))
prop.table(counts)
prop.table(counts, 1)
round(prop.table(counts, 1), 2)
round(prop.table(counts, 2), 2)

boxplot(dune.env$A1 ~ dune.env$Use,
        xlab = "Use Type",
        ylab = "Thickness of soil A1 horizon (cm)")

specnumber(dune)
dune.env$sr <- specnumber(dune)
boxplot(sr ~ Management,
	data = dune.env)

### Conditionals ###

x <- 100
if(x > 10) {
	print(paste(x, "is greater than 10"))
}

x <- 5
if(x > 10) {
	print(paste(x, "is greater than 10"))
} else {
	print(paste(x, "is less than 10"))
}

is_odd <- function(x) {
	if(x %% 2 == 1) {
		print(TRUE)
	} else {
		print(FALSE)
	}
}

### Resuming from last lesson ###

library(vegan)

data("dune")
data("dune.env")

sr <- specnumber(dune)

dune.env$sr <- sr

boxplot(dune.env$sr ~ dune.env$Management)

boxplot(sr ~ Management,
	data = dune.env,
	xlab = "Use Type",
        ylab = "Thickness of soil A1 horizon (cm)")

plot(sr ~ A1,
     data = dune.env,
     xlab = "Thickness of soil A1 horizon (cm)",
     ylab = "Species richness")


### Export graphs ###

# Beware we're goind to export outputs to a new subfolder called "outputs"

dir.create("outputs") # in this way you can create your "outputs" subfolder inside your project folder directly in R, otherwise you can navigate to your project folder outside of R/RStudio e and manually create the folder

# you can erase the folder in R as well by running the following command: unlink("outputs", recursive = TRUE)

plot(sr ~ A1,
     data = dune.env,
     xlab = "Thickness of soil A1 horizon (cm)",
     ylab = "Species richness")

png("outputs/sr_vs_a1.png", width = 350, height = 350)
plot(sr ~ A1,
     data = dune.env,
     xlab = "Thickness of soil A1 horizon (cm)",
     ylab = "Species richness")
dev.off()


### Export data ###

dune_env_head <- head(dune.env)
write.table(dune_env_head,
            "outputs/dune_env_head.txt")

dune_complete <- cbind(dune.env,
                     dune)
write.csv(dune_complete, "outputs/dune_complete.csv", row.names = F)


### Transform the community matrix (with abundances now) into presence absence ###

dune_pa <- decostand(dune,
		      method = "pa") # note that decostand is a function from vegan, hence you need to load vegan to use it
dune_pa


### Association measures ###

specnumber(dune, MARGIN = 2) # MARGIN = 2 enables us to calculate species frequencies

species_by_use <- aggregate(dune_pa[c("Scorautu", "Trifrepe")],
          by = list(dune.env$Use),
          FUN = "sum") # here we calculate the frequencies of the two most common species across different Use categories

chisq.test(species_by_use[, -1]) # here we test if the two species are indipendently distributed across different Use categories. The null hypothesis is that there are no difference, as the p-value much larger than .01 or .05 (actually, it's almost 1!), we can't refuse the null hypothesis

install.packages("cramer")

library(cramer)

cramer.test(species_by_use[, 2],
	    [, 3])
	    
cor.test(dune.env$sr,
	 dune.env$A1)	    
	    
### How to export graphs from R http://www.sthda.com/english/wiki/creating-and-saving-graphs-r-base-graphs https://www.datamentor.io/r-programming/saving-plot/ https://intro2r.com/export-plots.html
### How to open csv in Excel https://www.copytrans.net/support/how-to-open-a-csv-file-in-excel/

library(vegan)
data(dune)
data(dune.env)

dune.env$sr <- specnumber(dune)

### Association measures ###

mat <- matrix((c(2, 9, 8, 1)), ncol = 2) # here we create a matrix with frequencies of two species in two different habitats
colnames(mat) <- c("sp1", "sp2")
rownames(mat) <- c("habitat1", "habitat2")
mat
chisq.test(mat) # here we test if the two species are independently ditributed (p < .05 -> independent distribution)

# The same as above calculated on the two most frequent species of dune dataset, across the different "Use" categories

specnumber(dune, MARGIN = 2) # MARGIN = 2 enables us to calculate species frequencies

species_by_use <- aggregate(dune_pa[c("Scorautu", "Trifrepe")],
          by = list(dune.env$Use),
          FUN = "sum") # here we calculate the frequencies of the two most common species across different Use categories

chisq.test(species_by_use[, -1]) # here we test if the two species are indipendently distributed across different Use categories. The null hypothesis is that there are no difference, as the p-value much larger than .01 or .05 (actually, it's almost 1!), we can't refuse the null hypothesis

install.packages("cramer")

library(cramer)

cramer.test(species_by_use[, 2],
	    [, 3])

### Two-sample t-test ###
	
t.test(dune.env$sr[dune.env$Management == "HF"],
       dune.env$sr[dune.env$Management != "HF"],
       alternative = "greater") # here we test the hypothesis that HF plots have higher species richness on average than the other plots
    
### Correlation test and linear regression ###
    
plot(dune.env$A1,
     dune.env$sr)
cor.test(dune.env$sr,
         dune.env$A1,
         alternative = "less") # here we test the hypothesis that species richness and soil thickness are negatively correlated	   

plot(mtcars$disp,
     mtcars$hp)
cor.test(mtcars$disp,
         mtcars$hp,
         alternative = "greater") # hypothesis -> positive correlation
mod <- lm(hp ~ disp, data = mtcars)
summary(mod)
str(mod, 1)
abline(mod$coefficients[1], mod$coefficients[2])

### Shapiro's normality test ###

hist(dune.env$sr)
shapiro.test(dune.env$sr)

hist(dune.env$A1)
shapiro.test(dune.env$A1)
