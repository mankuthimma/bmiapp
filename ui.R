library(shiny) 

shinyUI(
  pageWithSidebar(
    headerPanel("BMI (Body Mass Index) App"),
    
    sidebarPanel(
      numericInput('weight', 'Insert your weight in kilograms', 75) ,
      numericInput('height', 'Insert your height in metres', 1.70, min = 0.2, max = 3, step = 0.01),
      submitButton('Submit'),
      h3("BMI"),
      p('The body mass index (BMI), or Quetelet index, is a measure of relative size based on the mass and height of an individual.'),

      p('Reference:'),
      tags$div(
        tags$ul(
          tags$li('BMI <18.5       : Underweight'),
          tags$li('BMI [18.5-24.9] : Normal weight'),
          tags$li('BMI [25-29.9]   : Overweight'),
          tags$li('BMI >=30        : Obesity')
        )
      )
    ), 
    mainPanel(
      plotOutput('bmiplot'), 
      h4('Your results:'), 
      p('weight:'), verbatimTextOutput("inputweightvalue"),
      p('height:'), verbatimTextOutput("inputheightvalue"),
      h4('Your BMI is:'),
      verbatimTextOutput("estimation"),
      p('It means that you are:'),strong(verbatimTextOutput("diagnostic"))
      
      
    )
    
  )   
)