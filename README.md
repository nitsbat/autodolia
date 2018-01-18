# autodolia
The project aims at visualising the data with the help of R language (ggplot2 for data visualisation) and applied machine algorithms like linear and multiple regression.

Our objective is to first visualise and then analyze the data. Based on our analyzation, we will predict the result using Machine learning algorithms i.e linear and multiple regression. Analysis of data is done by using R-language and the package used for visualisation is ggplot2.

## Software Requirements
 #### R-Studio - https://www.rstudio.com/products/rstudio/download/
 #### ggplot2  - just type the following command to install ggplot2 package
      > install.packages(ggplot2)
      > library(ggplot2) #this command is used to load the package if already installed
 #### PostgreSQL - https://www.postgresql.org/download/windows/     
 
 __All the same codes below are present in different R scripts__
 
 ## Introduction
 The dataset in which we are performing the data analytics is a data-set provided by City Union Bank. It consists of all the ATM Transaction done by City Union bank and other banks from '1/1/2011' to '9/29/2017' at following five atm places.
 * Big Street ATM
 * Mount Road ATM
 * Airport ATM
 * KK Nagar ATM
 * Christ College Road
 
The dataset file is available at both .csv format and .sql format. Download the atmdata.csv or bro.sql file. Before visualising the data, we will clean the data by storing it in database i.e. Postgres in our case. Loading of data in database is already described by me in my repository https://github.com/nits2016/Data_Analytics.
Let's begin with the visualisation :

__I will assume that you have downloaded the file and save it in Desktop__

* Open the RStudio and load the .csv file. There are two ways to load the data in RStudio 
** First is to directly set the working directory and store in our desired dataframe by following command :

   `> setwd("C:/Users/nits/Desktop") #set a new working directory where the sample file is downloaded `   
   `> data <- read.csv('atmdata.csv')`
   
   `> atm <- data ;`
   
* The second way to load the data is to load the data from database which is Postgres in our case. For loading the data from Postgres we must install the "RPostgreSQL" package. (different database have different packages e.g. RevoScaleR for mySQL).
Following command will load the data in "tmp" dataframe


   ` > install.packages("RPostgreSQL"); #should not given if already installed` 

   ` > require("RPostgreSQL"); #to load the driver`

   ` > pw <- 'xyzabc' #password of postgres server`

   ` > drv <- dbDriver("PostgreSQL")`

   ` > con <- dbConnect(drv,dbname="Nits",host="localhost",port=5432,user="postgres",password=pw);`

   ` > rm(pw) #to delete the password for security concern.`
  
   ` > dbExistsTable(con,"git") #confirm if connection is established by giving a table name (i.e git table in our example)`
   
   ` > tmp <- dbGetQuery(con,"select * from git limit 10"); #postgres query will save the data in "tmp" (which is a dataframe)`

   ` > print(a)`

  :metal: __The above code is available in postgresDB.R and can be directly run by downloading the R script.__
  
