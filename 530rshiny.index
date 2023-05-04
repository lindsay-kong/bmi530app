# Define UI for application
ui <- fluidPage(
  titlePanel("My data"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    sidebarPanel(
      
      # Dropdown input for gene selection
      selectInput("gene", "Gene", choices = c("AKT1", "BRAF", "EGFR", "KRAS", "TP53"), selected = "KRAS"),
      
      # Dropdown input for cohort selection
      selectInput("cohort", "Cohort", choices = c("ACC", "BLCA", "BRCA", "CESC", "CHOL", "COAD", "DLBC", "ESCA", "GBM", "HNSC", "KICH", "KIRC", "KIRP", "LAML", "LGG", "LIHC", "LUAD", "LUSC", "MESO", "OV", "PAAD", "PCPG", "PRAD", "READ", "SARC", "SKCM", "STAD", "TGCT", "THYM", "THCA", "UCEC", "UCS", "UVM"), selected = "PAAD"),
      
      # Checkbox to show/hide table
      checkboxInput("show_table", "Show table", value = TRUE),
      
      # Slider for density plot transparency
      sliderInput("alpha", "Density plot transparency", min = 0, max = 1, value = 0.5)
    ),
    
    # Output display
    mainPanel(
      textOutput("textOut"),
      dataTableOutput("distPlot"),
      plotOutput("myGraph")
    )
  )
)



# Define server logic
server <- function(input, output) {
  
  # Reactive expression to retrieve data from Firebrowse API
  myDF <- reactive({
    myQuery <- list(
      format = 'json',
      gene = input$gene,
      cohort = input$cohort,
      page = 1,
      page_size = input$show_table_rows,
      sort_by = "tcga_participant_barcode"
    )
    myURL <- parse_url('https://firebrowse.org/api/v1/Samples/mRNASeq')
    myURL$scheme = "http"
    myURL$query  = myQuery
    stringifiedURL <- build_url(myURL)
    response <- GET(stringifiedURL)
    myContent <- content(response)
    df <- do.call(rbind,lapply(myContent$mRNASeq,as.data.frame))
  })
  
  # Render text output
  output$textOut <- renderText({
    paste("Selected gene:", input$gene, "| Selected cohort:", input$cohort)
  })
  
  # Render table output
  output$distPlot <- renderDataTable({
    if (input$show_table) {
      datatable(
        myDF(), 
        options = list(
          lengthMenu = c(10, 25, 50), 
          pageLength = 10
        )
      )
    }
  })
  
  # Render density plot
  output$myGraph <- renderPlot({
    p <- ggplot(data = myDF())
    p <- p + geom_density(aes(x = expression_log2,
                              color = gene,
                              fill = cohort),
                          alpha = input$alpha)
    print(p)
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
