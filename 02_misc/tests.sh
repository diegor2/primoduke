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
echo -e "$ modinfo misc.ko\n"
modinfo misc.ko
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"
#install the module

echo -e "instala o modulo\n"
echo -e "# insmod misc.ko\n"
insmod misc.ko
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

# check if there is the node on /dev 
echo -e "Valida se o nó de dispositivo em /dev/fisl15m existe"
if [[ $(find /dev -name fisl15m) != "" ]]; then
	echo -e "/dev/fisl15m foi criado pelo udev\n"
fi;
echo -e "$ ls -l /dev/fisl15m --color=auto\n"
ls -l /dev/fisl15m --color=auto
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# read from /dev/fisl15m 
echo -e "lê 5x a partir de /dev/fisl15m\n"
echo "# for i in {1..5}; do cat /dev/fisl15m; echo -e \"\\n\"; done;"
echo -e "\n"
for i in {1..5}; do
	cat /dev/fisl15m
	echo -e "\n"
done;
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# write once and read again from /dev/fisl15m 
echo -e "escreve uma vez e lê de novo 5x a partir de /dev/fisl15m\n"
echo -e "# echo \"ubuntu\" > /dev/fisl15m\n"
echo "ubuntu" > /dev/fisl15m

echo "# for i in {1..5}; do cat /dev/fisl15m; echo -e \"\\n\"; done;"
echo -e "\n"
for i in {1..5}; do
	cat /dev/fisl15m
	echo -e "\n"
done;
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# message on dmesg
echo -e "mensagem no dmesg (display messages)\n"
echo -e "$ dmesg | tail -n 50\n"
dmesg | tail -n 50
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

#remove the module 
echo -e "remove o module\n"
echo -e "# rmmod misc.ko\n"
rmmod misc.ko
read -p "Continuar ... "
echo -e "----------------------------------------------"


# message on dmesg
echo -e "mensagem no dmesg (display messages)\n"
echo -e "dmesg | tail\n"
dmesg | tail
echo -e "----------------------------------------------"
