library(shiny)

#ui.R for a simple application that estimates your base
#metabolic rate (base calorie consumption) using information
#you provide yourself, and a standard estimator (which one is
#used depends on the data you provide.)

shinyUI(fluidPage(
    titlePanel("Baseline (resting) Calorie estimator"),
    sidebarLayout(
        sidebarPanel(

            "Documentation: Enter your personal information (where % body ",
            "fat is optional; leave as 0 or blank if you don't know). ",
            "Your estimated resting calorie consumption is updated ",
            "on the right, as well as the name of the estimator used.",
            hr(),
            h4("Your information:"),
            hr(),
            radioButtons(
                "gender",
                label=("Gender:"),
                choices=list("Male" = 1, "Female" = 2),
                selected = 1
                ),
            sliderInput(
                "weight",
                label=h3("Weight (lbs):"),
                min = 50,
                max = 400,
                value = 150
                ),
            # It's a bit silly to pick age from a pull-down menu,
            # but I wanted to play around with possibilities
            selectInput("age",
                        label = "Age:",
                        choices = seq(10,100,1),
                        selected = 20
                        ),
            # Ditto
            selectInput("height",
                        label = "Approximate height (feet):",
                        choices = seq(3,7,.1),
                        selected = 5
                        ),
            # Entering 0 or blank or a crazy value (< 5, > 50)
            # will cause us to ignore the input and use a method
            # that does not use this value
            numericInput(
                "bfp",
                label = h5("Enter % Body Fat if known"),
                value=""
                )
            ),
        mainPanel(
            h4("Answer:"),
            textOutput("bmr"),
            br(),
            br(),
            br(),
            br(),
            textOutput("ctr")
            )
        )
    )
)
