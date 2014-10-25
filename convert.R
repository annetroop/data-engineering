setwd("c:/coursera/livingsocial/data-engineering")

#input the existing file
df = read.table("example_input.tab", sep = "\t", quote = "", header = TRUE)

# Connect to MySQL.  The first time, you need to compile the RMySQL library from source
# install.packages("RMySQL", type="source")
library(RMySQL)
mydb <- dbConnect(MySQL(), user="root", password="4science!", 
                 dbname="mydb", host="localhost",client.flag=CLIENT_MULTI_STATEMENTS)


# Make a Purchaser data frame
pt <- data.frame(df$purchaser.name)
pt$p_id <- as.numeric(df$purchaser.name)
p <- unique(pt)
df$p_id <- as.numeric(df$purchaser.name)


# Make a Merchant data frame
mt <- data.frame(df$merchant.name)
mt$m_id <- as.numeric(df$merchant.name)
mt$m_address <- df$merchant.address
m <- unique(mt)
df$m_id <- as.numeric(df$merchant.name)


# Clean up the original data frame into a normalized table to go along
# with the merchant and purchaser tables
library(dplyr)
library(tidyr)
df2 <- df %>% select(p_id, m_id, item.description, item.price, purchase.count)

# Store the data frames as tables in the database
dbWriteTable(mydb, name='purchasers', value=p)
dbWriteTable(mydb, name='purchases', value=df2)
dbWriteTable(mydb, name='merchants', value=m)

dbDisconnect(mydb)