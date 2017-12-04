### Load Nessecary Libraries
library(forecast)
library(pracma)

### Load CSVs and clean the NA entries
timeData = read.csv("Atimes.csv")
statesData = read.csv("Astates.csv")

rows = dim(timeData)[1] 
piVec = piVec2 = piVecCond = numeric(46)

for(i in 1:25)#rows)
{
  print(i)
  
  filledTime = as.numeric( trunc(timeData[i,!is.na( timeData[i,])] ) )
  filledStates = as.numeric( trunc( statesData[i,!is.na( statesData[i,])] ) )
  
  ### concat the time and states into a single df
  medData = matrix(c(filledTime,filledStates),ncol=2)
  firstTime = medData[1,1]
  lastTime = medData[nrow(medData),1]
  
  ### use Newtons Interpolation to turn the un-even time series to an even time series
  timeSpan = seq(firstTime,lastTime)
  timeSpan = setdiff(timeSpan,medData[,1])
  
  estStates = round( newtonInterp(medData[,1], medData[,2], timeSpan) )
  
  ### combine the interpolated points with our given points each index represents a discrete time step
  combinedStates = numeric( lastTime - firstTime + 1 )
  combinedStates[timeSpan] = estStates
  combinedStates[medData[,1]] = medData[,2]
  
  dailyTS = ts(combinedStates, start=firstTime, end=lastTime, frequency = 1)
  fit = nnetar(dailyTS)
  predictedStates = forecast(fit,h = 365-lastTime)
  plot(predictedStates)
  

}
