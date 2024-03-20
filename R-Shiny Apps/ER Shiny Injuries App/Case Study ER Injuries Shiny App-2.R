# Set the working directory to where your files are located
setwd("R:/Shiny data")

# Load the population data
population <- read.delim("population.tsv", header = TRUE)

# Load the products data
products <- read.delim("products.tsv", header = TRUE)

# Load the injuries data
injuries <- read.delim("injuries.tsv", header = TRUE)

#Load Libraries

library(shiny)
library(vroom)
library(tidyverse)

injuries
population
products

# Exploration
selected <- injuries %>% filter(prod_code == 649)
nrow(selected)

#Basic summaries
selected %>% count(location, wt = weight, sort = TRUE)

selected %>% count(body_part, wt = weight, sort = TRUE)

selected %>% count(diag, wt = weight, sort = TRUE)

#As you might expect, injuries involving toilets most often occur at home.
# The most common body parts involved possibly suggest that these are falls
# (since the head and face are not usually involved in routine toilet usage),
# and the diagnoses seem rather varied.

#We can also explore the pattern across age and sex. We have enough data
# here that a table is not that useful, and so I make a plot

summary <- selected %>% count(age, sex, wt = weight)
summary

summary %>%
  ggplot(aes(age, n, colour = sex)) +
  geom_line() +
  labs(y = "Estimated number of injuries")

#We see a spike for young boys peaking at age 3, and then an increase
#(particularly for women) starting around middle age, and a gradual decline
#after age 80. I suspect the peak is because boys usually use the toilet
#standing up, and the increase for women is due to osteoporosis (i.e., I
#suspect women and men have injuries at the same rate, but more women
# end up in the ER because they are at higher risk of fractures).
#One problem with interpreting this pattern is that we know that there are
#fewer older people than younger people, so the population available to be
# injured is smaller. We can control for this by comparing the number of
# people injured with the total population and calculating an injury rate. Here
#I use a rate per 10,000:

summary <- selected %>%
  count(age, sex, wt = weight) %>%
  left_join(population, by = c("age", "sex")) %>%
  mutate(rate = n / population * 1e4)

#  Plotting the rate, as shown, yields a strikingly different trend
# after age 50: the difference between men and women is much smaller, and
# we no longer see a decrease. This is because women tend to live longer than
# men, so at older ages there are simply more women alive to be injured by
# toilets:

summary %>%
  ggplot(aes(age, rate, colour = sex)) +
  geom_line(na.rm = TRUE) +
  labs(y = "Injuries per 10,000 people")

selected %>%
  sample_n(10) %>%
  pull(narrative)

#  I’ve chosen to truncate the tables with a combination of forcats functions: I convert the
# variable to a factor, order by the frequency of the levels, and then lump
# together all levels after the top five:

injuries %>%
  mutate(diag = fct_lump(fct_infreq(diag), n = 5)) %>%
  group_by(diag) %>%
  summarise(n = as.integer(sum(weight)))
#  a little function to automate this for any variable.

count_top <- function(df, var, n = 5) {
  df %>%
    mutate({{ var }} := forcats::fct_lump(forcats::fct_infreq({{ var }}), n = n)) %>%
    group_by({{ var }}) %>%
    summarise(n = as.integer(sum(weight)))
}



# Prototype

prod_codes <- setNames(products$prod_code, products$title)

ui <- fluidPage(
  fluidRow(
    column(6,
           selectInput("code", "Product", choices = prod_codes)
    )
  ),
  fluidRow(
    column(4, tableOutput("diag")),
    column(4, tableOutput("body_part")),
    column(4, tableOutput("location"))
  ),
  fluidRow(
    column(12, plotOutput("age_sex"))
  )
)

# The server function is relatively straightforward. I first convert the static
# selected and summary variables to reactive expressions. This is a
# reasonable general pattern: you create variables in your data analysis to
# decompose the analysis into steps and to avoid recomputing things multiple
# times, and reactive expressions play the same role in Shiny apps.

server <- function(input, output, session) {
  selected <- reactive(injuries %>% filter(prod_code ==
                                             input$code))
  output$diag <- renderTable(count_top(selected(), diag), width =
                               "100%")
  output$body_part <- renderTable(count_top(selected(),
                                            body_part), width = "100%")
  output$location <- renderTable(count_top(selected(), location),
                                 width = "100%")
  summary <- reactive({
    selected() %>%
      count(age, sex, wt = weight) %>%
      left_join(population, by = c("age", "sex")) %>%
      mutate(rate = n / population * 1e4)
  })
  output$age_sex <- renderPlot({
    summary() %>%
      ggplot(aes(age, n, colour = sex)) +
      geom_line() +
      labs(y = "Estimated number of injuries")
  }, res = 96)
}

#ShinApp
# Run the app
shinyApp(ui, server)

