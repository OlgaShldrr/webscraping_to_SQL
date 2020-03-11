# Webscraping to SQL

This project demostrates how one can build a database by daily webscraping of public data. The code in this project is to be run regularly by cronR or any other schedulers. It creates a function that run through different webpages/different tables and scrapes everything available on the page. It then binds all the dataframes togather and pushes them to the SQL server.

#### Packages used:

The project utilizes the packages as rvest, DBI, odbc, lubridate and tidyverse.
