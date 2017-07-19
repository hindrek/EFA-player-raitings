library(rvest)
library(magrittr)


html <- read_html("http://jalgpall.ee/voistlused/protocol/67480")


players <- function(html, team = "Tartu Ülikool Fauna") {
  # home or away team
  home <- html %>%
    html_nodes("#page > div > div > div > div.head > div.teams > div:nth-child(1) > p") %>%
    html_text()

  away <- html %>%
    html_nodes("#page > div > div > div > div.head > div.teams > div:nth-child(3) > p") %>%
    html_text()

  side <- ifelse(team == home, "left", ifelse(team == away, "right", stop("Wrong team, check URL.", call. = F)))

  # line-up
  lnp <- html %>%
    html_nodes("#page > div > div > div > div:nth-child(4) > div.list.list-02.lineup.clearfix") %>%
    html_nodes(paste0("ul.", side, " > li > p > a")) %>%
    html_text()

  # substitutes
  subs <- html %>%
    html_nodes("#page > div > div > div > div:nth-child(5) > div.list.list-02.clearfix") %>%
    html_nodes(paste0("ul.", side, " li"))
  subs <- subs[-1]

  # check which substitutes played
  plyd <- vector()
  for(sub in subs) {
    name <- html_nodes(sub, "a") %>%
      html_text()

    if(length(html_nodes(sub, "span.in"))) {
      plyd <- c(plyd, name)
    }
  }

  list(
    game = paste(home, "-", away),
    players = c(lnp, plyd)
  )
}
