library(lubridate)
library(rvest)
library(readr)
library(tidyverse)

#This function takes table id and cycle id and gets data from a public website for each table status. 
# The algorithm pushes each table's data into Global Environment.

pull_data <- function(table_id, cycle_id) {
  
  url <- "XXXXXPUBLICWEBSITE.com"
  dd_login_page <- html_session(url)
  
  # Fill out login form
  form_unfilled <- dd_login_page %>% html_node("form") %>% html_form()
  form_filled <- form_unfilled %>%
    set_values("login" = "XXXX@XXX.com",
               "login_password" = Sys.getenv("password"))
  
  # submit form
  session <- submit_form(dd_login_page, form_filled)
  
  
  #create an empty dataframe for the data 
  
  data <- data.frame(UnitID=numeric(),
                     MemberType=character(), 
                     `School.Name..click.Name.to.jump.to.table.`=character(),
                     Status=character(),
                     `Date.Status.Changed`=character(),
                     `Time.Status.Changed`=character(),
                     stringsAsFactors=FALSE) 
  #WILL
  
  get_request_url <- paste0("XXXXXXPUBLICWEBSITEPATH.COM?Table=", table_id, "&cycleID=", cycle_id, "&currentStatusVariable=", 47, "&currentYesNo=Y&startDate=&endDate=&groupList=12820&groupList=12821&groupList=12822&groupList=12774&groupList=12823&groupList=12729&groupList=12711&groupList=12727&groupList=13539&groupList=12735&excludeArchivedUnits=1&submit=Search")
  
  temp <- session %>%
    rvest:::request_GET(get_request_url) %>% 
    html_table() 
  
  if (length(temp)>0) {
    temp <- temp%>%  
    as.data.frame() %>% 
    rbind(data,.)
  temp$Status <- 47
  }
  
  #WILL_NOT
  get_request_url <- paste0("XXXXXXPUBLICWEBSITEPATH.COM?Table=", table_id, "&cycleID=", cycle_id, "&currentStatusVariable=", 48, "&currentYesNo=Y&startDate=&endDate=&groupList=12820&groupList=12821&groupList=12822&groupList=12774&groupList=12823&groupList=12729&groupList=12711&groupList=12727&groupList=13539&groupList=12735&excludeArchivedUnits=1&submit=Search")
  
  t <- session %>%
    rvest:::request_GET(get_request_url) %>% 
    html_table() 
  
  if (length(t)>0) {
    t <-  t %>% 
    as.data.frame() 
  t$Status <- 48
  temp <- t %>% 
    rbind(temp,.)
  }
  
  #COMPLETED
  get_request_url <- paste0("XXXXXXPUBLICWEBSITEPATH.COM?Table=", table_id, "&cycleID=", cycle_id, "&currentStatusVariable=", 49, "&currentYesNo=Y&startDate=&endDate=&groupList=12820&groupList=12821&groupList=12822&groupList=12774&groupList=12823&groupList=12729&groupList=12711&groupList=12727&groupList=13539&groupList=12735&excludeArchivedUnits=1&submit=Search")
  
  t <- session %>%
    rvest:::request_GET(get_request_url) %>% 
    html_table() 
  
  if (length(t)>0) {
    t <- t %>% 
    as.data.frame() 
  t$Status <- 49
  temp <- t %>% 
    rbind(temp,.)
  }
  
  #INCOMPLETE
  get_request_url <- paste0("XXXXXXPUBLICWEBSITEPATH.COM?Table=", table_id, "&cycleID=", cycle_id, "&currentStatusVariable=", 163, "&currentYesNo=Y&startDate=&endDate=&groupList=12820&groupList=12821&groupList=12822&groupList=12774&groupList=12823&groupList=12729&groupList=12711&groupList=12727&groupList=13539&groupList=12735&excludeArchivedUnits=1&submit=Search")
  
  t <- session %>%
    rvest:::request_GET(get_request_url) %>% 
    html_table()
  
  if (length(t)>0) {
    t <-  t%>% 
    as.data.frame() 
  t$Status <- 163
  temp <- t %>% 
    rbind(temp,.)
  }
  
  #LOCKED
  get_request_url <- paste0("XXXXXXPUBLICWEBSITEPATH.COM?Table=", table_id, "&cycleID=", cycle_id, "&currentStatusVariable=", 50, "&currentYesNo=Y&startDate=&endDate=&groupList=12820&groupList=12821&groupList=12822&groupList=12774&groupList=12823&groupList=12729&groupList=12711&groupList=12727&groupList=13539&groupList=12735&excludeArchivedUnits=1&submit=Search")
  
  t <- session %>%
    rvest:::request_GET(get_request_url) %>% 
    html_table() 
  
  if (length(t)>0) {
    t <-  t %>% 
    as.data.frame() 
  t$Status <- 50
  temp <- t %>% 
    rbind(temp,.)
  }
  
  
  #AWAITING
  get_request_url <- paste0("XXXXXXPUBLICWEBSITEPATH.COM?Table=", table_id, "&cycleID=", cycle_id, "&currentStatusVariable=", 74, "&currentYesNo=Y&startDate=&endDate=&groupList=12820&groupList=12821&groupList=12822&groupList=12774&groupList=12823&groupList=12729&groupList=12711&groupList=12727&groupList=13539&groupList=12735&excludeArchivedUnits=1&submit=Search")
  
  t <- session %>%
    rvest:::request_GET(get_request_url) %>% 
    html_table() 
  
  if (length(t)>0) {
    t <-  t %>% 
    as.data.frame() 
  t$Status <- 74
  temp <- t %>% 
    rbind(temp,.)
  }
  
  
  #if there is at all any data for this table, assign it to the global environment.
  
  if (length(temp) >0) {
  temp$Data_pull_date <- lubridate::today()
  temp$table <- table_id

  
  assign(paste0(table_id), temp, envir=.GlobalEnv)
  }
  
 }
