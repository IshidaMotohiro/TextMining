install.packages("RSelenium")

# use installed selenium-server
## check your directory
# cd .local/share/binman_seleniumserver/generic/4.0.0-alpha-2/
# java -jar selenium-server-standalone-4.0.0-alpha-2.jar 

library(RSelenium)
# Start Selenium Session
remDr <- remoteDriver(
  remoteServerAddr = "localhost",
  port = 4444L,
  browserName = "firefox"
)
remDr$open()

remDr$navigate(url = "https://bookmeter.com/books/5550353")

remDr$navigate("https://books.toscrape.com/catalogue/category/books/science-fiction_16")

# reviews <- remDr$findElements(using = "css", "html body.layouts.application section.books.show div.bm-wrapper div.bm-wrapper__main section.layouts.components.content-with-header div.content-with-header__content section")
reviews <- remDr$findElements(using = "class", "frame__content__text")

texts <-  unlist(lapply(reviews, function(x){x$getElementText()}))

texts

remDr$close()
