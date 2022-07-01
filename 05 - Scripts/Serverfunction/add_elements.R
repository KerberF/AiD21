#Adding elements for selection of element normalization during the particle classification 

output$add.element.choice <- renderUI( 
  {
    req(iv_addElement$is_valid())
    number <- as.integer(input$Elements.to.add)
    lapply(1:number, function(i)
    {
      textInput(inputId = paste("addelementchoice",i,sep=""), label = "")
    })
  })


observeEvent(input$add.element, {
  req(iv_addElement$is_valid())
  newchoices <- NULL
  number <- as.integer(input$Elements.to.add)
  var <- paste("addelementchoice",1:number,sep="")
  current_selection <- input$Elements
  for(i in var){
    newchoices <- append(newchoices, input[[i]])}
  choices.elements <- c(choices.elements, newchoices)
  updateCheckboxGroupInput(session, "Elements", choices= choices.elements, selected = current_selection)
  
  
})

#Hinzufügen von Elemente zu Elemente.0
output$add.element.choice0 <- renderUI( 
  {
    req(iv_addElement0$is_valid())
    number <- as.integer(input$Elements.to.add0)
    lapply(1:number, function(i)
    {
      textInput(inputId = paste("addelement0choice",i,sep=""), label = "")
    })
  })


observeEvent(input$add.element0, {
  req(iv_addElement0$is_valid())
  newchoices <- NULL
  number <- as.integer(input$Elements.to.add0)
  var <- paste("addelement0choice",1:number,sep="")
  current_selection <- input$Elements0
  for(i in var){
    newchoices <- append(newchoices, input[[i]])}
  choices.elements <- c(choices.elements, newchoices)
  updateCheckboxGroupInput(session, "Elements0", choices= choices.elements, selected = current_selection)
  
  
})

