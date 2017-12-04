load("C:/Users/Andres/Documents/School Stuff/2017-2018/Fall 17/MATH 195/team_obs_LU.RData")
NBA = team_obs_LU

for(team in 1:1)#length(NBA))
{
  currentTeam = NBA[[team]]$obs
  dateList = currentTeam$rawdate
  
  for(date in 1:1)#length(dateList))
  {
    gameDate = currentTeam$rawdate[date]
    gameDF = currentTeam[which(dateList == gameDate),] 
    
    homeStates = gameDF$HLu
    homeDelta = gameDF$timePlayed
    
    tempTime = numeric(1)
    tempStates = homeDelta[1]
    
    for(k in 1:length(homeDelta)-1)
    {
      if (k == 1)
      {  
        tempTime = c(tempTime,tempTime[1] + homeDelta[k])
      }
      else
      {
        tempTime = c(tempTime,tempTime[k] + homeDelta[k])
      }
    }
    
    tempGame = data.frame(homeStates,tempTime)
    
    for(k in 1:length(homeStates)-1)
    {
      if( homeStates[k] == homeStates[k+1] )
      {
         gameTimeSeries = tempGame[-k,]
      }    
    }
  }
  
  visitingList =
}






