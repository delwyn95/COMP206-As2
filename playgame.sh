#!/bin/bash
#======This only runs if theres no data file"
#Format of Data.pg: First 10 lines are numbers between 1-50.
# Lines 11-15 are number of guess of successful games (1-3).

#The method "encryption" I used is:
#           For Output : ( x * 6 ) + 2
#           For Input : ( x - 2 ) / 6
#This is the method I used as if someone else opens the file, they will see bunch of random and big numbers which has no relevance to the game.

if [ -f Data.pg ]      # Detects if there is a Game data available (the else statement is at the bottom which generates the random numbers).
then
#=====                   Reading and storing values
arrGame=()                 #Creating array. Accessing the array in format ${arrGame[i]}
while read var1
do
arrGame+=( "$[$[$var1-2]/6]") # Stores all the values into array
done < Data.pg



#                           Line count in the Data file, and stores into my variable (wc = word count (line))
wc=`wc -l < Data.pg`


#                This Loop reads the last 15 lines in Data.pg to be used for average value + number of tries
#               the while read loop will naturally read each of the lines, but we are only interested in the last 15 lines.
#               the if statement will handle this for us.
#       *Reminder:  wc=total line count of the text. If statement will only read the relevent lines
#      Lower bound = wc - 15, Upper bound wc - 5, greater than (wc - 5) are the number of tries
n=1
while read var1; do
#                This condition reads the lines [1-10] of the most recent 15 lines.
if [[ ($n -ge $[$wc-15]) && ($n -le $[$wc-5]) ]]; then
let "a += $[$[$var1-2]/6]"

#                This condition reads the last 5 lines.
elif [[ $n -gt $[$wc-5] ]]; then
let "b += $[$[$var1-2]/6]"
fi
n=$(( $n + 1 ))
done < Data.pg

#               Data calculation
#==============================
average=$[$a/10] #Average value
tries=$[$b/5] #Average number of tries
upper=$[$average*22/30] #Upper bound
lower=$[$average*18/30] #Lower bound


#============================= These lines were only used so I can see the values (averages, bounds) to test the game.
#echo Total lines:$wc
#echo Average Number:$average
#echo Average number of Tries: $tries
#echo Lower bound: $lower
#echo Upper bound: $upper
#==============================


arrGuess=() # array to keep track of input
#  Reminder: Accessing the array in format ${arrGuess[i]}


#              This Loop runs the game.
correct=0
attempt=1
while test $attempt -le 3
do
echo "Guess a number between 1-50."
read guess

if [[ $guess = "" ]]
then
echo "Invalid input"
break;
fi

if [[ ($guess -ge $lower) && ($guess -le $upper) ]]
then
echo "Good job! you took $attempt tries to guess. The average tries is $tries."
correct=$guess
break


else
echo "Incorrect guess, try again"
arrGuess[$attempt]=$guess              # Stores the user input into second array.
fi
attempt=$[$attempt+1]
done

#       This loop knows how many of the 7-9 most numbers to print out
#       The loop will ignore either the 1st, 2nd, entry depending how many tries it took the user to guess correctly
# indexA is the index value to start at depending on the tries it took to guess correct
# indexB is the 10th value of the 15 most recent.

indexA=$[$wc-15+$attempt]
indexB=$[$wc-5]

while test $indexA -lt $indexB
do
echo $[${arrGame[$indexA]}*6+2] >> Data.pg
indexA=$[$indexA+1]
done

# This prints the number that the user has guess into the Data.pg file.
# prints entered data the last spots.
#indexC is at 1
#indexD the upper bound in the while loop, which prints the values the user has guessed.

indexC=1
indexD=$[$attempt]
while test $indexC -lt $indexD
do
echo $[${arrGuess[$indexC]}*6+2] >> Data.pg
indexC=$[$indexC+1]
done
#Appends the user's correct guess into Data.pg
#If statement will append the user's correct value if he gets it correct.
if [[ $correct  != 0 ]]
then
echo $[$correct*6+2] >> Data.pg
fi





#===== End of appending statements of the [1st - 10th] values in Data.pg.
#*************************************************************************
#===== The next part will print [11th - 15th values] which are the numbers of correct guesses of the 5 successful players.

#     If statement used to determine for whether user is actually successful.
#     If User is successful, the if statement will loop a print statement into Data.pg.
#                -If user is successful : Looping will print 4 most recent successful tries, and append the user's guess at the end.
#                -If user is unsuccessful: Prints all 5 most recent successful tries.

#indexE - lower bound = total number of lines - 4.
#indexG - upper bound = total number of lines4.

if [[ ($attempt -lt 4) ]]
then
indexE=$[$wc-4]
indexG=$[$wc]
while test $indexE -lt $indexG
do
echo $[${arrGame[$indexE]}*6+2] >> Data.pg
indexE=$[$indexE+1]
done
echo $[$attempt*6+2] >> Data.pg

else
indexE=$[$wc-5]
indexG=$[$wc]
while test $indexE -lt $indexG
do
echo $[${arrGame[$indexE]}*6+2] >> Data.pg
indexE=$[$indexE+1]
done

fi




#                                   End of the game
#********************************
#           if the first statement is not true (Reminder: if [ -f Data.pg ],
#           this is run to create the random numbers
#           The random number is output to Data.pg
#           The Value is "encrypted" using the (6x + 2)

else

echo "This is your first time playing."

for i in {1..10}
do
echo "$[$[RANDOM % 50 + 1]*6+2]" >> Data.pg
done

for i in {1..5}
do
echo "$[$[RANDOM % 3 + 1]*6+2]" >> Data.pg
done

echo "Game data generated successfully."
fi
