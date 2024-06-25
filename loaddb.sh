#!/bin/bash

function loaddb() {
        OPTIND=1
        local drupaldb=""
        local productdb=""
        # Create a database file .cnf with following values and place it somewhere that this scrit can read.
        #
        # [client]
        # user = "username"
        # password = "password"
        # host = "127.0.0.1"
        # port = "3306"
        #
        local dbfile=""

        usage() {
                echo -e "${Yellow}Usage${ColorOff}: 'loaddb -d <Drupal Database File> -p <Product Database File>";
                return 1 2>/dev/null;
                exit 1;
        }

        interactive() {
                echo -e "${Yellow}Which Database CNF config File?${ColorOff}";
                read -e -r dbfile=${dbfile:-~/dbfile.cnf};
        
                echo -e "${Yellow}Which Drupal DB File?${ColorOff}";
                read -e -r drupaldb;

                echo -e "${Yellow}Which Product DB File?${ColorOff}";
                read -e -r productdb;
        }

        # Check if no variables are passed, then display usage
        if [ $# -eq 0 ]; then
                usage;
                return 1 2>/dev/null;
                exit 1;
        fi

#       echo "Drupal DB: ${drupaldb}";
#       echo "Product DB: ${productdb}";

        # Get the drupal and product database files from the command line
        while getopts 'd:p:f:i' opt; do
                case $opt in
                        d) drupaldb=$OPTARG ;;
                        p) productdb=$OPTARG ;;
                        f) dbfile=$OPTARG ;;
                        i) interactive
                esac
        done

        echo -e "${Yellow}Drupal DB:${ColorOff} ${drupaldb}";
        echo -e "${Yellow}Product DB:${ColorOff} ${productdb}";

        # If both Drupal and Product DB files are populated
        if [ -z ${drupaldb} ] && [ -z ${productdb} ] && [ -z ${dbfile} ]; then
                echo -e "${Red} Error!${ColorOff} Passed values cnf: '${dbfile}', db: '${drupaldb}' and pdb: '${productdb}' are invalid!";
        else
                if [ ! -f ${dbfile} ] ; then
                        echo -e "${Red}Warning! ${ColorOff} Database config file ${dbfile} does not exist!";
                        return 1 2>/dev/null;
                        exit 1;
                else
                        echo -e "${Green}Yay! ${ColorOff} Drupal file ${Yellow}${dbfile}${ColorOff} exists!";
                fi
                if [ ! -f ${drupaldb} ]; then
                        echo -e "${Red}Warning! ${ColorOff} Drupal file ${drupaldb} does not exist!";
                        return 1 2>/dev/null;
                        exit 1;
                else
                        echo -e "${Green}Yay! ${ColorOff} Drupal file ${Yellow}${drupaldb}${ColorOff} exists!";
                fi

                if [ ! -f ${productdb} ]; then
                        echo -e "${Red}Warning! ${ColorOff} Product file ${productdb} does not exist!";
                        return 1 2>/dev/null;
                        exit 1;
                else
                        echo -e "${Green}Yay! ${ColorOff} Product file ${Yellow}${productdb}${ColorOff} exists!";
                fi

                if [ -f ${drupaldb} ] && [ -f ${productdb} ]; then
                        echo -e "${Red}Dropping '${ColorOff}db${Red}' and '${ColorOff}product_data_store${Red}' databases${ColorOff}"
                        mysql --defaults-extra-file=~/${dbfile} -e "DROP DATABASE IF EXISTS db"
                        mysql --defaults-extra-file=~/${dbfile} -e "CREATE DATABASE IF NOT EXISTS db"
                        mysql --defaults-extra-file=~/${dbfile} -e "DROP DATABASE IF EXISTS product_data_store"
                        mysql --defaults-extra-file=~/${dbfile} -e "CREATE DATABASE IF NOT EXISTS product_data_store"

                        echo -e "${Green}Reading into Drupal DB file '${ColorOff}${drupaldb}${Green}'${ColorOff}"
                        mysql --defaults-extra-file=~/${dbfile} -D db < $drupaldb

                        echo -e "${Green}Reading into Product Data Store file '${ColorOff}${productdb}${Green}'${ColorOff}"
                        mysql --defaults-extra-file=~/${dbfile} -D product_data_store < $productdb
                else
                        echo -e "${Red}Warning!${ColorOff} No valid drupal or database file passed."
                fi
        fi
}
