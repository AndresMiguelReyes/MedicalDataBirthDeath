### Load Nessecary Libraries
library(DOBAD)

### Load CSVs and clean the NA entries
timeData = read.csv("Atimes.csv")
statesData = read.csv("Astates.csv")

filledTime = timeData[rowSums(is.na(timeData)) == 0,]
filledStates = statesData[rowSums(is.na(statesData)) == 0,]

### concat the time and states into a single df
medData = data.frame(t(filledTime),t(filledStates))
colnames(medData) = c("times","states")
row.names(medData) = NULL

### create a temporary list to append to the dataframe so that it can
### be processed by list2CTMC
medData = as.list(medData)
tAppend = list(T=c(9999))
medData = c(medData,tAppend)

### convert our new CTMC object into partially observed CTMC so that we can generate more data
medCTMC = list2CTMC(medData)
medCTMC_PO = getPartialData(getTimes(medCTMC), medCTMC)
### review documentation, how can we extract the states from this function? 
### possibly use a different function not requiring Imm rate that also est. params?

#guess = BD.MCMC.SC(Lguess=1,Mguess=1,beta.immig=1,data=medCTMC_PO,N=10,burnIn=0)
#Eguess = E.step.SC(medCTMC_PO)

T = 900
l = BDsummaryStats.PO(medCTMC_PO)
MLEs = M.step.SC( EMsuffStats=l, T=T, beta.immig = 0)
#guess = BD.MCMC.SC(Lguess=MLEs[1],Mguess=MLEs[2],beta.immig=1,data=medCTMC_PO,N=10,burnIn=0)
times = getTimes(medCTMC_PO)
states = getStates(medCTMC_PO)

medSim = birth.death.simulant(t=999,X0=states[length(states)],lambda=MLEs[1],mu=MLEs[2],condCounts = l)
#medSim = sim.condBD(bd.PO = medCTMC_PO,L=MLEs[1],m=MLEs[2],prevSims = NULL)#,b=44)
#sim.condBD(bd.PO = medCTMC_PO, N = 1, L = MLEs[1], m = MLEs[2], prevSims=NULL, nu = .4)#,a=34,b=44)
