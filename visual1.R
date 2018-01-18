setwd("C:/Users/nits/Desktop") #set a new working directory where the sample file is downloaded
library(ggplot2)
data <- read.csv('atmdata.csv')
atm = data;


# 1 plot is between atm date and nos of withdrawals/total amount withdrawn
k = atm$transaction_date
DateOfTrans = as.Date(k)
p1 <- ggplot(atm,aes(x=DateOfTrans,y=total_amount_withdrawn,fill=atm_name)) 
p1 + geom_bar(stat="identity") + scale_x_date(date_labels="%d-%b-%y",date_breaks = "4 month") + theme(axis.text.x = element_text(angle=90,face="bold"))


# 2 plot use of facets
p <- ggplot(atm,aes(x="factors",y=no_of_withdrawals,fill=atm_name)); 
p = p + geom_bar(stat = "identity" );
p = p + facet_grid(facets = ~ weekday);


# 3 plot
# Pie chart according to atm name on banks
# not suitable for large number of records so we will take all records from sunday
tmp = subset(atm, weekday == "Sunday") #509 entries only
pc <- data.frame(atmName = tmp$atm_name, amount = tmp$total_amount_withdrawn )
bp <- ggplot(pc,aes(x="",y=amount,fill = atmName)) + geom_bar(stat = "identity")
pie <- bp + coord_polar("y",start=0)
pie <- pie + scale_fill_brewer(palette = "Dark2") + theme_minimal() + theme(axis.text.x = element_text(color = "blue",face="bold"));



# 4 plot Pie chart with facets on weekdays , condition on date cozz pie takes time 
tmp <- data
tmp$transaction_date <- as.Date(tmp$transaction_date, format= "%Y-%m-%d");
k <- subset(tmp,transaction_date > "2015-1-1" & transaction_date < "2017-9-27");
pl <- ggplot(data=k,aes(x="",y=total_amount_withdrawn,fill = atm_name)) + geom_bar(stat="identity")
pl <- pl + facet_grid(facets = ~ weekday )
pl <- pl + coord_polar(theta="y")
pl <- pl + scale_fill_brewer(palette = "Dark2") + theme(axis.text.x = element_blank(),axis.text.y = element_blank())

