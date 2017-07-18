library(rvest)
library(magrittr)


html <- read_html("http://jalgpall.ee/voistlused/protocol/69204")

lnps <- html %>%
  html_nodes("#page > div > div > div > div:nth-child(4) > div.list.list-02.lineup.clearfix")

subs <- html %>%
  html_nodes("#page > div > div > div > div:nth-child(5) > div.list.list-02.clearfix")

# home team ---------------------------------------------------------------

home <- lnps %>%
  html_nodes("ul.left")

home_team <- home %>%
  html_nodes("li.title") %>%
  html_text()

home_lnp <- home %>%
  html_nodes("li > p > a") %>%
  html_text()

# TODO: check which substitutes played
home_subs <- subs %>%
  html_nodes("ul.left > li > p > a") %>%
  html_text()

# away team ---------------------------------------------------------------

away <- lnps %>%
  html_nodes("ul.right")

away_team <- away %>%
  html_nodes("li.title") %>%
  html_text()

away_lnp <- away %>%
  html_nodes("li > p > a") %>%
  html_text()

away_subs <- subs %>%
  html_nodes("ul.right > li > p > a") %>%
  html_text()
