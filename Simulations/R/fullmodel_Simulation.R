
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# FULL MODEL SIMULATION MAIN SCRIPT               #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #

# Main function for running full simulations

fullmodel <- function(t, l, rho_t, rho_l, s, nRinit, DC, N1, nA, nB, N2, M1, M2, checkpoint, tmax, tburnin, simrep, burninrep, nodes,
                      printerval, scriptpath, burninpath, resultpath)
{
  # Imports
  library(slimmr)
  source("R/fullmodel_AnalysisFunctions.R")

  # Initiate base model from file
  model <- slimmr::newSlimModel(description = "Hybrid zone bi-CI resistance evolution", scriptfile = scriptpath)
  
  # Branch burn-in model; remove unnecessary blocks, change timings
  burninModel <- model$clone(deep = TRUE)
  burninModel$removeblock(index = 9)
  burninModel$rescheduleblocks(indices = 8, totime = paste("1 : ", tburnin, sep = ""), timing = "late()")
  burninModel$rescheduleblocks(indices = 9, totime = tburnin, timing = "late()")
  
  # Generate burn-in data
  burninModel$replicate(t = t, l = l, rho_t = rho_t, rho_l = rho_l, s = s, DC = DC, N1 = N1, N2 = N2, M1 = M1, M2 = M2, nA = nA, nB = nB,
                     replicates = burninrep, nodes = nodes, feedbackinterval = printerval, outfile = burninpath, outputfn = processoutput)
  
  # Get initial frequencies for base model as median of burn-in simulations at t = tburnin, scale up by N1 to get counts
  burnins <- burninmedians(burninpath, scaleup = N1)
  
  # Adjust timings of base model
  model$rescheduleblocks(indices = 8, totime = paste("1 : ", tmax, sep = ""), timing = "late()")
  model$rescheduleblocks(indices = 9, totime = 1, timing = "late()")
  model$rescheduleblocks(indices = 10, totime = (tmax), timing = "late()")
  model$moveblock(index = 9, to = 8)
  
  # Add mutation-loss conditional to base model
  model$addblock(index = 9, blocktype = "event", generation = 1, until = checkpoint, timing = "late",
              script = c("  if(sum(p1.individuals.genomes.countOfMutationsOfType(m1)) == 0) {",
                         "    outputFrequencies();",
                         "    sim.simulationFinished();",
                         "  }"))
  
  # Run conditional base model from average burn-in population state
  model$replicate(t = t, l = l, rho_t = rho_t, rho_l = rho_l, s = s, DC = DC, N1 = N1, N2 = N2, M1 = M1, M2 = M2, nRinit = nRinit,
               nA = burnins[1], nB = burnins[2], replicates = simrep, nodes = nodes, feedbackinterval = printerval, outfile = resultpath,
               outputfn = processoutput)
}
