library(shiny)

#initialization of server.R
shinyServer(function(input, output) {
  
  #----Reactive subset for Gender and Age----#
  
  data.sset <- reactive({
    input$submitter
    isolate({
      subset(data.adult, sex %in% input$gender & age >= input$minage & 
               age <= input$maxage) #all input are linked with each other
      
    })
    
  })
  
  
  #----Demograhpic plots for Gender and Age----#
  
  genders.amount <- reactive({
    input$submitter
    isolate({length(input$gender)})
  })
  
  #display plot as per input selected
  output$genderbars <- renderPlot({
    
    barplot(prop.table(table(data.sset()$sex)) * 100, 
            col = c("maroon","deepskyblue3")[1:genders.amount()],
            ylab = "Proportion (%)")
    
  })
  
  #display plot by linking the minimum and maximum age selected
  output$agechart <- renderPlot({
    
    agg.set <- with(data.sset(), melt(prop.table(table(sex,age),1)))
    agg.set$value <- agg.set$value *  100
    age_sex.plot <- ggplot(agg.set, aes(x=age,y=value,group=sex, colour = sex))
    age_sex.plot <- age_sex.plot + geom_line()
    age_sex.plot <- age_sex.plot + theme(legend.title=element_blank())
    age_sex.plot <- age_sex.plot + labs(y = "Proportion (%)")
    age_sex.plot <- age_sex.plot + labs(x = "Age (years)")
    return(age_sex.plot)
  })
})
  