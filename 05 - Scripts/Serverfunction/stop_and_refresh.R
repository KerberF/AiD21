#refresh and stop app

refresh <- reactiveVal(0)
#refreshing <- reactiveVal("no refresh")

observeEvent(input$test,{
  refresh(2)
  session$reload()
  
  # https://stackoverflow.com/questions/25062422/restart-shiny-session
  
  
})



observeEvent(session,{
  onStop(end_app(refreshing <- refresh()))
     isolate(refresh(0))
  })

?session
