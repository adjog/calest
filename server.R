library(shiny)

userCount = 0

#server.R for a simple application that estimates your base
#metabolic rate (base calorie consumption) using information
#you provide yourself, and a standard estimator (which one is
#used depends on the data you provide.)
#It could be improved by adding more estimators, and then
#combining all applicable estimators somehow.
#Another improvement would be to take other units, e.g. metric,
#but right now weights must be in lb and height in feet (possibly fractional)


shinyServer(
    
    function(input, output) {
        
        userCount = userCount + 1

        output$bmr = renderText(
           {
               if (!is.na(input$bfp) &&
                   input$bfp >= 5 &&
                   input$bfp < 50) {
                  method = "Katch-McArdle"
                  bmr = 370 + 9.78 * ((100.0 - input$bfp)/100) * input$weight
               }
               else {
                   method = "Mifflin-St Jeor method"
                   bmr =
                       4.48 * input$weight +
                           187 * as.numeric(input$height) +
                               4.92 * as.numeric(input$age) +
                                   5
                   if (input$gender == 2) {
                       bmr = bmr - 166
                   }
               }
               sprintf("%.0f calories - estimated using the %s method",
                       bmr,
                       method)
           })

            output$ctr = renderText({
                sprintf("(You are user #%d)", userCount)
            })
    })
