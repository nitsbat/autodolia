# 5 plot
# scatter plot of cub card withdrawals

setwd("C:/Users/nits/Desktop") #set a new working directory where the sample file is downloaded
library(ggplot2)
data <- read.csv('atmdata.csv')
atm = data;
p <- ggplot(atm,aes(x=no_of_cub_card_withdrawals,y=amount_withdrawn_cub_card,color = atm_name)) + geom_point(aes(color=atm_name,shape=atm_name))

# if the field name(atm_name) is small or abbreviated then we can also use.. > p + geom_text(aes(label=atm_name),size=1);


#Linear Regression
x <- atm$no_of_cub_card_withdrawals
y <- atm$amount_withdrawn_cub_card 
relation <- lm(y ~ x)
summary(relation) # to know about other factors affecting the graph.
p <- p + geom_line(aes(y=predict(relation)),color="black") # to show the regression through graph

# we will predict the amount from cub card withdrawn when the nos of withdrawals were 345
#lets first check what was the actual amount withdrawn from when card = 345
k = subset(atm,no_of_cub_card_withdrawals==345)
k = k$amount_withdrawn_cub_card
# k is equal to 1622900
#now lets use the regression graph. We will make a dataframe with same variable
l <- data.frame(x <- 345)
k <- predict(relation,l)
# now k is equal to 1675879


