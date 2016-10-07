# Everglades example by Jonathan Callahan @ mazamascience.com

# This flag determines whether images are saved as png files

saveAsPng = TRUE

# You can use the '=' sign for assignment but please get used to the
# R convention '<-'. Some tools depend on consistent use '<-' to parse
# the R code you write.

saveAsPng <- TRUE

# A quick google on "Everglades data csv" and you can find this dataset
# of High Accuracy Elevation Data (HEAD) for the Everglades:

#   http://sofia.usgs.gov/exchange/desmond/desmondelev.html

# We will pick the bigger of the CSV files and read it in as a 'dataframe'.

# ------- READING IN DATA FROM A URL -------------------------------------------

for (i in 1990:2014){
  year <- i
  toString(year)
  csv_str <-paste("/home/aaron/music_lists/top",year,"RYM.csv",sep="")
  cat("Reading in RYM file ...")
  #con <- url('http://sofia.usgs.gov/exchanget/gdesmond/haed/HAED_v01.csv')
  RYM_df<- read.csv(csv_str)

  # ------- QUICK LOOK AT A DATAFRAME --------------------------------------------

  dim(RYM_df)

  # Nice! 57,395 records with 8 variables each.
  # Now let's get an overview of the structure of this dataframe.

  str(RYM_df)

  # We have some 'factors' (aka 'categorical variables'):
  #   SUR_METHOD, SUR_FILE, SUR_INFO, VEG_FS, Quad_Name
  #
  # And we have some 'numerics':
  #   ELEV_M, X_UTM, Y_UTM

  # Let's pull out and rename the variables that are likely to be interesting.

  # ------- DEFINING VARIABLES ---------------------------------------------------

  rating <- RYM_df$RATING
  votes <- RYM_df$VOTES

  # Now let's check out each of the factors 

  # ------- QUICK SUMMARY OF VARIABLES -------------------------------------------

  # factors
  summary(rating)                       # 9277 airboat records

  #summary(habitat)                            # nice but Ouch! -- 40725 records with ""

  summary(votes)                               # nice list of quads with only one ""


  # OK, but we can learn so much more if we inspect things visually. 

  # ------- FIRST DATA VISUALIZATION:  HISTOGRAM & BOXPLOT -----------------------

  # First we'll save the default graphical parameters so we can get back to them

  old_par <- par()

  # We probably want to work interactively at first but eventually we will want
  # to write out image files.  Having this behavior controlled by a flag allows
  # us to work in both worlds as we tweak graphical parameters to get things
  # "just right".  Here we send graphics output to a .png file if the flag is set.
  file_str<-paste("RYM",year,".png",sep="")
  if (saveAsPng) {png(file=file_str,width=500,height=500) }

  # We'll plot a histogram of elevation values.
  # Then we will add a boxplot that crudely summarizes the histogram.
  # We start by creating a layout for two plots with 70% of the vertical space
  # going to the upper plot and 30% to the lower.

  layout(matrix(seq(2)),heights=c(0.7,0.3))

  # Note that the exact settings of various graphical parameters is determined 
  # by a lot of trial and error.  Part of why it's nice to have things scripted.

  # Here are the rest of the plotting commands.
  par(mar=c(0,4.1,4.1,2.1))# reduce size of lower margin
  hist(rating, breaks=25, axes=FALSE,# plot a histogram with 100 bins
  main=paste(year," RYM Ratings",sep=""), #use this title
  xlab="", ylab="")# no axis labels
  par(mar=c(5.1,4.1,0,2.1), mgp=c(3,0.5,0.0))# adjust margins and axis location
  boxplot(rating, horizontal=TRUE, axes=FALSE)# add a boxplot underneath
  axis(1)# add the x-axis 
  mtext("rating", side=1,line=2.5, font=2)# add the x-axis label
  curve(dnorm(x,m=10,sd=2),from=0,to=20,main="Normal distribution")
  par(old_par)# restore the original parameters
  if (saveAsPng) { dev.off() }# end plotting, write file
}
