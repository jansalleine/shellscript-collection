#!/bin/sh

printhelp()
{
   echo ""
   echo "Usage: $0 -d {databasename} -h {hostname}[optional] -u {username} -p {password}[optional]"
   exit 1
}

hostname=localhost

while getopts "d:h:u:p:" opt
do
   case "$opt" in
      d ) database="$OPTARG" ;;
      h ) hostname="$OPTARG" ;;
      u ) user="$OPTARG" ;;
      p ) password="$OPTARG" ;;
   esac
done

if [ -z "$database" ] || [ -z "$user" ]
then
    echo "ERROR: missing argument(s)"
    printhelp
fi

if [ -z "$password" ]
then
    command -v pwgen
    if [ $? -eq 0 ]
    then
        password=`pwgen 32 1`
    else
        stty -echo
        printf "Password: "
        read password
        stty echo
        printf "\n"
    fi
fi

mysql -e "CREATE DATABASE IF NOT EXISTS \`$database\`;" \
    && mysql -e "GRANT ALL PRIVILEGES ON \`$database\`.* TO \`$user\`@\`$hostname\` IDENTIFIED BY \`$password\`;" \
    && mysql -e "FLUSH PRIVILEGES;" \
    && echo "------------+------------------------------------" \
    && printf " database:  |  $database\n" \
    && echo "------------+------------------------------------" \
    && printf " hostname:  |  $hostname\n" \
    && echo "------------+------------------------------------" \
    && printf " user:      |  $user\n" \
    && echo "------------+------------------------------------" \
    && printf " password:  |  $password\n" \
    && echo "------------+------------------------------------" \
    && exit 0
