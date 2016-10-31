#plots mean ratings vs year

library(ggplot2)

csv_str <-paste("/home/aaron/RYMAnalysis/data/topRYMYears.csv")
cat("Reading in RYM file ...")
RYM_df<- read.csv(csv_str)

ratings <- RYM_df$RATING
votes <- RYM_df$VOTES
years <- RYM_df$YEAR
periods <-RYM_df$PERIOD


file_str<-paste("plots/","RYMTrends.png",sep="")
png(file=file_str,width=500,height=500)
title_str<-paste("RYM Mean Ratings Vs Year",sep="")

AgYear <- aggregate(cbind(ratings,periods)~years, RYM_df, mean) #get mean rating for each year
str(AgYear)
Avgratings <- AgYear$ratings
Avgyears <-AgYear$years
Avgperiods <-AgYear$periods
summary(Avgperiods)
canvas <-ggplot(AgYear, aes(y=ratings, x=years))
print(canvas +theme(axis.text=element_text(size=12),
      axis.title=element_text(size=14,face="bold")) +xlab("Year") + ylab("Mean Rating")
      + geom_point(colour=Avgperiods)
)
dev.off()# end plotting, write file


