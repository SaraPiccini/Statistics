# R project - Statistical Analysis

# Installing the package needed for the analysis and recalling the library
install.packages("vegan")
library(vegan) 

# Importing data
bci_env <- read.table("data/BCI_env.txt",
                      sep = " ",
                      header = T,
                      na.strings = c("NA", "")) # Sister data set with environmental variables
bci <- read.csv("data/BCI.csv") # Community matrix
# sep = " " to explicit that the field are separated by a white space
# header = T to make first row column titles
# na.strings = c("NA", "") to convert empty cells into NAs

# Counting the number of observations, environmental variables and species 
nrow(bci) # Number of observation = 50 
ncol(bci_env) # Number of environmental variables = 9
ncol(bci) # Number of species = 225

# Access to documentation on our data sets
?BCI 

# Checking data structure
str(bci_env) 
str(bci)

# Transform columns types to match data types and structures described in the documentation
# Checking Habitat levels
unique(bci_env$Habitat)
# Transforming Habitat into an ordered factor with 5 levels 
bci_env$Habitat <- factor(bci_env$Habitat,
                          levels = c("Young", "OldSlope", "OldLow", "OldHigh", "Swamp"),
                          ordered = T)

# Checking Age.cat levels
unique(bci_env$Age.cat)
# Transforming Age.cat into an ordered factor with 2 levels 
bci_env$Age.cat <- factor(bci_env$Age.cat,
                          levels = c("c2", "c3"),
                          ordered = T)

# Checking Stream levels
unique(bci_env$Stream)
# Transforming Stream into an ordered factor with 2 levels 
bci_env$Stream <- factor(bci_env$Stream,
                        levels = c("Yes", "No"),
                        ordered = T)
# Checking Geology levels
unique(bci_env$Geology)

# Calculate summary statistics for our environmental variables and remove the rows containing NAs from the dataframe (bci.env)
# Then remove the same rows from the dataframe (bci) representing the community matrix
summary(bci_env)

# Identify the location of NAs values in bci_env dataset
index_na <- which(is.na(bci_env), arr.ind = T)
index_na <- index_na[, 1] 

# Removing NAs 
bci_env <- na.omit(bci_env)
bci <- bci[-index_na, ] 

# Check if NAs have been removed and structure and summary fixed without NAs
str(bci_env)
summary(bci_env)

# Graphically explore the univariate distribution of our environmental variable Habitat type with a barplot 
barplot(table(bci_env$Habitat),
        main = "Habitat types",
        ylim = c(0, 26),
        ylab = "Frequency",
        xlab = "Habitat type")
# Exporting it
png("outputs/Figure1.png", res = 300, width = 3000, heigh = 2000) 
barplot(table(bci_env$Habitat),
        main = "Habitat types",
        ylim = c(0, 26),
        ylab = "Frequency",
        xlab = "Habitat type")
dev.off() 

# Distribution of Streams in Habitat types with a stacked bar plot
barplot(table(bci_env$Stream, bci_env$Habitat),
        main = "Presence or Absence of Stream",
        ylim = c(0, 26),
        ylab = "Frequency",
        xlab = "Habitat types",
        legend.text = T)
# Exporting it
png("outputs/Figure2.png", res = 300, width = 3000, heigh = 2000) 
barplot(table(bci_env$Stream, bci_env$Habitat),
        main = "Presence or Absence of Stream",
        ylim = c(0, 26),
        ylab = "Frequency",
        xlab = "Habitat types",
        legend.text = T)
dev.off() 

# Convert community matrix to presence/absence
bci_pa <- decostand(bci, method = "pa") 
# Exporting the pa matrix in .csv format
write.csv(x = bci_pa, 
          file = "outputs/bci_pa.csv")

# Computing species richness for each observation of our community matrix and add it to bci_env data frame as a new column
bci_env$sr <- specnumber(bci) 

# Maximum, minimum and average species richness with summary function
summary(bci_env$sr) # Minimum = 77.00 Maximum = 109.00 Mean = 90.96

# Save the data frame with sr column
write.table(x = bci_env,
            file = "outputs/bci.env_sr.txt")

# Species richness distribute in respect with Habitat variable with a boxplot 
boxplot(bci_env$sr ~ bci_env$Habitat,
        ylim = c(70, 110),
        xlab = "Habitat type",
        ylab = "Species richness")
# Exporting the boxplot
png("outputs/Figure3.png", res = 300, width = 3000, heigh = 2000)
boxplot(bci_env$sr ~ bci_env$Habitat,
        ylim = c(70, 110),
        xlab = "Habitat type",
        ylab = "Species richness")
dev.off()

# Species richness with respect to EnvHet: two numerical variables (scatterplot)
plot(bci_env$EnvHet, bci_env$sr,
     xlab = "Environmental Heterogeneity",
     ylab = "Species richness")
# Exporting it
png("outputs/Figure4.png", res = 300, width = 3000, heigh = 2000)
plot(bci_env$EnvHet, bci_env$sr,
     xlab = "Environmental Heterogeneity",
     ylab = "Species richness")
dev.off()

# Correlation test to test the correlation:
cor.test(bci_env$EnvHet, bci_env$sr)
# cor = -0.0015 meaning no correlation
# p-value = 0.992 meaning no evidence against H0 (H0 = there is no correlation between the two variables)

# If there were correlation these are the steps to evaluate the regression model:
lm <- lm(sr ~ EnvHet, data = bci_env) # To construct the linear regression model 
summary(lm)
abline(lm$coefficients[1], lm$coefficients[2], col="red") # To visualize the regression line that is horizontal: Estimate value of species richness (b1:slope) = 0
# Exporting it
png("outputs/Figure5.png", res = 300, width = 3000, heigh = 2000)
plot(bci_env$EnvHet, bci_env$sr,
     xlab = "Environmental Heterogeneity",
     ylab = "Species richness",
     abline(lm$coefficients[1], lm$coefficients[2], col="red"))
dev.off()
str(lm) 


