#plot distributions for each year

for (i in 1990:2014){
  year <- i
  toString(year)
  csv_str <-paste("/home/aaron/RYMAnalysis/data/top",year,"RYM.csv",sep="")
  RYM_df<- read.csv(csv_str)

  rating <- RYM_df$RATING
  votes <- RYM_df$VOTES



  file_str<-paste("plots/","RYM",year,".png",sep="")
  png(file=file_str,width=500,height=500)
  title_str<-paste(year," RYM Ratings",sep="")

  hist(rating, freq=FALSE,breaks=c(seq(3,4.5,.05)), axes=FALSE,
  main=paste(year," RYM Ratings",sep=""),cex.main=1.5, #use this title
  xlab="rating", ylab="",cex.lab=2,col="blue",xlim=c(3.0,4.5),ylim=c(0.0,5.0))
  axis(1)# add the x-axis 
  axis(2)
  curve(dnorm(x, mean=mean(rating), sd=sd(rating)), add=TRUE, col="darkblue", lwd=2) 
  meanPrint <- mean(rating)
  meanPrint <- signif(meanPrint,3)
  sdPrint <- sd(rating)
  sdPrint <- signif(sdPrint,2)
  text(4.0,4,"Mean: ",cex=2)
  text(4.0,3.6,"Sigma: ",cex=2)
  text(4.3,4,meanPrint,cex=2)
  text(4.3,3.6,sdPrint,cex=2)
  dev.off()# end plotting, write file

}
