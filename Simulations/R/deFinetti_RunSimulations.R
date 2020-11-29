
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# RUNNING deFINETTI MODEL                         #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #

source("R/deFinetti_Simulation.R")

# Functionalising the screen for one full diagram

deFinettiDiagram <- function(t, l, N1, N2, M1, M2, tmax, rep, nodes, printerval, scriptpath, resultpath)
{
   outfiles = c()
   for(nA in c(0.0, 0.25, 0.5, 0.75, 1.0) * N1)
   {
      for(nB in c(0.0, 0.25, 0.5, 0.75, 1.0) * N1)
      {
         if(!(nA + nB == N1) && !(nA == 0 || nB == 0)) next
         
         outfile = paste(resultpath, "nA =", nA, "nB =", nB)
         simulate_deFinetti(t = t, l = l, N1 = N1, nA = nA, nB = nB, N2 = N2, M1 = M1, M2 = M2, tmax = tmax, rep = rep, nodes = nodes,
                            printerval = printerval,
                            scriptpath = scriptpath,
                            resultpath = outfile)
         outfiles = c(outfiles, outfile)
      }
   }
   mergetxts(outfiles, paste0(resultpath, ".txt"))
}

# Run simulations

# Region I symmetry line
deFinettiDiagram(
   t = 0.95, l = 0.60,
   N1 = 10000,
   N2 = 10000,
   M1 = 0.001, M2 = 0.001,
   tmax = 40,
   rep = 20,
   nodes = 4,
   printerval = 5,
   scriptpath = "SLiM/model_deFinetti.slim",
   resultpath = "Data/deFinetti_Region_I"
)

# Region II symmetry line
deFinettiDiagram(
   t = 0.95, l = 0.60,
   N1 = 10000,
   N2 = 10000,
   M1 = 0.08, M2 = 0.08,
   tmax = 40,
   rep = 20,
   nodes = 4,
   printerval = 5,
   scriptpath = "SLiM/model_deFinetti.slim",
   resultpath = "Data/deFinetti_Region_II"
)

# Region III symmetry line
deFinettiDiagram(
   t = 0.95, l = 0.60,
   N1 = 10000,
   N2 = 10000,
   M1 = 0.15, M2 = 0.15,
   tmax = 40,
   rep = 20,
   nodes = 4,
   printerval = 5,
   scriptpath = "SLiM/model_deFinetti.slim",
   resultpath = "Data/deFinetti_Region_III"
)

# Region I a
deFinettiDiagram(
   t = 0.95, l = 0.60,
   N1 = 10000,
   N2 = 10000,
   M1 = 0.001, M2 = 0.0005,
   tmax = 40,
   rep = 20,
   nodes = 4,
   printerval = 5,
   scriptpath = "SLiM/model_deFinetti.slim",
   resultpath = "Data/deFinetti_Region_Ia"
)

# Region II a
deFinettiDiagram(
   t = 0.95, l = 0.60,
   N1 = 10000,
   N2 = 10000,
   M1 = 0.08, M2 = 0.04,
   tmax = 40,
   rep = 20,
   nodes = 4,
   printerval = 5,
   scriptpath = "SLiM/model_deFinetti.slim",
   resultpath = "Data/deFinetti_Region_IIa"
)

# Region III a
deFinettiDiagram(
   t = 0.95, l = 0.60,
   N1 = 10000,
   N2 = 10000,
   M1 = 0.15, M2 = 0.075,
   tmax = 40,
   rep = 20,
   nodes = 4,
   printerval = 5,
   scriptpath = "SLiM/model_deFinetti.slim",
   resultpath = "Data/deFinetti_Region_IIIa"
)