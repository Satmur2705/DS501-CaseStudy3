library(DT)
library(shiny)
library(shinythemes)
library(ggplot2)
library(ggpubr)
library(ggfortify)
library(reactable)

       
# Import Data
Pokemon = read.csv("pogo.csv")
Characteristics = names(Pokemon)
AxisOptions = Characteristics[2:11]
PokeName = Pokemon[,1]

# User Interface
ui = fluidPage(
  # Select the App Theme with shinythemes library
  theme = shinytheme("superhero"),
              # Add the Pokemon Go Logo in the upper left corner
               titlePanel(tags$img(height = 100, 
                                   width = 300, 
                                   src = "PokemonGoLogo.png"
                                   )
                          ),
              # Make the Navigation Bar
               navbarPage(title = tags$span("Kisa's Research Laboratory",
                                            class = "text-info"),
                          # Layout the Home page tab
                          tabPanel(title = icon("home"),
                                   wellPanel(
                                   tags$p(tags$h3(tags$b("Welcome to My Research Laboratory",
                                          class = "text-info"))),
                                   tags$br(),
                                   
                                   tags$p(tags$h5("My name is Kisa and I am a fellow Pokemon Go 
                                                  trainer, just like you! I built this 
                                                  laboratory so we can research Pokemon
                                                  by grouping them based on their stats and 
                                                  characteristics, and by analyzing the trends
                                                  between those stats and characteristics.")),
                                   tags$p(tags$h5("The available stats and characteristics are 
                                                  listed below with a brief description.")),
                                   tags$ol(tags$b("PokedexID:",
                                                  class = "text-info"), 
                                                  "Each Pokemon has a unique number which is its PokedexID."),
                                   tags$ol(tags$b("Stamina:",
                                                  class = "text-info"), 
                                                  "This is the base health stat of a Pokemon."),
                                   tags$ol(tags$b("Attack:",
                                                  class = "text-info"), 
                                                  "This is the base damage output stat of a Pokemon."),
                                   tags$ol(tags$b("Defense:",
                                                  class = "text-info"), 
                                                  "This is the base damage resistance of a Pokemon 
                                                  against another Pokemon's attack."),
                                   tags$ol(tags$b("MaxHP:",
                                                  class = "text-info"), 
                                                  "HP stands for Hit Points. This stat is the 
                                                  amount of damage a Pokemon can take before it faints. 
                                                  It is also referred to as a Pokemon's health."),
                                   tags$ol(tags$b("MaxCP:",
                                                  class = "text-info"), 
                                                  "CP stands for Combat Points. This stat is a 
                                                  good reference to see how strong a Pokemon is overall."),
                                   tags$ol(tags$b("Capture_rate:",
                                                  class = "text-info"), 
                                                  "This is the probability that you will 
                                                  capture a Pokemon when you encounter it."),
                                   tags$ol(tags$b("Escape_rate:",
                                                  class = "text-info"), 
                                                  "This is the probability that a Pokemon
                                                  will run away after you try to catch it."),
                                   tags$ol(tags$b("Weight_kg:",
                                                  class = "text-info"), 
                                                  "This is how much a Pokemon weighs in units of 
                                                  kilograms."),
                                   tags$ol(tags$b("Height_m:",
                                                  class = "text-info"), 
                                                  "This is how tall a Pokemon is in units of meters."),
                                   tags$ol(tags$b("Gen:",
                                                  class = "text-info"), 
                                                  "Gen stands for Generation. This generation has a numeric 
                                                  based on when they were released/discovered. Most Pokemon in
                                                  Generations 1 through 5 can be studied here."),
                                  
                                   tags$br(),
                                   tags$p(tags$h4("The lab is divided into two sections: 'Grouping' and 'Trends'",
                                                  class = "text-info")),
                                   tags$p(tags$h5("In the 'Grouping' section of the lab, you will be able to select 
                                                  the Gens you want to investigate and any two of the stats or
                                                  characteristics listed above. Then you can select the number of 
                                                  groups you would like to divide the Pokemon into. This division
                                                  is performed through the non-bias mathematical process known as
                                                  k-means clustering. The graph display will only be colored dots, but 
                                                  if you click on those dots, the name of the Pokemon and all their
                                                  stats and characteristics will be displayed below the graph.")),
                                   tags$p(tags$h5("In the 'Trends' section of the lab, you will again be able to select 
                                                  the Gens you want to investigate and any two of the stats or
                                                  characteristics listed above. The main display section will give 
                                                  you information as to what the relationship is between the two 
                                                  stats or characteristics. The relationship is determined using 
                                                  Linear Regression, which is only valid if its four assumptions are
                                                  met. If you scroll down, the lab will walk you through each assumption
                                                  so you can determine if the information you are getting is correct.")),
                                   
                                   tags$br(),
                                   tags$p(tags$h4("The Active Pokedex is also divided into two sections: 'Image Database' 
                                                  and 'Info Database'",
                                                  class = "text-info")),
                                   tags$p(tags$h5("In the ", 
                                          tags$em("Image Database"), 
                                                  ", you can select any Pokemon by clicking its name
                                                  from the dropdown or typing in the desired name. As you type the drop down 
                                                  will filter to assist you. Once you have selected a Pokemon, an image of 
                                                  that Pokemon will be displayed.")),
                                   tags$p(tags$h5("In the ", 
                                          tags$em("Info Database"), 
                                                  ", you will be able to see all the info I have 
                                                  collected thus far, including some characteristics that are not listed
                                                  above. You will be able to explore, search, and filter an interactive 
                                                  table for a broader picture of each Pokemon.")),
                                   
                                   tags$br(),
                                   tags$p(tags$h4(tags$em("So, head over to the lab or the Pokedex and see what you
                                                  can learn about the world of Pokemon!",
                                                  class = "text-info"))),
                                   
                                   tags$br(),
                                   tags$p(tags$h4(tags$b("Please Note:", 
                                                         class = "text-danger"))),
                                   tags$p(tags$h5(tags$b("This website site is only the final project of a Master's 
                                                  Intro to Data Science course and a fan-based interactive
                                                  learning experience.",
                                                  class = "text-danger"))),
                                   tags$p(tags$h5(tags$b("Pokemon is owned by The Pokemon Company, et al. and the 
                                                  Pokemon Go game is property of Niantic. The dataset and 
                                                  images used on this site are from Kaggle.com, dimensaotech.com,
                                                         or found with a basic web image search.",
                                                  class = "text-danger"))),
                                   tags$p(tags$h5(tags$b("This site does not claim to own any of the content found 
                                                  here. Please support the official games, franchises, and 
                                                  websites.",
                                                  class = "text-danger"))),
                                   tags$p(tags$img(height = 50,
                                                   width = 225,
                                                   src = "PokemonComapny.png"),
                                          tags$img(height = 75,
                                                   width = 62.5, 
                                                   src = "Niantic.png"), 
                                          tags$img(height = 50,
                                                   width = 100,
                                                   src = "kaggle.png"))
                                   )
                                   ),
                          
                          # "The Lab" will be a drop down menu to jump between Grouping/Clustering and Trend lines tabs
                          navbarMenu("The Lab", 
                                     
                                     # Define the Grouping/Clustering Plot/Page of "The Lab"
                                     tabPanel("Grouping",                                              
                                              wellPanel(
                                              
                                              # Define the layout with the sidebarLayout Code
                                                sidebarLayout(
                                                  # Start Defining the Sidebar sections
                                                  sidebarPanel(
                                                    # Give the Sidebar section a Title
                                                    tags$h3(
                                                      tags$b("Desired Characteristics",
                                                             class = "text-info"
                                                             )
                                                      ),
                                                    # Select Generations Section
                                                    checkboxGroupInput(inputId = "GenFinder",
                                                                       label = tags$h5("Select Desired Generation(s):"),
                                                                       choices = c("Gen_1" = "1",
                                                                                   "Gen_2" = "2",
                                                                                   "Gen_3" = "3",
                                                                                   "Gen_4" = "4",
                                                                                   "Gen_5" = "5"),
                                                                       selected = c("1", "2", "3", "4", "5")
                                                                       ),
                                                    # Add the Update Button for changes in Gen Selection
                                                    tags$button(id = "Button", 
                                                                type = "button", 
                                                                class = "btn action-button btn-success", 
                                                                tags$h5(icon("refresh"), 
                                                                        tags$b("Update Graph")
                                                                        )
                                                                ),
                                                    tags$p(),
                                                    
                                                    # Select X Axis Characteristic Section
                                                    selectInput(inputId = "XAxis",
                                                                label = tags$h5("Characteristic #1 (X Axis)"),
                                                                choices = AxisOptions,
                                                                selected = "Attack",
                                                                width = "220px"
                                                                ),
                                                    
                                                    # Select Y Axis Characteristic Section
                                                    selectInput(inputId = "YAxis",
                                                                label = tags$h5("Characteristic #2 (Y Axis)"),
                                                                choices = AxisOptions,
                                                                selected = "Stamina",
                                                                width = "220px"
                                                                ),
                                                    
                                                    # Select Groups AKA Cluster(s) Sections
                                                    selectInput(inputId = "clusters",
                                                                label = tags$h5("Number of Groups"),
                                                                choices = c("1", "2","3","4","5","6","7","8"),
                                                                selected = "3",
                                                                width = "220px"
                                                                ),
                                                    # Define Width of the sidebar section and close Sidebar code
                                                    width = 3
                                                    ),
                                                  
                                                  # Define Main Panel Layout
                                                  mainPanel(
                                                    # Give the Main Panel section a Title
                                                    tags$h2(
                                                      tags$b("Grouping Pokemon By Desired Characteristics",
                                                             class = "text-info"
                                                             )
                                                      ),
                                                    # Output the clustering plot and define the click input
                                                    plotOutput("plot1", click = "plot_click"),
                                                    # Output the text produced by the click input
                                                    verbatimTextOutput("info"),
                                                    # Define the Main Panel width
                                                    # Does not sum to 12 for more even spacing
                                                    width = 8)
                                                  )
                                                ),
                                              # Describe what you should take away from this
                                              wellPanel(
                                                tags$p(tags$h4("What does this mean?",
                                                               class = "text-info")),
                                                tags$p(tags$h5("This graph essentially allows you to group your Pokemon for 
                                                               better understanding.")),
                                                tags$p(tags$h5("For example: The default plot Stamina VS Attack and has 3 groups, 
                                                               this allows you to get an idea of which Pokemon you may want to use 
                                                               in battle. If you are looking for Pokemon with lots of Attack power, 
                                                               you would look at the right most part of the graph. If you click on 
                                                               the right most dot, you will see it is Deoxys. In comparison to many 
                                                               other Pokemon in this color group, Deoxys has very low Stamina, meaning
                                                               it will not live very long in a fight. He is also known as a glass
                                                               cannon. In contrast, if you look at the highest point near the 300
                                                               Attack line, you will see that Slaking has more Attack and more
                                                               stamina than most other Pokemon overall. Maybe you should consider 
                                                               powering up a couple of your Slaking?")),
                                                tags$br(),
                                                tags$p(tags$h4("Why care about the number if groups?",
                                                               class = "text-info")),
                                                tags$p(tags$h5("You may not know it but you can group information
                                                               incorrectly. A mathematical way to know you have 
                                                               grouped a set of numerical data correctly is to use
                                                               a statistical tool called K-means clustering. In the 
                                                               graph, above the groups shown in different colors are 
                                                               the different clusters that were mathematically 
                                                               formulated behind the scenes. Every time you change 
                                                               the number of groups, you are changing the value of K, 
                                                               and thus changing number of clusters that were calculated.")),
                                                tags$p(tags$h5("If you would like to learn more about how K-means 
                                                               clustering works, check out the link below.")),
                                                tags$p(tags$h5(tags$ol(tags$a(href="https://www.youtube.com/watch?v=4b5d3muPQmA",
                                                                      "K-Means Clustering Explained by StatQuest",
                                                                      class = "text-success"))))

                                              )
                                              ),
                                     
                                     # Define the Trends and Correlation Plot/Page of "The Lab"
                                     tabPanel("Trends",
                                              wellPanel(
                                                
                                              #Define the layout with the sidebarLayout Code 
                                              sidebarLayout(
                                                # Start Defining the Sidebar sections
                                                sidebarPanel(
                                                  # Give the Sidebar section a Title
                                                  tags$h3(
                                                    tags$b("Desired Characteristics",
                                                           class = "text-info"
                                                           )
                                                    ),
                                                  # Select Generations Section
                                                  checkboxGroupInput(inputId = "GenFinder2",
                                                                     label = tags$h5("Select Desired Generation(s):"),
                                                                     choices = c("Gen_1" = "1",
                                                                                 "Gen_2" = "2",
                                                                                 "Gen_3" = "3",
                                                                                 "Gen_4" = "4",
                                                                                 "Gen_5" = "5"),
                                                                     selected = c("1", "2", "3", "4", "5")
                                                                     ),
                                                  # Add the Update Button for changes in Gen Selection Section
                                                  tags$button(id = "Button2",
                                                              type = "button",
                                                              class = "btn action-button btn-success",
                                                              tags$h5(icon("refresh"),
                                                                      tags$b("Update Graph")
                                                                      )
                                                              ),
                                              tags$p(),
                                              
                                              # Select X Axis Characteristic Selection
                                              selectInput(inputId = "IndepVar",
                                                          label = tags$h5("Independent Variable (X Axis)"),
                                                          choices = AxisOptions,
                                                          selected = "Attack",
                                                          width = "220px"
                                                          ),
                                              
                                              # Select Y Axis Characteristic 
                                              selectInput(inputId = "DepVar",
                                                          label = tags$h5("Dependent Variable (Y Axis)"),
                                                          choices = AxisOptions,
                                                          selected = "Stamina",
                                                          width = "220px"
                                                          ),
                                              # Define Width of the sidebar section and close Sidebar code
                                              width = 3
                                              ),
                                              
                                            # Define Main Panel Layout
                                            mainPanel(
                                              # Give the Main Panel section a Title
                                              tags$h2(
                                                tags$b(textOutput("TitlePlot2"),
                                                       class = "text-info"
                                                       )
                                                ),     
                                              # Output the correlation plot 
                                              plotOutput("plot2"
                                                         ),
                                              # Output the correlation data
                                              verbatimTextOutput("trendinfo"),
                                              # Define the Main Panel width and close Main Panel code
                                              # Does not sum to 12 for more even spacing
                                              width = 8)
                                            )
                                            ),
                                            # Step 1 to See if Linear Regression is appropriate
                                            wellPanel(
                                              tags$p(tags$h3("What does this mean?",
                                                             class = "text-info")),
                                              tags$p(tags$h4(tags$b("First let's look at the equation printed on the graph.",
                                                                    class = "text-info"))),
                                              tags$p(tags$h5("The equation is the linear regression line of the data. 
                                                             The  R^2 is not part of the equation, but a separate value
                                                             known as the Coefficient of Determination. This value tells 
                                                             you how strong your causality relationship is between the 
                                                             selected characteristics. The R^2 value will always be between 
                                                             0 and 1. A value of 0 or close to it means there is no 
                                                             relationship between the two variables. The closer the 
                                                             value is to 1, the higher the likelihood the X Axis 
                                                             Variable has a direct causality relationship with the 
                                                             Y Axis Variable. When there is a relationship, the slope 
                                                             of the regression line will tell you how the variables
                                                             change in reference to each other. The slope is the number 
                                                             in front of the x in the equation displayed. This means 
                                                             that every time the X Axis Variable increases by 1, the Y 
                                                             Axis Variable will change equal to slope.")),
                                                tags$p(tags$h5("For example: If the slope is -1.5, then every 
                                                             time the X Axis Variable increases by 1 the Y Axis 
                                                             Variable will decrease by 1.5.")),
                                                tags$br(),
                                                tags$p(tags$h4(tags$b("Next let's look at the information displayed below the 
                                                               graph.",
                                                                      class = "text-info"))),
                                                tags$p(tags$h5("All this information is useful to someone studying math
                                                               and statistics, but the Pr(>|t|) or P value listed in the 
                                                               Coefficients section is the most important value for our 
                                                               general user. What we want to see is the Pr(>|t|) or P value 
                                                               to be less than 0.001. If this is the case, then we can 
                                                               conclude with at least some certainty that this data 
                                                               relationship is NOT purely due to random chance. In other words,
                                                               the Independent Variable has a relationship or correlation 
                                                               to the Dependent Variable.")),
                                                tags$p(tags$h5("For example: Let's look at the default graph above with
                                                               Attack as the Independent Variable and Stamina as the 
                                                               Dependent Variable with all 5 Gens selected. If you look
                                                               at the Coefficients section, you will see the P value is 
                                                               less than 2x10^-16. This is an extremely small number and 
                                                               is certainly less than our 0.001 limit. Therefore, it is not by 
                                                               random chance that the values of Attack and Stamina are 
                                                               what they are and have the relationship they do. BUT! Note 
                                                               that the R^2 value is very small, only 0.17. This means that 
                                                               the value of a Pokemon's Attack does NOT cause a direct change 
                                                               to the Pokemon's Stamina. Therefore, there is a correlation 
                                                               relationship, but there isn't a causality relationship. If this 
                                                               concept is confusing, to you check out the link below to help 
                                                               explain the difference between correlation and causality, which
                                                               is calculated with regression.")),
                                                tags$p(tags$h5(tags$ol(tags$a(href1="https://www.youtube.com/watch?v=QzY4roUb3HM",
                                                                            "Correlation vs Regression",
                                                                            class = "text-success")))),

                                                tags$br(),
                                                tags$p(tags$h4("It is important to note that this form of analysis is
                                                               only valid if 4 assumptions are valid. These assumptions
                                                               are:",
                                                               class = "text-info")),
                                                tags$p(tags$h5(tags$ol("1. Independence of Observations"))),
                                                tags$p(tags$h5(tags$ol("2. Normality"))),
                                                tags$p(tags$h5(tags$ol("3. Linearity"))),
                                                tags$p(tags$h5(tags$ol("4. Homoscendasticity"))),
                                                tags$p(tags$h5("Let's review each of these for current selected variables
                                                               and determine if a linear regression trend is appropriate.")),
                                                tags$p(tags$h5(tags$b("NOTE:"), "If any of these four assumptions are violated,
                                                               the data that is outputted will be incorrect and should be ignored."))
                                            ),
                                            wellPanel(
                                              tags$p(tags$h4("1. Independence of Observation",
                                                             class = "text-info")),
                                              tags$p(tags$h5("This assumption means the data should not have any 
                                                             hidden relationships. This could happen if we had multiple 
                                                             MaxHP's for a single Pokemon. Each Pokemon only has one 
                                                             value for each stat and this graph only plots one 
                                                             independent variable (X Axis) against the one dependent 
                                                             variable (Y Axis). This is why the first assumption is 
                                                             automatically satisfied."))
                                              ),
                                            wellPanel(
                                              fluidRow(
                                                column(width = 12,
                                              tags$p(tags$h4("2. Normality",
                                                                     class = "text-info")),
                                              tags$p(tags$h5("We can check the normality of the dependent variable 
                                                             by generating a histogram of the data. If the graph 
                                                             looks like it has a hump in it, it has normality."))
                                              ),
                                              column(width = 10,
                                              plotOutput("hist"
                                                         ),
                                              offset = 1
                                              ),
                                              column(12,
                                              tags$p(tags$h5("If you review the histogram with all 5 Gens selected and
                                                             change the Y Axis Characteristic to each dependent variable, 
                                                             you will see that the PokedexID and MaxCP do not have any 
                                                             reasonable hump in the graph. This means that you should 
                                                             ignore any relations you see when the either PokedexID or 
                                                             MaxCP are chosen for the Y Axis Variable."))
                                              )
                                              )
                                              ),
                                            wellPanel(
                                              tags$p(tags$h4("3. Linearity",
                                                             class = "text-info")),
                                              tags$p(tags$h5("This means that the data spreads across the graph
                                                             from left to right in a pattern similar to a straight
                                                             line.")),
                                              tags$p(tags$h5("For example: If you select MaxCP for the Independent
                                                             Variable and MaxHP for the Dependent Variable, you will
                                                             be able to see a clear line of data points spanning the 
                                                             graph. In contrast, if you select Stamina for the 
                                                             Independent Variable and Capture_rate as the Dependent
                                                             Variable, you will see a large cluster of points 
                                                             in the middle section of the graph. This data would fail
                                                             the Linearity assumption."))
                                              ),
                                            wellPanel(
                                              fluidRow(
                                                column(12, 
                                              tags$p(tags$h4("4. Homoscendasticity",
                                                             class = "text-info")),
                                              tags$p(tags$h5("The word Homoscendasticity is just a fancy statistics word
                                                             that states that the data we are using is centered around
                                                             an overall average value. We can check this easily with plots 
                                                             displayed below."))
                                              ),
                                              column(10,
                                              plotOutput("HomoPlots"),
                                              offset = 1),
                                              column(12,
                                              tags$p(tags$h5("You can tell if the data is homoscendasticity by looking at 
                                                             the Residuals vs Fitted, the Scale-Location, and the Residual 
                                                             vs Leverage graphs. For all of these graphs you want the blue 
                                                             line to be as straight and flat as possible. The blue line
                                                             on the two Residual graphs should also be as close as possible
                                                             to the black dotted line.")),
                                              tags$p(tags$h5("For example: Look at the plots with Attack as the Independent 
                                                             Variable and Stamina as the 
                                                             Dependent Variable and all 5 Gens selected. When you look at 
                                                             the three plots with blue lines, you can see that they are all
                                                             mostly flat and straight. The blue lines on the two Residual 
                                                             graphs are also pretty close to the black dotted line. Therefore,
                                                             this data is homoscendasticity.")),
                                              tags$p(tags$h5("Now change the Independent Variable to Capture_rate and 
                                                             keep Stamina as the Dependent Variable with all 5 Gens selected. 
                                                             When you look at the three plots with blue lines, you can see 
                                                             that the blue lines are not flat and straight. They also deviate 
                                                             from the black dotted lines quite a bit as well. Therefore,
                                                             this data is NOT homoscendasticity."))
                                              )
                                              )
                                              )
                                            )
                                     ),
                                            
                                     # Layout the Active Pokedex tab 
                                     tabPanel(title = "Active Pokedex", 
                                              wellPanel(
                                                tags$p(tags$h3("Kisa's Active Pokedex",
                                                               class = "text-info")),
                                                tags$p(tags$h5("This Pokedex only contains information on the Pokemon this trainer 
                                                              has been able to research. There are many other Pokemon out there 
                                                              but they have not been studied yet.")),
                                                tags$p(tags$h5("The Pokedex is made up of an Image Database and an Info 
                                                             Database. The Image Database allows you to select any Pokemon
                                                             in the Pokedex to see an image of it. The Info Database 
                                                             contains all the stats and information used in this laboratory.")), 
                                                tags$p(tags$h5("Please enjoy exploring the Image and Info Databases below.")),
                                                ),
                                              #Pick a pokemon and display image,
                                              wellPanel(
                                                tags$h3("Pokemon Image Database",
                                                        class = "text-info"),
                                                sidebarLayout(
                                                  sidebarPanel(
                                                    selectInput(
                                                      inputId = "PokeImageSelect",
                                                      label = tags$h5("Select A Pokemon:"),
                                                      choices = PokeName,
                                                      selected = "Bulbasaur",
                                                      width = "220px"
                                                      )
                                                    ),
                                                  mainPanel(
                                                    textOutput(outputId = "PName"),
                                                    uiOutput(outputId = "PPic")
                                                    )
                                                  )
                                                ),
                                              wellPanel(
                                                tags$h3("Pokemon Info Database",
                                                        class = "text-info"),
                                                fluidRow(
                                                  column(12,
                                                         tags$div(
                                                         dataTableOutput("Pokedex"),
                                                         class = "card text-white bg-info mb-3"
                                                         )
                                                         )
                                                  )
                                                )
                                              ),
                                     
                                     # Layout the Hints and Tips tab
                                     tabPanel(title = "Hints and Tips",
                                              wellPanel(
                                              tags$p(tags$h4("For the Trends Lab:",
                                                              class = "text-info")),
                                              tags$p(tags$h5("If you would like to understand the meaning of the other values 
                                                             displayed under the graph, check out the link below.")),
                                              tags$p(tags$h5(tags$ol(tags$a(href="http://www.learnbymarketing.com/tutorials/linear-regression-in-r/",
                                                                            "Linear Regression Summary Data Walkthrough",
                                                                            class = "text-success")))),
                                              tags$br(),
                                              tags$p(tags$h5("When checking the assumptions for linear regression, if 
                                                                       you are not sure if the data has Normality, check the 
                                                                       Normal Q-Q graph under the homoscendasticity section. If
                                                                       the data makes a reasonably straight line, the data can 
                                                                       be considered Normal and satisfies the Normality requirement."))
                                                        ),
                                              wellPanel(
                                                tags$p(tags$h4("Other Links:",
                                                               class = "text-info")),
                                                tags$p(tags$h5("Pokemon Go logo is from", tags$a(href="https://www.dimensaotech.com/2016/08/testamos-pokemon-go-e-bom-mas-poderia-ser-melhor/", 
                                                                                              "here",
                                                                                              class = "text-success"))),
                                                tags$p(tags$h5("Pokemon dataset is from", tags$a(href="https://www.kaggle.com/netzuel/pokmon-go-dataset-15-generations", 
                                                                                                 "here",
                                                                                                 class = "text-success"))),
                                                tags$p(tags$h5("Pokemon images are from", tags$a(href="https://www.kaggle.com/vishalsubbiah/pokemon-images-and-types", 
                                                                                                 "here",
                                                                                                 class = "text-success"))),
                                                tags$p(tags$h5("The Pokemon Company logo is from", tags$a(href="https://en.wikipedia.org/wiki/File:The_Pok%C3%A9mon_Company_International_logo.svg", 
                                                                                                 "here",
                                                                                                 class = "text-success"))),
                                                tags$p(tags$h5("The Niantic logo is from", tags$a(href="https://en.wikipedia.org/wiki/Niantic_(company)", 
                                                                                                          "here",
                                                                                                  class = "text-success"))),
                                                tags$p(tags$h5("The Kaggle logo is from", tags$a(href="https://www.exastax.com/big-data/top-20-data-science-blogs-websites/", 
                                                                                                  "here",
                                                                                                 class = "text-success"))),
                                              ),
                                              wellPanel(
                                                fluidRow(column(12,
                                                                tags$p(tags$h4("May Uxie, The Bringer of Knowledge, make all things clear!",
                                                                        class = "text-info")),
                                                                tags$img(height = 200,
                                                                            src = "TheEnd.png")))
                                                
                                              )
                                              )
                          )
  )

               
               

# Server Code
server = function(input, output) {
  
  # Bring in the Pokemon dataset and make it a reactive data frame for plot1
  Pdata = Pokemon
  makeReactiveBinding("Pdata")
  
  # Update and filter the reactive Pokemon dataset based on Gen selection for plot1
  # Only occurs when update button is pushed
  newPData = reactive({
    input$Button
    isolate({
      Pdata = Pokemon
      Pdata = subset(Pdata, Gen %in% input$GenFinder)
      })
    }) 
  
  # Define the Clustering plot
  # Use the filtered dataset based on Generation Selection
  output$plot1 = renderPlot({
    Pdata = newPData()
    
    # Select the Desired X and Y characteristics per user input
    selectedData = reactive({
      Pdata[,c(input$XAxis, input$YAxis)]
      })
    
    # Perform K Means clustering
    km = reactive({
      kmeans(selectedData(), input$clusters)
      })
    selectedData_clustered = reactive({
      data.frame(selectedData(), 
                 cluster=factor(km()$cluster)
                 )
      })
    
    # Define color palette
    palette(c("#999999", "#E69F00", "#56B4E9", "#009E73", 
              "#F0E442", "#0072B2", "#D55E00", "#CC79A7"))
    
    # Define ggplot output for clustering plot
    ggplot(selectedData_clustered(),
           aes_string(x=input$XAxis, 
                      y=input$YAxis, 
                      color=selectedData_clustered()$cluster)) +
      geom_point() +
      theme_minimal() +
      labs(colour = "Group") +
      scale_colour_manual(values = c("#999999", "#E69F00", "#56B4E9", "#009E73", 
                                     "#F0E442", "#0072B2", "#D55E00", "#CC79A7")) +
      scale_colour_hue(c=80, l=60)
    })
  
  # Define the information that gets outputed when clustering plot is clicked
  output$info = renderPrint({
    Pdata = newPData()
    info = nearPoints(Pdata, input$plot_click,
                      xvar = input$XAxis, 
                      yvar = input$YAxis,
                      threshold = 10, 
                      maxpoints = 5)
    cat("Click the plot to see the nearest Pokemon and their Stats:\n")
    print(info)
    })
  

  
  # Update plot2 Title based on user input
  output$TitlePlot2 = renderText({
    paste(
    "The Direct Relationship of", 
    input$IndepVar,
    "on",
    input$DepVar)
    })
  
  # Bring in the Pokemon dataset and make it a reactive data frame for plot2
  Pdata2 = Pokemon
  makeReactiveBinding("Pdata2")
  
  # Define and filter the reactive Pokemon dataset based on Gen selection for plot2
  # Only occurs when update button is pushed
  PokemonData2 = reactive({
    input$Button2
    isolate({
      Pdata2 = Pokemon
      Pdata2 = subset(Pdata, Gen %in% input$GenFinder2)
    })
  }) 
  
  # Define trend plot
  # Use the filtered dataset based on Generation Selection
  output$plot2 = renderPlot({

    # Define ggplot output for regression plot with formula and R2
    ggplot(PokemonData2(),
           aes_string(x=input$IndepVar, 
                      y=input$DepVar)) +
      geom_point(aes(colour = factor(Gen))) +
      geom_smooth(method = "lm") +
      stat_regline_equation(
        aes(label = paste(..eq.label..,..rr.label..,sep = "~~~")
            ),
        size = 6,
        colour = "Navy"
            ) +
      theme_minimal() +
      labs(colour = "Gen") +
      scale_colour_manual(values = c("#999999",
                                     "#E69F00", 
                                     "#56B4E9", 
                                     "#009E73",
                                     "#F0E442")) +
      scale_colour_hue(c=80, l=60)
    })
  
# Display Regression Information
  lmData = reactive({
    lm(reformulate(input$IndepVar, input$DepVar), data = PokemonData2())
  })
    
  output$trendinfo = renderPrint({
    summary(lmData())
    })


# Normality Plot
 output$hist = renderPlot({
  ggplot(PokemonData2(), aes_string(x=input$DepVar)) + 
    geom_histogram(stat = "count",
                   binwidth = 1)
})

# Homoscendasticity plots
output$HomoPlots = renderPlot({
    autoplot(lmData())
})

# POkemon Image selection
Name = reactive({
  input$PokeImageSelect
})

output$PName = renderText({
  print(Name())
  })

output$PPic = renderUI({
  src = paste(tolower(Name()), '.png', sep = '')
  img(src=src, height = '250px')
})


# Pokedex Generation
output$Pokedex = renderDataTable({
  datatable(Pokemon,
            rownames = FALSE,
            class = "cell-border stripe",
            filter = "top")
})

}

# Launch App
shinyApp(ui = ui, server = server)
