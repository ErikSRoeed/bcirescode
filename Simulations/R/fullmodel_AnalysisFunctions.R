
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# FUNCTIONS FOR RUNNING AND ANALYSING FULL MODEL  #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #


# Output function
processoutput <- function(output)
{
  processed <- lapply(as.list(output), function(r) as.double(unlist(strsplit(substr(r, 9, nchar(r)), " ", fixed = TRUE))))
  names(processed) <- lapply(as.list(output), function(r) substr(r, 1, 7))
  return(processed)
}

# Getting median endpoint of burn-in for simulations proper
burninmedians <- function(burninpath, scaleup)
{
  burninoutput <- loadoutput(burninpath)
  nAburnin <- round(median(sapply(burninoutput, function(rep) rep$output$hist_Ar[[length(rep$output$hist_Ar)]])) * scaleup)
  nBburnin <- round(median(sapply(burninoutput, function(rep) rep$output$hist_Br[[length(rep$output$hist_Br)]])) * scaleup)
  return(c(nAburnin, nBburnin))
}

# Analysis and visualisation functions
loadoutput <- function(outputpath)
{
  load(paste(outputpath, ".RData", sep = "")) # load object "output"
  failed <- which(output == "REPLICATE FAILED")
  writeLines(
    paste(
      "Simulations total: ", length(output) - 1,
      "\nSimulations failed: ", length(failed), sep = ""), paste(outputpath, "_eval.txt", sep = ""
      )
  )
  return(output[-c(1, failed)])
}

remainingsims <- function(simpath, genlims)
{
  simoutput <- loadoutput(simpath)
  remainingcount <- sapply(
    seq(genlims[1], genlims[2]), function(i) length(simoutput) - sum(i >= sapply(
      lapply(1 : length(simoutput), function(rep) simoutput[[rep]]$output[[1]]),
      function(n) length(n)
    )
    ))
  return(remainingcount)
}

plotSimulations <- function(simpath, colours, linetypes, checkpoint, domcoeff, plotname)
{
  # Loading data
  simoutput <- loadoutput(simpath)
  simlength <- max(sapply(1 : length(simoutput), function(sim) length(simoutput[[sim]]$output[[1]])))
  simreplicates <- length(simoutput)
  
  # Functionalising
  plotlines <- function(whichlines) {
    relevantreps <- c()
    for(repl in seq(1, simreplicates)) {
      repoutput <- simoutput[[repl]]$output
      reptmax <- length(repoutput[[1]])
      if(reptmax == simlength) {
        relevantreps <- c(relevantreps, repl)
        for(line in whichlines) {
          lines(x = seq(0, simlength - 1), y = simoutput[[repl]]$output[[line]],
                col = scales::alpha(colours[line], (0.5 / log(simreplicates))),
                lty = linetypes[line])
        }
      }
    }
    medianlines <- lapply(
      seq(1, 6, 1), function(z) sapply(
        seq(1, length(simoutput[[relevantreps[[1]]]]$output[[1]])), function(i) median(sapply(
          relevantreps, function(n) (simoutput[[n]]$output[[z]][[i]])
        ))
      )
    )
    for(medianline in whichlines) {
      lines(x = seq(0, simlength - 1), y = medianlines[[medianline]], col = "black", lty = "solid", lwd = 3.5)
      lines(x = seq(0, simlength - 1), y = medianlines[[medianline]], col = colours[medianline], lty = linetypes[medianline], lwd = 2)
    }
  }
  
  # Wild type panel
  pdf(paste("Plots/", plotname, "_1.pdf", sep = ""), width = 5, height = 4)
  plot(NULL, NULL, xlim = c(-5 , simlength + 4), ylim = c(0, 1), xlab = "", ylab = "Frequency (wild type)", xaxs = "i", axes = FALSE)
  axis(side = 1, at = seq(0, simlength - 1, 250))
  axis(side = 2, at = seq(0, 1, 0.2))
  plotlines(seq(1, 6, 2))
  lines(x = rep(checkpoint, 2), y = c(0, 1), col = "black", lty = "dashed", lwd = 1)
  dev.off()
  
  pdf(paste("Plots/", plotname, "_2.pdf", sep = ""), width = 5, height = 4)
  # Mutants panel
  plot(NULL, NULL, xlim = c(-5 , simlength + 4), ylim = c(0, 1), xlab = "", ylab = "Frequency (mutants)", xaxs = "i", axes = FALSE)
  axis(side = 1, at = seq(0, simlength - 1, 250))
  axis(side = 2, at = seq(0, 1.0, 0.2))
  plotlines(seq(2, 6, 2))
  lines(x = rep(checkpoint, 2), y = c(0, 1), col = "black", lty = "dashed", lwd = 1)
  dev.off()

  # End of plotting
}


