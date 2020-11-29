
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #
#                                                 #
# FUNCTIONS FOR ANALYSING deFINETTI MODEL         #
#                                                 #
# Erik Sandertun Røed, October 2020               #
#                                                 #
# ==#==#==#==#==#==#==#==#==#==#==#==#==#==#==#== #

# Additional helper and analysis function

loadoutput <- function(outputpath)
{
  load(paste(outputpath, ".RData", sep = "")) # load object "output"
  return(output[-1])
}

txtfromoutput <- function(outputpath, txtname)
{
  output <- loadoutput(outputpath)
  writeLines(sapply(output, function(rep) return(paste("{", rep$output, "}", sep = ""))), txtname)
}

mergetxts <- function(txtpaths, outfile)
{
  txts <- sapply(txtpaths, function(txtfile) readLines(paste(txtfile, ".txt", sep = "")))
  writeLines(txts, outfile)
}