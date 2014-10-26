#
# convert.R reads in a table separated file from our new subsidiary and 
# enters it into mySQL in a normalized form consisting of three tables,
# "purchases", "purchaser", and "merchant"
#

#
# Configuration variables
# Change these as needed
#
setwd("c:/coursera/livingsocial/data-engineering")
filename <- "example_input.tab"
dbusername <- "root"
dbpassword <- "4science!"
db <- "mydb"

#
# Impport needed libraries.  If you haven't used them before, you may 
# need to run Tool > Install Package.
#
library(dplyr)
library(tidyr)
# The library for connecting to MySQL isn't available via Tools.  
# The first time, you need to compile the RMySQL library from source;
# uncomment the line below to do that.
#
# install.packages("RMySQL", type="source")
library(RMySQL)


#input the existing file
df <- read.table(filename, sep = "\t", quote = "", header = TRUE)

# Connect to mySQL
mydb <- dbConnect(MySQL(), user = dbusername, password = dbpassword, 
                 dbname = db, host = "localhost",client.flag=CLIENT_MULTI_STATEMENTS)


# Make a Purchaser data frame, with a purchaser id ("p_id") to tie it to purchases
pt <- data.frame(df$purchaser.name)
pt$p_id <- as.numeric(df$purchaser.name)
p <- unique(pt)
df$p_id <- as.numeric(df$purchaser.name)


# Make a Merchant data frame, with a mechant id ("m_id") to tie it to purchases
mt <- data.frame(df$merchant.name)
mt$m_id <- as.numeric(df$merchant.name)
mt$m_address <- df$merchant.address
m <- unique(mt)
df$m_id <- as.numeric(df$merchant.name)


# Clean up the original data frame into a normalized table to go along
# with the merchant and purchaser tables

df2 <- df %>% select(p_id, m_id, item.description, item.price, purchase.count)

# Calculate the sum of the purchases
total <- sum(df2$item.price * df2$purchase.count)
print(paste("Total purchases were:", total))

# Store the data frames as tables in the database
dbWriteTable(mydb, name='purchasers', value=p)
dbWriteTable(mydb, name='purchases', value=df2)
dbWriteTable(mydb, name='merchants', value=m)

# Always disconnect from a database!
dbDisconnect(mydb)