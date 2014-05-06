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

# create node on /dev 
echo -e "cria nó de dispositivo em /dev/fisl15"
# lê o dmes, procura a mensagem de registro, 
# pega apenas a ultima, corta somente o numero
MAJOR=$(dmesg | grep "registrado com major=" \
              | tail -n 1 | cut -d= -f2) 

if [[ $(find /dev -name fisl15) == "" ]]; then
	echo -e "# mknod /dev/fisl15 c" $MAJOR 0 "\n"
	mknod /dev/fisl15 c $MAJOR 0
else
	echo -e "/dev/fisl15 já existe\n"
fi;
echo -e "$ ls -l /dev/fisl15 --color=auto\n"
ls -l /dev/fisl15 --color=auto
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# read from /dev/fisl15 
echo -e "lê 5x a partir de /dev/fisl15\n"
echo "# for i in {1..5}; do cat /dev/fisl15; echo -e \"\\n\"; done;"
echo -e "\n"
for i in {1..5}; do
	cat /dev/fisl15
	echo -e "\n"
done;
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# write once and read again from /dev/fisl15 
echo -e "escreve uma vez e lê de novo 5x a partir de /dev/fisl15\n"
echo -e "# echo \"ubuntu\" > /dev/fisl15\n"
echo "ubuntu" > /dev/fisl15

echo "# for i in {1..5}; do cat /dev/fisl15; echo -e \"\\n\"; done;"
echo -e "\n"
for i in {1..5}; do
	cat /dev/fisl15
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
echo -e "# rmmod device.ko\n"
rmmod device.ko
read -p "Continuar ... "
echo -e "----------------------------------------------"


# message on dmesg
echo -e "mensagem no dmesg (display messages)\n"
echo -e "dmesg | tail\n"
dmesg | tail
echo -e "----------------------------------------------"
