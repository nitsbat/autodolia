# Multiple Regression No plots
# take x1 - nos_of_cub_card_withdraw and x2 - nos_of_other_card_withdraw
# y - total_amount spent

#let's first create mult frame of required fields
mult <- tmp[,c("no_of_cub_card_withdrawals","no_of_other_card_withdrawals","total_amount_withdrawn")]

#applying multiple regressio and then creating an equation
relation <- lm(data=mult,total_amount_withdrawn ~ no_of_cub_card_withdrawals + no_of_other_card_withdrawals)
print(relation)

# Following is the result
# Call:
#   lm(formula = total_amount_withdrawn ~ no_of_cub_card_withdrawals + 
#        no_of_other_card_withdrawals, data = mult)
# 
# Coefficients:
#   (Intercept)    no_of_cub_card_withdrawals  
# -14002                          5171  
# no_of_other_card_withdrawals  
# 3351 

#we will now store the intercepts and slope in variables.
a <- coef(relation)[1]
xCub_card <- coef(relation)[2]
xOther_card <- coef(relation)[3]

#down line is y equation for multiple regression and we can predict amount
# giving x1 and x2 preferrable value like no_of_cub_Card and other_card
Y <- a + xCub_card*x1 + xOther_card*x2 
# e.g. take x1 <- 27 and x2 <- 52 and run the y equation
# the actual result is 305100 but we are getting 299879.2 which is not bad.

x1 <- 27
x2 <- 52
Y <- a + xCub_card*x1 + xOther_card*x2
Y
# result will be 299879.2