library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

year2012 <- grepl('2012-*', sampleTimes)

print(length(year2012[year2012 == TRUE]))

##___________________________________________________________

sampleTimes2012 <- subset(sampleTimes, year2012)

day <- format(sampleTimes2012, '%a')

print(length(day[day == "Mon"]))