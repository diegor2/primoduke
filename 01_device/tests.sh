#!/bin/bash
clear

# testa se o usuário é root
# check if user is root
if [ $(id -un) != "root" ]; then
   echo -e "Esse script deve executar com usuário root" 1>&2
   echo -e "This script must be run as root user\n" 1>&2
   echo -e "e.g: sudo bash test.sh\n\n"
   exit 1
fi

#list module information
echo -e "lista as informações do modulo\n"
echo -e "$ modinfo device.ko\n"
modinfo device.ko
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"
#install the module

echo -e "instala o modulo\n"
echo -e "# insmod device.ko\n"
insmod device.ko
read -p "Continuar ... "
echo -e "----------------------------------------------"

#list installed modules
echo -e "lista os modulos instalados\n"
echo -e "$ lsmod | head \n"
lsmod | head
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# message on dmesg
echo -e "mensagem no dmesg (display messages)\n"
echo -e "$ dmesg | tail\n"
dmesg | tail
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

#remove the module 
echo -e "remove o module\n"
echo -e "# rmmod device.ko\n"
rmmod device.ko
read -p "Continuar ... "
echo -e "----------------------------------------------"


# message on dmesg
echo -e "mensagem no dmesg (display messages)\n"
echo -e "dmesg | tail\n"
dmesg | tail
echo -e "----------------------------------------------"
