library(shiny)


shinyUI(fluidPage(

  titlePanel("Tartu Ülikool Fauna mängijate hindamine"),

  # input
  textInput("url", "URL"),

  # output
  textOutput("game"),
  htmlOutput("players")
))
