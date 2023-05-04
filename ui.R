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