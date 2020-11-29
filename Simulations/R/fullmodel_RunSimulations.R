
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# RUNNING FULL MODEL SIMULATIONS                  #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #

# Load this first
source("R/fullmodel_Simulation.R")

# Invasion type I
fullmodel(t = 0.95, l = 0.6, rho_t = 0, rho_l = 0.5, s = 0,
      nRinit = 1, DC = 1,
      N1 = 10000, nA = 8500, nB = 1000, N2 = 10000, M1 = 0.0015, M2 = 0.0015,
      checkpoint = 1500, tmax = 1500, tburnin = 25, simrep = 500, burninrep = 20,
      nodes = 4, printerval = 5,
      scriptpath = "SLiM/model_full.slim",
      burninpath = "Data/full_burnin_typeI",
      resultpath = "Data/full_simulations_typeI"
)

# Invasion type II
fullmodel(t = 0.95, l = 0.6, rho_t = 0, rho_l = 1, s = 0,
      nRinit = 1, DC = 1,
      N1 = 10000, nA = 8500, nB = 1000, N2 = 10000, M1 = 0.0015, M2 = 0.0015,
      checkpoint = 500, tmax = 500, tburnin = 25, simrep = 500, burninrep = 20,
      nodes = 4, printerval = 5,
      scriptpath = "SLiM/model_full.slim",
      burninpath = "Data/full_burnin_typeII",
      resultpath = "Data/full_simulations_typeII"
)

# Invasion type III
fullmodel(t = 0.95, l = 0.6, rho_t = 0, rho_l = 1, s = 0,
      nRinit = 1, DC = 1,
      N1 = 10000, nA = 8500, nB = 1000, N2 = 10000, M1 = 0.01, M2 = 0.02,
      checkpoint = 750, tmax = 750, tburnin = 25, simrep = 500, burninrep = 20,
      nodes = 4, printerval = 5,
      scriptpath = "SLiM/model_full.slim",
      burninpath = "Data/full_burnin_typeIII",
      resultpath = "Data/full_simulations_typeIII"
)

# Invasion type IV
fullmodel(t = 0.95, l = 0.6, rho_t = 0, rho_l = 1, s = 0,
      nRinit = 1, DC = 1,
      N1 = 10000, nA = 8500, nB = 1000, N2 = 10000, M1 = 0.01, M2 = 0.04,
      checkpoint = 200, tmax = 500, tburnin = 25, simrep = 500, burninrep = 20,
      nodes = 4, printerval = 5,
      scriptpath = "SLiM/model_full.slim",
      burninpath = "Data/full_burnin_typeIV",
      resultpath = "Data/full_simulations_typeIV"
)

