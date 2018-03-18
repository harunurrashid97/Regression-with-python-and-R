# Entering the keys. Use start:finish syntax to begin a vector from the number "start" until "finish" incrementing by 1.
key=1:7

# Entering the values
value=c(2,2,5,4,5,6,6)

# Checking that key and value have the same number of elements
length(key)
length(value)

# Producing a scatterplot of value versus key
plot(key,value)

# We're going to use lm command to compute a "linear model" that fits the data
result=lm(value~key)

# Checking the variable result
result
# We will see that the equation of the line of best fit is: value = 1.4286 + 0.7143 key.
# Note, this equation has the form y = a + b x, where a is the intercept of the line and b is the slope, or the regression coefficient.

# Drawing the "line of best fit"
abline(result)

# Defining the correlation coefficient
cor.test(value,key)