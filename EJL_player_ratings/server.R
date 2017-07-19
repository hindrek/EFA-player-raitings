source("extract_data.R")


library(shiny)


shinyServer(function(input, output) {

  output$game <- renderText({
    if(input$url == "")
      return(NULL)
    players(input$url, "Tartu Ülikool Fauna")$game
  })

  output$players <- renderUI({
    if(input$url == "")
      return(NULL)
    HTML(paste(players(input$url, "Tartu Ülikool Fauna")$players, "</br>"))
  })
})
