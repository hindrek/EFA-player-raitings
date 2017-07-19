library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

  titlePanel("Tartu Ülikool Fauna mängijate hindamine"),

  # input
  textInput("url", "URL"),

  # output
  textOutput("game"),
  htmlOutput("players")
))
