
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# VISUALISING FULL MODEL RESULTS                  #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #

source("R/fullmodel_AnalysisFunctions.R")

cols = c(
  rep(rgb( 73, 146, 114, maxColorValue = 255), 2),
  rep(rgb(138,  69, 138, maxColorValue = 255), 2),
  rep(rgb(212, 186, 106, maxColorValue = 255), 2)
)

plotSimulations(
  simpath = "Data/S1 - Results_Scenario1",
  colours = cols,
  linetypes = rep("solid", 6),
  checkpoint = 1500,
  domcoeff = 1,
  plotname = "InvasionTypeI"
)

plotSimulations(
  simpath = "Data/S1 - Results_Scenario2",
  colours = cols,
  linetypes = rep("solid", 6),
  checkpoint = 1000,
  domcoeff = 1,
  plotname = "InvasionTypeII"
)

plotSimulations(
  simpath = "Data/S1 - Results_Scenario3",
  colours = cols,
  linetypes = rep("solid", 6),
  checkpoint = 1000,
  domcoeff = 1,
  plotname = "InvasionTypeIII"
)

plotSimulations(
  simpath = "Data/S1 - Results_Scenario4",
  colours = cols,
  linetypes = rep("solid", 6),
  checkpoint = 200,
  domcoeff = 1,
  plotname = "InvasionTypeIV"
)