library(shiny)
library(shinythemes)
library(googleVis)

# Start the shinyUI
shinyUI(fluidPage(
  
  #CSS styling
  includeCSS("www\\style.css"),
  # Application title
  theme = shinytheme("cerulean"),
  titlePanel(title=div(img(src="demo.jpg"), span("Demographic Profile", style = "color:purple"))), 
  tags$head(tags$script("alert('Hi! Welcome to my simple app!');")),
 
  sidebarLayout(
    sidebarPanel(
      h1("Gender"),
      checkboxGroupInput("gender", "Select gender (either one or both):",
                         choices = levels(data.adult$sex),
                         selected = levels(data.adult$sex)),
      h1("Age"),
      sliderInput("minage", "Select lower age limit:", min(data.adult$age), max(data.adult$age), value = min(data.adult$age), step = 1),
      sliderInput("maxage", "Select upper age limit:", min(data.adult$age), max(data.adult$age), value = max(data.adult$age), step = 1),
   
      actionButton("submitter","Check it out!") 
  ),
  
  

#Main Panel
mainPanel(
  tabPanel("Demographics", 
           column(10,div(span("Gender Distribution (%)", style="color:blue", img(src = "gender2.png", height = 60, width = 90)), class = "title"),
                  br(),
                  plotOutput("genderbars", height = "250px", width = "80%"),
                  div(span("Age Distribution (%)", style="color:gold",img(src = "age_female.png", height = 120, width = 150),img(src = "age_male.png", height = 120, width = 120) ), class = "title"),
                  br(),
                  plotOutput("agechart", height = "350px", width = "90%"))
           
  ))

  )

))