* We will begin our first visualisation as a bar graph between the transaction date and total amount withdrawn.The command used to create a bar graph using ggplot2 package is :

       > p1 <- ggplot(atm,aes(x=DateOfTrans,y=total_amount_withdrawn,fill=atm_name)) 
       > p1 <- p1 + geom_bar(stat="identity") + scale_x_date(date_labels="%d-%b-%y",date_breaks = "4 month")
       > p1 <- p1 + theme(axis.text.x = element_text(angle=90,face="bold"))
 
 The output of the above code is : 
 ![rplot02](https://user-images.githubusercontent.com/22686274/35112030-c7d5f282-fca2-11e7-8b24-251489cb959f.png)
 ###### It is recommended to visualise the pic by downloading the original one from the repository.
 
 __Similarly the code for bar graph between the transaction date and total number of atm card withdraws are :__
 
       > p1 <- ggplot(atm,aes(x=DateOfTrans,y=no_of_withdrawals,fill=atm_name)) 
       > p1 <- p1 + geom_bar(stat="identity") + scale_x_date(date_labels="%d-%b-%y",date_breaks = "4 month")
       > p1 <- p1 + theme(axis.text.x = element_text(angle=90,face="bold"))

![rplot](https://user-images.githubusercontent.com/22686274/35112240-6f90d654-fca3-11e7-8d41-2afae1f5f454.png)

Analysis Observed :- 
1. It is clearly observed from the graphs that from date between Oct-2016 to jan-2016 , there is no cards and cash withdrawals. The bar graph at that series of points tends to almost zero. The only reason is the ___2016 Indian banknote demonetisation___ .
2. One can figured out that the amount of transaction or cash withdrawal is maximum from KK Nagar ATM. Filling duration or capacity of cash needs to be increased therefore in KK Nagar ATM. 
3. It can be also seen that the card withdrawals and atm transaction is maximum on month October of every year. One possible reason might be the more number of holidays as comared to any other month.

* The next visualisation is based on our usage of facets. Facets are very useful in splitting the data according to some field. Here we will observe the no of card withdrawals on the basis of weekdays i.e Sunday,Monday,etc. The following code will help to create the facet:

       > p <- ggplot(atm,aes(x="factors",y=no_of_withdrawals,fill=atm_name))
       > p = p + geom_bar(stat = "identity" )
       > p = p + facet_grid(facets = ~ weekday)
       
![rplotbar](https://user-images.githubusercontent.com/22686274/35113015-091d7a96-fca6-11e7-841a-e1769ae5c073.png)

Analysis Observed :- 
1. Obviously On sundays the amount of withdrawals are more because of holiday.
2. *KK Nagar ATM* still has the maximum number of withdrawals on almost all days due to its dense population.

 __Similarly the code for facet on the total amount withdrawn based on weekdays is :__
 
       > p <- ggplot(atm,aes(x="factors",y=total_amount_withdrawn,fill=atm_name))
       > p = p + geom_bar(stat = "identity" )
       > p = p + facet_grid(facets = ~ weekday);
 
 ![dhasu](https://user-images.githubusercontent.com/22686274/35113282-e6a32b90-fca6-11e7-800c-bbd032d5c458.png)

Analysis Observed :
1. Here is an interesting observation that the transaction is maximum on saturday and wednesday instead of Sunday and Monday. It is probably due to the starting weekend course of a new week.
2. The amount withdrawn is much more from Christ College ATM. Another visualisation one can made is the sudden increase of cash withdrawn on saturday from Christ College ATM. The reason may be the more amount of withdrawals from students as students take cash for the weekend.

* The above two plots can be also visualised through pie chart. One of the main problem occurs with the pie charts are they take too long to load/create , hence the following example is reduced to minimum number of instruction so that pie chart will not take too long to load. The command for creating a pie chart based on the atm name and amount withdrawal is :

       > tmp = subset(atm, weekday == "Sunday") #509 entries only
       > pc <- data.frame(atmName = tmp$atm_name, amount = tmp$total_amount_withdrawn )
       > bp <- ggplot(pc,aes(x="",y=amount,fill = atmName)) + geom_bar(stat = "identity")
       > pie <- bp + coord_polar("y",start=0)
       > pie <- pie + scale_fill_brewer(palette = "Dark2") + theme_minimal() + theme(axis.text.x = element_text(color =      "blue",face="bold"));

![rplot040](https://user-images.githubusercontent.com/22686274/35113957-347b558e-fca9-11e7-9fee-6d48c6b6a214.png)

Analysis are same as that of above analysis observed. Bar chart with facets win over pie charts in this aspect. The visualisation and cration of facets is also possible in pie chart. Again it took double of the current time to display the resulted chart. Therefore we have again done the slicing by taking records dated from "2015-1-1" to "2017-9-27". Though it take too long But then also we will form it :stuck_out_tongue_closed_eyes: The command for creating facets in pie chart is :

      > tmp <- data
      > tmp$transaction_date <- as.Date(tmp$transaction_date, format= "%Y-%m-%d");#formating the date in "%Y-%m-%d" format
      > k <- subset(tmp,transaction_date > "2015-1-1" & transaction_date < "2017-9-27");
      > pl <- ggplot(data=k,aes(x="",y=total_amount_withdrawn,fill = atm_name)) + geom_bar(stat="identity")
      > pl <- pl + facet_grid(facets = ~ weekday )
      > pl <- pl + coord_polar(theta="y")
      > pl <- pl + scale_fill_brewer(palette = "Dark2") + theme(axis.text.x = element_blank(),axis.text.y = element_blank())

![rplot04](https://user-images.githubusercontent.com/22686274/35114252-2251e9bc-fcaa-11e7-9991-77d42245bce4.png)

The only observation different from the bar facets are it shows the days when the demonetisation period was there or minimum number of transaction takes place. The increasing order of withdrawal is Sunday < Friday < Tuesday < Thursday < Monday < Saturday == Wednesday , and clearly the demonetisation was forced upon sunday. 

       
 

    
