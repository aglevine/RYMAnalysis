# Script to parse html file from RYM
#creates a csv file for R

from sys import argv
import math

sdMap= {"2008": 0.11, "2009": 0.11, "2010":0.12, "2011":0.12,"2012":0.11,
"2013":0.12,"2014":0.12} 

shift = True
fileName=argv[1]
minRate = float(argv[2])
minVote = float(argv[3])
f=open(fileName,'r')
period =""
year = fileName[fileName.find("top")+2+1:fileName.find("RYM")]
intYear = int(year)
if (intYear <= 2000):
	period = "PreRYM"
elif (intYear <=2007):
	period = "NewRYM"
elif (intYear >= 2008):
	period = "PresentRYM"
for line in f.readlines():
        if ('href="/genre/' in line):
           genre = line[line.find('href="/genre/')+12+1:line.find('/">')]
           genre = genre.replace("+"," ")
           genre = genre.replace("%2d","-")
	if ("RYM Rating" in line):
           rating = line[line.find("RYM Rating: <b>")+14+1:line.find("</b>")]
        if ("Ratings:" in line):
	   votes = line[line.find("Ratings: <b>")+11+1:line.find("</b>")]
           votes = votes.replace(",","")
        if("| <a href" in line):
           name = line[line.find('| <a href="/release/album/')+25+1:line.find('/buy/"')]
	   name= name.replace("/",": " )
           name = name.replace("_", " ")
           name = name.title()
           if (  float(rating) >= minRate and  int(votes) >= minVote):
		if (shift==True): #work in progress, testing out corrections for year
			ratingFloat = float(rating)
			yearFloat = float(year)
                        if (yearFloat >= 2008):
				sd = sdMap[year]
 				mean = 3.532398-0.01474833333*(yearFloat-2008.0)
				ratingFloat = ratingFloat*0.16/sd
				ratingFloat = ratingFloat - mean*0.16/sd+3.66
				rating = str(ratingFloat)
                print rating+","+votes+","+year+","+period+","+name
