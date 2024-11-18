library(shiny)
library(dplyr)
library(DT)

pitcher_data <- data.frame(
  Player = c("Chase Burns", "Thatcher Hurd", "Taisei Ota", "Brody Brecht"),
  Position = c("RHP", "RHP", "RHP", "RHP"),
  OFP = c(60, 50, 49, 44),
  FB = c(80, 55, 70, 80),
  CB = c(60, 60, NA, 40),
  SL = c(70, 55, 45, 70),
  CH = c(40, 35, 70, 55),
  Control = c(50, 45, 55, 45),
  ScoutingReport = c(
    NA,
    "www/Thatcher Hurd.pdf",
    NA,
    "www/Brody _Brecht_SR (1).pdf"
  )
)

position_player_data <- data.frame(
  Player = c("Jac Caglianone", "Munetaka Murakami", "Tommy White", "Charlie Condon", 
             "Dakota Jordan", "Kaelen Culpepper", "Hye-seong Kim", "Jacob Cozart", "Cam Leary"),
  Position = c("1B", "1B", "1B", "3B", "LF/RF", "SS", "2B", "C", "LF/RF"),
  OFP = c(62.5, 56.5, 55.75, 53.5, 51.5, 49.5, 48.75, 46.5, 46.25),
  Hit = c(55, 50, 60, 50, 40, 50, 45, 40, 45),
  Power = c(70, 70, 60 ,60,60, 40, 35, 50, 50),
  Speed = c(40, 40, 40, 50, 60, 60, 60, 30, 55),
  Field = c(55, 50, 45, 55, 50, 45, 60, 50, 50),
  Arm = c(70,50,55,50,50,55,55,55,45),
  ScoutingReport = c(
    "www/Jac Caglianone-SS.pdf",
    "www/Munetaka Murakami.pdf",
    "https://www.sportsinfosolutions.com/2024/07/05/mlb-draft-scouting-report-tommy-white/",
    "www/Charlie Condon SR.pdf",
    "https://www.sportsinfosolutions.com/2024/07/02/college-baseball-scouting-report-dakota-jordan/",
    "https://www.sportsinfosolutions.com/2024/07/08/mlb-draft-scouting-report-kaelen-culpepper/",
    "www/Hye-Seong Kim.pdf",
    "https://www.sportsinfosolutions.com/2024/07/11/mlb-draft-scouting-report-jacob-cozart/",
    NA
  )
)

ui <- fluidPage(
  titlePanel("Scouting Reports Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      h3("Filter Pitchers"),
      selectInput("position_filter_pitchers", "Position:", choices = c("All", "RHP", "LHP")),
      
      h3("Filter Position Players"),
      selectInput("position_filter_position_players", "Position:", 
                  choices = c("All", unique(position_player_data$Position)))
    ),
    mainPanel(
      h3("Pitchers"),
      DTOutput("pitcher_table"),
      h3("Position Players"),
      DTOutput("position_player_table")
    )
  )
)

server <- function(input, output) {
  generate_link <- function(report) {
    if (is.na(report) || report == "") {
      return("")  
    }
    if (grepl("^http", report)) {
      paste0('<a href="', report, '" target="_blank">View Report</a>')
    } else {
  
      paste0('<a href="', gsub("^www/", "", report), '" target="_blank">View PDF</a>')
    }
  }

  pitcher_data <- pitcher_data %>%
    mutate(
      Rounded_OFP = round(OFP / 5) * 5,
      ScoutingReport = sapply(ScoutingReport, generate_link)
    )
  

  position_player_data <- position_player_data %>%
    mutate(
      Rounded_OFP = round(OFP / 5) * 5,
      ScoutingReport = sapply(ScoutingReport, generate_link)
    )
  

  filtered_pitchers <- reactive({
    data <- pitcher_data
    if (input$position_filter_pitchers != "All") {
      data <- data %>% filter(Position == input$position_filter_pitchers)
    }
    data
  })
  

  filtered_position_players <- reactive({
    data <- position_player_data
    if (input$position_filter_position_players != "All") {
      data <- data %>% filter(Position == input$position_filter_position_players)
    }
    data
  })
  

  output$pitcher_table <- renderDT({
    datatable(filtered_pitchers() %>% select(-OFP) %>% rename(OFP = Rounded_OFP),
              escape = FALSE, options = list(pageLength = 5)) %>%
      formatStyle(
        'OFP',
        backgroundColor = styleInterval(c(45, 55), c('orange', 'yellow', 'green'))
      )
  })

  output$position_player_table <- renderDT({
    datatable(filtered_position_players() %>% select(-OFP) %>% rename(OFP = Rounded_OFP),
              escape = FALSE, options = list(pageLength = 5)) %>%
      formatStyle(
        'OFP',
        backgroundColor = styleInterval(c(45, 55), c('orange', 'yellow', 'green'))
      )
  })
}

shinyApp(ui = ui, server = server)

