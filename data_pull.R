#System time for the logs

#remove all files from the environment, as we will need it empty
rm(list=ls())
print(Sys.time())

source("R/funs.R")
library(DBI)

#Create a dataframe with all table ids. 

tables <- data.frame(table_id=c(739, 114, 115, 435, 139, 436, 4059, 4060) 
                   stringsAsFactors=FALSE) 
 
#Loop through each table

for (i in 1:nrow(tables))  {
  pull_data(table_id = tables[i, 1], cycle_id = 470)
}

#Now when we remove these objects, there should only table data be left in the environment
rm(tables); rm(i); rm(pull_data)

#Bind all tables together and make variable names nicer.
current <- do.call("rbind", lapply(ls(),get))
names(current) <- (c("UnitID", "MemberType", "SchoolName", "Status", "Date", "Time", "DataPull", "table"))


#Append this data to the existing table on SQL server.
con <- odbc::dbConnect(odbc::odbc(), Driver = "ODBC Driver 17 for SQL Server", 
                       Server = Sys.getenv("SERVER"), Database = Sys.getenv("DB"), 
                       UID = Sys.getenv("UID"), PWD = Sys.getenv("PWD"))

dbAppendTable(con, "tables", current)
