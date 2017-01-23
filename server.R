

# Define server logic required to draw a histogram
shinyServer(function(input, output) {


  output$Gplot <- renderPlot({

  noobs <- input$slider
  Gshape <- input$shapeIn
  Gscale <- input$scaleIn

  # generate sample of random gamma variables

  Gdata <- data.frame(rgamma(input$slider,
                             shape = input$shapeIn,
                             scale = input$scaleIn))
  names(Gdata) <- c("Gdata")

  #   sample statistics
   samplestats <- Gdata %>%
    summarize(samplemean = round(mean(Gdata), 2),
               samplestdev = round(sd(Gdata), 2),
               samplevar = round(var(Gdata), 2),
               expmean = Gshape * Gscale,
               expstddev = sqrt(Gshape * Gscale ^ 2),
               expvar = Gshape * Gscale ^ 2)

   Gmode <- ifelse(Gshape >= 1, (Gshape - 1) * Gscale, Gshape * Gscale)
   Gtop <- dgamma(Gmode, shape = Gshape, scale = Gscale)

   #   Create exponential plot
   gcolors <- c("Gamma Distribution Probability Density" = "red",
                "Gamma Distribution Mean" = "blue",
                "Sample Probability Density" = "black",
                "Sample Mean" = "green")

   ggplot (Gdata, aes ( x = Gdata)) +
     geom_histogram(aes (y = ..density..), fill = "grey", binwidth = .1,
                    show.legend = FALSE) +
     geom_density(aes(color = "Sample Probability Density"),
                  size = 1, show.legend = FALSE) +
     stat_function(fun = dgamma, args = list(shape = Gshape, scale = Gscale),
                   aes(color = "Gamma Distribution Probability Density"),
                   show.legend=TRUE, size = 1) +
     geom_segment(aes(x = Gshape * Gscale, xend = Gshape * Gscale,
                      y = 0, yend = Gtop,
                      color="Gamma Distribution Mean"),
                  show.legend = FALSE, size=1, alpha = .5) +
     geom_segment(aes(x = samplemean, xend = samplemean, y = 0, yend = Gtop,
                      color="Sample Mean"), data = samplestats,
                  show.legend = FALSE, size = 2, linetype = 2, alpha = .8) +
     scale_fill_manual(name = "", values = gcolors) +
     scale_colour_manual(name="",values=gcolors) +
     theme_bw() + geom_rug() +
     labs (title = substitute(paste("Gamma Distribution Simulation with k = ",
                                    k, ", ", theta, " = ", t),
                              list(k = Gshape, t = Gscale)), x = "x") +
     scale_x_continuous(expand = c(0, 0), breaks = seq(0, 35, 5)) +
     theme(plot.title = element_text(lineheight=1, face="bold", vjust = 1, size = 18),
           axis.title = element_text(face="bold", size=15),
           axis.text = element_text(face="bold", size = 12),
           legend.position = c(.75, .85))
  })
})
