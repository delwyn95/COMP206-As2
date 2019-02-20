#!/bin/bash


if [[ -d $1 ]] #When path is given
then

if [[ -z 2$ ]] #When no project name is given : Error
then
echo Project name is missing. Type in: NewProject path project_name

else #When path and project name entered correctly
echo Project successfully created in $1
cd "$1" && mkdir "$2"
cd "$2" && mkdir docs source backup archive
fi



elif [[ ! -d "$1" && -n "$2" ]] #invalid path
then
echo Your pathname is malformed. Type in: NewProject path project_name

else #Project in current directory
echo Project successfully created in current directory.
mkdir "$1"
cd "$1" && mkdir docs source backup archive


fi

# This line echos the script used to compile.

echo '#!/bin/bash

#Verifies if optional parameter is included.
#= IF 1 (start)
if [[ $1 = "-o"  ]]
then
option="$1"
shift;

#==IF 2 (start)
#Checks if number of entries is correct. the file name must be there.
if [[ $# < 2 ]]
then
echo 'You are missing file names. Type in: compile -o exectuable_name file_name'.

else

echo "Optional -o activated"
fi
#==IF 2 (end)
#exit of shift statement


#Reminder: '-o' option is still specified.
#Copies files to backup
cp ${*:2} ../backup

gcc $option $* 2>errors
more errors
# Puts error messages in file named errors.

else
#Reminder: When '-o' is not specified. (Outputs to a.out).

if [[ $1 = "" ]]
then
echo You are missing files to compile.

else


cp ${*:1} ../backup

gcc $* 2>errors
more errors
fi
fi
#=If 1 (end)
' >> source/compile


#Changing permissions of new compile script.
if [[ -f $1$2/source/compile ]]
then chmod u+x $1$2/source/compile

elif [[ -f source/compile ]]
then chmod u+x source/compile

else [[ -f $1/source/compile ]]
chmod u+x $1/source/compile

fi
exit 0
