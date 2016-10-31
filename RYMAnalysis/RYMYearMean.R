library(ggplot2)

csv_str <-paste("/home/aaron/RYMAnalysis/data/topRYMYears.csv")
cat("Reading in RYM file ...")
RYM_df<- read.csv(csv_str)

ratings <- RYM_df$RATING
votes <- RYM_df$VOTES
years <- RYM_df$YEAR
periods <-RYM_df$PERIOD


file_str<-paste("plots/","RYMMeanYearFinal.png",sep="")
png(file=file_str,width=500,height=500)
title_str<-paste("RYM Mean Ratings Vs Year",sep="")

# Here are the rest of the plotting commands.
# par(mar=c(0,4.1,4.1,2.1))# reduce size of lower margin
# hist(rating, breaks=25,# plot a histogram with 100 bins
# main="RYM Mean Ratings Vs Year"), #use this title
# xlab="", ylab="")# no axis labels
#chol <- read.table(url("http://assets.datacamp.com/blog_assets/chol.txt"), header = TRUE)
#Take the column "AGE" from the "chol" dataset and make a histogram of it
#print(qplot(chol$AGE, geom="histogram"))
# par(mar=c(5.1,4.1,0,2.1), mgp=c(3,0.5,0.0))# adjust margins and axis location
# boxplot(rating, horizontal=TRUE, axes=FALSE)# add a boxplot underneath
#print(mean(ratings))
AgYear <- aggregate(cbind(ratings,periods)~years, RYM_df, mean)
str(AgYear)
Avgratings <- AgYear$ratings
Avgyears <-AgYear$years
Avgperiods <-AgYear$periods
summary(Avgperiods)
canvas <-ggplot(AgYear, aes(y=ratings, x=years))
print(canvas +theme(axis.text=element_text(size=12),
      axis.title=element_text(size=14,face="bold")) +xlab("Year") + ylab("Mean Rating")
      #+stat_smooth(data=AgYear,method='lm',formula=y~x)
      + geom_point(colour=Avgperiods))
#abline(reg1)
#ggplot(RYM_df) + aes(x=years,y=ratings) + ggtitle(title_str) 
#+  theme(plot.title = element_text(lineheight=.8, face="bold")) + geom_boxplot())
#print(ggplot() + xlim(3.0,5.0)+ aes(rating) + boxplot(rating, horizontal=TRUE, axes=FALSE))
#axis(1)# add the x-axis 
# mtext("rating", side=1,line=2.5, font=2)# add the x-axis label
#curve(dnorm(x,m=10,sd=2),from=0,to=20,main="Normal distribution")
# par(old_par)# restore the original parameters
# Here are the rest of the plotting commands.
#par(mar=c(0,4.1,4.1,2.1))# reduce size of lower margin
#hist(rating, freq=FALSE,breaks=c(seq(3,4.5,.05)), axes=FALSE,# plot a histogram with 100 bins
#main=paste("Mean RYM Ratings vs Year",sep=""),cex.main=1.5, #use this title
#xlab="rating", ylab="",cex.lab=2,col="blue",xlim=c(3.0,4.5),ylim=c(0.0,5.0))# no axis labels
#par(mar=c(5.1,4.1,0,2.1), mgp=c(3,0.5,0.0))# adjust margins and axis location
#par(old_par)# restore the original parameters
dev.off()# end plotting, write file


