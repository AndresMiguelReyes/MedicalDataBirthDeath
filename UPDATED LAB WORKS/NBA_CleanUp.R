load("C:/Users/Andres/Documents/School Stuff/2017-2018/Fall 17/MATH 195/team_obs_LU.RData")
library(plyr) 

NBA = team_obs_LU

for(team in 1:length(NBA))
{
  teamName = names(NBA)[team]
  currentTeamData = NBA[[team]]$obs
  dateList = currentTeam$rawdate
  
  
  for(date in 1:length(dateList))
  {
    gameDate = currentTeam$rawdate[date]
    gameDF = currentTeam[which(dateList == gameDate),] 
    
    homeStates = gameDF$HLu
    homeDelta = gameDF$timePlayed
    dupKey = duplicated(gameDF$HLu)
    
    gameTimeSeries = data.frame(homeStates,homeDelta)
    
    dupDF = gameTimeSeries[dupKey,]
    gameTimeSeries = gameTimeSeries[!dupKey,]
    
    for (k in 1:length(homeStates[dupKey]) )
    {
      originalInd = which(gameTimeSeries$homeStates == homeStates[dupKey][k])[1]
      gameTimeSeries[originalInd,2] = gameTimeSeries[originalInd,2] + dupDF[k,2]
    }
    if(date == 1)
    {
      lineUpList = list(gameTimeSeries)
    }
    else
    {
      lineUpList = c(list(gameTimeSeries), lineUpList)
    }
    
  }
  #CSVname = gsub(" ", "", cat(teamName,".csv"), fixed = TRUE)
  CSVname = "Atl.csv"
  #dput(lineUpDF, CSVname)
}






