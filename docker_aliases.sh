## colors
# Reset
ColorOff='\033[0m'       # Text Reset
BColorOff='\033[1;0m'       # Text Reset

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
On_IPurple='\033[10;95m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

# Docker Aliases
alias docker-run-prev-container='prev_container_id="$(docker ps -aq | head -n1)" && docker commit "$prev_container_id" "prev_container/$prev_container_id" && docker run -it --entrypoint=bash "prev_container/$prev_container_id"'
alias docker-img-none-rem='docker rmi -f $(docker images -a | grep '"'"'none'"'"' | awk '"'"'{printf $3 "\n"}'"'"')'
alias psa='echo -e ${Green}Current Docker Containers${ColorOff};docker ps -a'
alias img='echo -e ${Green}Current Docker Images${ColorOff};docker images -a'
alias vol='echo -e ${Green}Current Docker Volumes${ColorOff};docker volume ls'
alias net='echo -e ${Green}Current Docker Networks${ColorOff};docker network ls'
alias docker_nuke='
echo -e ${Red}WARNING!!!!${ColorOff} This will delete all current Docker containers, images and volumes.;
read -r -p $"Are you sure?$ [y/N]" response
case "$response" in
    [yY][eE][sS]|[yY])
        echo -e ${Blue}Current Containers${ColorOff}
        docker ps -a
        echo -e ${Red}Stopping Containers${ColorOff}
        docker stop $(docker ps -aq)

        echo -e ${Red}Deleting Containers${ColorOff}
        docker rm $(docker ps -aq)

        echo -e ${Blue}Current Images${ColorOff}
        docker images -a
        echo -e ${Red}Deleting Images${ColorOff}
        docker rmi $(docker images -aq)

        echo -e ${Blue}Current Volumes${ColorOff}
        docker volume ls
        echo -e ${Red}Deleting Volumes${ColorOff}
        docker volume rm $(docker volume ls -q)

        echo -e "${Red}                               ________________"
        echo -e "${Red}                          ____/ (  (    )   )  \\___"
        echo -e "${Red}                         /( (  (  )   _    ))  )   )\\"
        echo -e "${Red}                       ((     (   )(    )  )   (   )  )"
        echo -e "${Red}                     ((/  ( _(   )   (   _) ) (  () )  )"
        echo -e "${Red}                    ( (  ( (_)   ((    (   )  .((_ ) .  )_"
        echo -e "${Red}                   ( (  )    (      (  )    )   ) . ) (   )"
        echo -e "${Red}                  (  (   (  (   ) (  _  ( _) ).  ) . ) ) ( )"
        echo -e "${Red}                  ( (  (   ) (  )   (  ))     ) _)(   )  )  )"
        echo -e "${Red}                 ( (  ( \ ) (    (_  ( ) ( )  )   ) )  )) ( )"
        echo -e "${Red}                  (  (   (  (   (_ ( ) ( _    )  ) (  )  )   )"
        echo -e "${Red}                 ( (  ( (  (  )     (_  )  ) )  _)   ) _( ( )"
        echo -e "${Red}                  ((  (   )(    (     _    )   _) _(_ (  (_ )"
        echo -e "${Red}                   (_((__(_(__(( ( ( |  ) ) ) )_))__))_)___)"
        echo -e "${Red}                   ((__)        \\\\||lll|l||///          \\_))"
        echo -e "${Red}                            (   /(/ (  )  ) )\\   )"
        echo -e "${Red}                          (    ( ( ( | | ) ) )\\   )"
        echo -e "${Red}                           (   /(| / ( )) ) ) )) )"
        echo -e "${Red}                         (     ( ((((_(|)_)))))     )"
        echo -e "${Red}                          (      ||\(|(|)|/||     )"
        echo -e "${Red}                        (        |(||(||)||||        )"
        echo -e "${Red}                          (     //|/l|||)|\\\\ \\     )"
        echo -e "${Red}                        (/ / //  /|//||||\\\\  \\ \\  \\ _)"
        echo -e "${Red}-------------------------------------------------------------------------------${ColorOff}"
        echo -e ${Red}Removal of ${IRed}All${ColorOff} Containers Complete${ColorOff}
        ;;
    [nN])
        echo -e  ${Green}Aborting Docker Nuke${ColorOff}
        ;;
esac
'

function docker-ip() {
echo -e "${Yellow}Which container?${ColorOff}"
echo "All"
docker inspect -f "{{.Name}}" $(docker ps -aq) |  sed 's/^.//'
read -r response
case "$response" in
    [aA][lL][lL]|[aA])
        paste <(echo -e ${Cyan}Container${ColorOff};docker inspect -f "{{.Name}}" $(docker ps -aq) |  sed 's/^.//' ) \
                <(echo -e ${IPurple}Container IP${ColorOff};docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" $(docker ps -aq))
        ;;
    [0-9])
        paste <(echo -e ${Cyan}Container${ColorOff};docker inspect -f "{{.Name}}" "$response" |  sed 's/^.//' ) \
                <(echo -e ${IPurple}Container IP${ColorOff};docker inspect -f "{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}" "$response" )
        ;;
esac
}
