library(rvest)
library(magrittr)


players <- function(url, team) {
  # home or away team
  home <- read_html(url) %>%
    html_nodes("#page > div > div > div > div.head > div.teams > div:nth-child(1) > p") %>%
    html_text()

  away <- read_html(url) %>%
    html_nodes("#page > div > div > div > div.head > div.teams > div:nth-child(3) > p") %>%
    html_text()

  side <- ifelse(team == home, "left", ifelse(team == away, "right", stop("Wrong team, check URL.", call. = F)))

  # line-up
  lnp <- read_html(url) %>%
    html_nodes("#page > div > div > div > div:nth-child(4) > div.list.list-02.lineup.clearfix") %>%
    html_nodes(paste0("ul.", side, " > li > p > a")) %>%
    html_text()

  # substitutes
  subs <- read_html(url) %>%
    html_nodes("#page > div > div > div > div:nth-child(5) > div.list.list-02.clearfix") %>%
    html_nodes(paste0("ul.", side, " li"))
  subs <- subs[-1]

  # check which substitutes played
  plyd_subs <- lapply(subs, function(sub) {
    name <- html_nodes(sub, "a") %>%
       html_text()
    name[length(html_nodes(sub, "span.in"))]
  }) %>%
    unlist()

  # output
  list(
    game = paste(home, "-", away),
    players = c(lnp, plyd_subs)
  )
}
