#!/bin/bash

# PARAMETERS
#-------------

# Colors
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

#inputs 
Module_Path=$1
Docker_Container_Name=$2
Destination_Folder=$3

# Progress bar parameters
bar_size=40
bar_char_done="#"
bar_char_todo="-"
bar_percentage_scale=2
tasks_in_total=9


# FUNCTIONS
#-----------
show_progress ()
{
    current="$1"
    total="$2"
    task="$3"

    # calculate the progress in percentage 
    percent=$(bc <<< "scale=$bar_percentage_scale; 100 * $current / $total" )
    # The number of done and todo characters
    done=$(bc <<< "scale=0; $bar_size * $percent / 100" )
    todo=$(bc <<< "scale=0; $bar_size - $done" )

    # build the done and todo sub-bars
    done_sub_bar=$(printf "%${done}s" | tr " " "${bar_char_done}")
    todo_sub_bar=$(printf "%${todo}s" | tr " " "${bar_char_todo}")

    # output the bar
    echo -ne "\rProgress :${BYellow} [${done_sub_bar}${todo_sub_bar}] ${percent}% ${Green} ${task} ${Color_Off}"

    if [ $total -eq $current ]; then
        #echo -e "\nDONE"
        printf "\n"
    fi
}

show_example_message()
{
    printf "\n ${On_Green}                                                                                                    ${Color_Off}\n"
    printf "${Black} ${On_Green} Example: ./install-go-base-project.sh [MODULE PATH] [DOCKER CONTAINER NAME] [FOLDER PROJECT NAME]  ${Color_Off}\n"
    printf " ${On_Green}                                                                                                    ${Color_Off}\n"
}

show_error_message()
{
    printf "\n"
    printf "${White} ${On_Red} > Before to install, you have to set your '$1' as $2 parameter < ${Color_Off}\n"
    printf "\n"
}

show_header()
{
  clear
  printf "\n"
  printf " ${BYellow}-------------------------------------------- ${Color_Off} \n"
  printf " ${BYellow}-                                          - ${Color_Off} \n"
  printf " ${BYellow}-            GO BASE INSTALLER             - ${Color_Off} \n"
  printf " ${BYellow}-                ${BBlue} V0.0.1                  ${BYellow} - ${Color_Off} \n"
  printf " ${BYellow}-          ${BGreen}Author: Lucas Vazquez         ${BYellow}  - ${Color_Off} \n"
  printf " ${BYellow}-                                          - ${Color_Off} \n"
  printf " ${BYellow}-------------------------------------------- ${Color_Off} \n"
  printf "\n"
}

# SCRIPT INIT
#-------------
printf "\n"

show_header

# Check parameters
if [ -z "${Module_Path}" ]
  then
    show_error_message "module path" "first"
    show_example_message
    exit 0
fi

if [ -z "${Docker_Container_Name}" ]
  then
    show_error_message "docker container name" "second"
    show_example_message
    exit 0
fi

if [ -z "${Destination_Folder}" ]
  then
    show_error_message "the name of your folder locally" "third"
    show_example_message
    exit 0
fi

# Ask confirmation
printf "${BYellow} You are going to start a new project with the following information: ${Color_Off}\n"
printf "${BWhite} > Go module path:${BBlue} ${Module_Path} ${Color_Off}\n"
printf "${BWhite} > Docker container name:${BBlue} ${Docker_Container_Name} ${Color_Off}\n"
printf "${BWhite} > Destination folder:${BBlue} ${Destination_Folder} ${Color_Off}\n\n"
read -p "Are you sure to continue? (yes=y , No=n): " -n 1 -r
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    printf "${BGreen} Installation finished:${Color_Off}\n"
    exit 1
fi

printf "\n"

show_progress 2 $tasks_in_total "Start installation"

# Clone gobase project
show_progress 3 $tasks_in_total "Downloading project"
git clone git@github.com:lucasnv/gobase.git ${Destination_Folder} &> /dev/null


# Move into the project folder
show_progress 4 $tasks_in_total "Enter into the project"
cd $3


# Remove github repository source
show_progress 5 $tasks_in_total "Delete git configuration"
rm -dfr .git

# set the module URL
show_progress 6 $tasks_in_total "Configuring project"
grep -rl --exclude-dir=.git \
         --exclude-dir=bin \
         --exclude-dir=.github \
         --exclude-dir=config \
         --exclude-dir=db \
         --exclude-dir=scripts \
         '<MODULE_URL_REPLACE>' . | xargs sed -i "s+<MODULE_URL_REPLACE>+${Module_Path}+g"

# set the container name
grep -rl --exclude-dir=.git \
         --exclude-dir=bin \
         --exclude-dir=.github \
         --exclude-dir=config \
         --exclude-dir=db \
         --exclude-dir=scripts \
         '<CONTAINER_NAME_REPLACE>' . | xargs sed -i "s+<CONTAINER_NAME_REPLACE>+${Docker_Container_Name}+g"

# Installing go mod
show_progress 7 $tasks_in_total "Creating environment file"
cp env.example .env


show_progress 8 $tasks_in_total "Configuring go modules        "
docker run -v `pwd`:/app-src -w /app-src golang:1.19.5-alpine3.17 go mod init ${Module_Path} &> /dev/null
docker run -v `pwd`:/app-src -w /app-src golang:1.19.5-alpine3.17 go mod tidy &> /dev/null

# 
#TODO
# MOSTAR UNA PANtalla mas copada de instalacion como con un marco 
#.install [MODULE] [CONTAINER] [FOLDER] [GOLANG VERSION]
# Evitar el paraametro container.
# mostrar una ayuda sobre que significa cada comando
# refactroizar script para no depender de la versio golang 1.19 (podria pasarle al script de instalacion la version de go para )
# ./install-go-base-project.sh "github.com/omi-tech/api" "toolboard-api" testgobase

show_progress $tasks_in_total $tasks_in_total "Completed                 "

printf "\n"

printf " ${BBlue}Follow the next steps: ${Color_Off}\n"
printf " > cd ${Destination_Folder} && make init\n"
printf " > curl 0.0.0.0:8080/v1/health-check \n"

printf "\n ${On_Green}${BBlack}If the api responds with {'status':'healthy API status.'}, the new project has been created successfully.${Color_Off}\n"
