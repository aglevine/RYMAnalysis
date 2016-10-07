# Script to parse html file from RYM

from sys import argv


fileName=argv[1]
minRate = float(argv[2])
minVote = float(argv[3])
f=open(fileName,'r')
genre =""
print "RATING,VOTES"
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
           	#print "Rating: " + rating + " Votes: " + votes + " Name: " + name + " Genre: " + genre
                print rating+","+votes
