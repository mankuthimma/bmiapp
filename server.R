library(shiny) 

require(utils)



BMI<-function(weight,height) {weight/(height^2)}

diagnostic_f<-function(weight,height){
  BMI_value<-weight/(height^2)
  ifelse(BMI_value<18.5,"underweight",ifelse(BMI_value<25,"normal weight",ifelse(BMI_value<30,"overweight","obese")))
}

shinyServer(
  function(input, output) {
    
    output$inputweightvalue <- renderPrint({input$weight})
    output$inputheightvalue <- renderPrint({input$height})
    output$estimation <- renderPrint({BMI(input$weight,input$height)})
    output$diagnostic <- renderPrint({diagnostic_f(input$weight,input$height)})
    
    output$bmiplot <- renderPlot({
      ht <- seq(1.20, 2.15, length.out=1000)
      wt <- seq(40, 135, length.out=1000)
      wtht <- expand.grid(x=ht, y=wt)
      bmi <- function(h,w) {(w)/(h*h)}
      bmiwtht <- matrix(bmi(wtht$x, wtht$y),length(ht),length(wt))
      
      contour(ht,wt,bmiwtht,levels = c(18.5,25,30), drawlabels=FALSE, xlab="Height (metres)",ylab="Weight (kgs)", main="BMI and You!")
      
      points(input$height, input$weight, pch=15, col="#000000", cex=2)
      text(input$height+0.06, input$weight, "Your BMI", col="#000000", cex=0.8)
      
      text(1.5, 75, "Obese", cex=1, srt=38, col="#ff0000")
      text(1.6, 70,"Overweight",cex=1,srt=30, col="#8A0808")
      text(1.6, 56,"Normal",cex=1,srt=20, col="#00AA00")
      text(1.7, 46,"Underweight",cex=1,srt=18, col="#0000AA")
    })
  } 
)