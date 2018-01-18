# install package RPostgreSQL
# install.packages("RPostgreSQL"); #should not given if already installed 

require("RPostgreSQL"); #to load the driver
pw <- 'bisht123' #password of postgres server
drv <- dbDriver("PostgreSQL");
con <- dbConnect(drv,dbname="Nits",host="localhost",port=5432,user="postgres",password=pw);
rm(pw) #connecting with postgres
dbExistsTable(con,"git") #confirm if connection is established by giving a table name
a <- dbGetQuery(con,"select * from git limit 10");
# postgres query will save the data in a (which is a dataframe)
print(a)