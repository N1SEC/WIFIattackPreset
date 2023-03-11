#!/bin/bash

#Colours
turquesaColour="\e[1;32m\033[0m"
endColour="\033[0m\e[0m"
redColour="\e[1;31m\033[1m"
RedColour="\e[5;31m\033[1m"
yellowColour="\e[1;33m\033[1m"
YellowColour="\e[5;33m\033[1m"
purpleColour="\e[1;35m\033[1m"
PurpleColour="\e[5;35m\033[1m"
greenColour="\e[1;36m\033[1m"
GreenColour="\e[5;36m\033[1m"
whiteColour="\e[1;37m\033[1m"
WhiteColour="\e[5;37m\033[1m"
grayColour="\e[1;34m\033[1m"

trap ctrl_c INT 

function ctrl_c(){
    echo -e "\n\n${redColour}[!] Saliendo....${endColour}\n"

    tput cnorm; exit 1 
}

function helpPanel(){
    echo -e "\n${redColour}[+] Uso:${endColour} ${purpleColour}./WIFIattackPreset.sh <parameters>${purpleColour}"
    for line in $(seq 1 70); do 
        echo -ne "${grayColour}-${endColour}"
    done
    echo -e "\n${redColour}Parameters:${endColour}\n"
    echo -e "\t ${purpleColour}-a${endColour}               Deshabilita procesos de red en segundo plano"
    echo -e "\t ${purpleColour}-l${endColour}               Lista las interfaces de Red"
    echo -e "\t ${purpleColour}-m${endColour}               Cambia a modo MONITOR"
    echo -e "\t ${purpleColour}-c${endColour}               Cambia la direccion MAC de la interfaz de red(Opcional)"
    echo -e "\t ${purpleColour}-r${endColour}               Restauracion de procesos en segundo plano e interfaces de red alteradas"
    tput cnorm; exit 0
}

function disableProcesses(){
    echo -e "\n${redColour}[!] Deshabilitando procesos de red${endColour}\n"
    sudo service NetworkManager stop && sudo service wpa_supplicant stop
    echo -e "\n${RedColour}[*] Proceso completado${endColour}\n"

    tput cnorm; exit 0
}

function listInterfaces(){
    for line in $(seq 1 70); do
        echo -ne "${whiteColour}-${endColour}"
    done
    echo -e "\n"; iwconfig 
    for line in $(seq 1 70); do
        echo -ne "${whiteColour}-${endColour}"
    done
}

function changeMode(){
    echo -e "\n${redColour}[!] Ingrese el nombre de interfaz:${endColour}\n"
    read interface
    ifconfig $interface down
    iwconfig $interface mode Monitor
    ifconfig $interface up
    echo -e "\n${RedColour}[*] Accion completada ${endColour}\n"
}

function changeMac(){
    echo -e "\n\n${redColour}[!] Para cambiar su direccion MAC, debe ingresar el nombre de la interfaz:\n${endColour}"
    read interface; echo -e "\n"
    sudo ifconfig $interface down
    sudo macchanger -r $interface
    sudo ifconfig $interface up
    echo -e "\n${RedColour}[*] Accion completada\n${endColour}"
}

function Restoration(){
    echo -e "\n\n${grayColour}[+] Resturacion de valores...\n${endColour}"
    echo -e "${yellowColour}[!] Ingrese el nombre de interfaz para restaurar sus valor de configuracion con normalidad:${endColour}\n"
    read interface
    ifconfig $interface down
    iwconfig $interface mode Managed
    ifconfig $interface up
    sudo service NetworkManager restart && sudo service wpa_supplicant restart; echo -e "\n"
    echo -e "${yellowColour}[+] Sub procesos y configuraciones restablecidas.\n${endColour}"
}

# Parameters
parameter_counter=0

while getopts "a?l?m?c?r?h" arg; do
    case $arg in
        a) disable_processes=$OPTARG; let parameter_counter+=1;;
        l) list_interfaces=$OPTARG; let parameter_counter+=2;;
        m) change_mode=$OPTARG; let parameter_counter+=3;;
        c) change_mac=$OPTARG; let parameter_counter+=4;;
        r) restoration=$OPTARG; let parameter_counter+=5;;
        h) helpPanel;;
    esac
done

# Conditions
if [ $parameter_counter == 0 ];then
    helpPanel
else
    if [ $parameter_counter == 1 ]; then
        disableProcesses
    else
        if [ $parameter_counter == 2 ]; then
            listInterfaces
        else
            if [ $parameter_counter = 3 ]; then
                changeMode
            else
                if [ $parameter_counter == 4 ]; then
                    changeMac
                else
                    if [ $parameter_counter == 5 ]; then
                        Restoration
                    fi
                fi
            fi
        fi
    fi
fi
