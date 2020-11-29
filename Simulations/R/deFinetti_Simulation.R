
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# MAIN deFINETTI SIMULATION FUNCTION              #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #

simulate_deFinetti <- function(t, l, N1, nA, nB, N2, M1, M2, tmax, rep, nodes, printerval, scriptpath, resultpath)
{
  # Imports
  library(slimmr)
  source("R/deFinetti_AnalysisFunctions.R")
  
  # Set up model as slimmr object
  model <- slimmr::newSlimModel(description = "Simulations for stochastic de Finetti diagrams", scriptfile = scriptpath)
  
  # Adjust model timings to reflect user input
  model$rescheduleblocks(indices = 8, totime = paste("1 : ", tmax, sep = ""), timing = "late()")
  model$rescheduleblocks(indices = 9, totime = tmax, timing = "late()")
  
  # Run model
  model$replicate(t = t, l = l, N1 = N1, nA = nA, nB = nB, N2 = N2, M1 = M1, M2 = M2,
                  replicates = rep, nodes = nodes, feedbackinterval = printerval,
                  outputfn = NULL, outfile = resultpath)
  
  # Format as .txt file for de Finetti diagrams in Mathematica
  txtfromoutput(outputpath = resultpath, txtname = paste(resultpath, ".txt", sep = ""))
}
