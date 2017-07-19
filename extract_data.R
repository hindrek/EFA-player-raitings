library(rvest)
library(magrittr)


team <- "Tartu Ülikool Fauna"

url <- "http://jalgpall.ee/voistlused/protocol/69204" # readline("URL: ")
html <- read_html(url)

home <- html %>%
  html_nodes("#page > div > div > div > div.head > div.teams > div:nth-child(1) > p") %>%
  html_text()

away <- html %>%
  html_nodes("#page > div > div > div > div.head > div.teams > div:nth-child(3) > p") %>%
  html_text()

side <- ifelse(team == home, "left", ifelse(team == away, "right", stop("Wrong team, check URL.", call. = F)))

lnp <- html %>%
  html_nodes("#page > div > div > div > div:nth-child(4) > div.list.list-02.lineup.clearfix") %>%
  html_nodes(paste0("ul.", side, " > li > p > a")) %>%
  html_text()

# TODO: check which substitutes played
subs <- html %>%
  html_nodes("#page > div > div > div > div:nth-child(5) > div.list.list-02.clearfix") %>%
  html_nodes(paste0("ul.", side, " > li > p > a")) %>%
  html_text()

plyrs <- c(lnp, subs)
