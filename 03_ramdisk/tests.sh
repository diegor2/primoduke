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
echo -e "$ modinfo ramdisk.ko\n"
modinfo ramdisk.ko
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"
#install the module

echo -e "instala o modulo\n"
echo -e "# insmod ramdisk.ko\n"
insmod ramdisk.ko
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
echo -e "Valida se o nó de dispositivo em /dev/fisl15rd existe"
if [[ $(find /dev -name fisl15rd) != "" ]]; then
	echo -e "/dev/fisl15rd foi criado pelo udev\n"
fi;
echo -e "$ ls -l /dev/fisl15rd --color=auto\n"
ls -l /dev/fisl15rd --color=auto
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# read from /dev/fisl15rd 
echo -e "lê 5x a partir de /dev/fisl15rd\n"
echo "# for i in {1..5}; do cat /dev/fisl15rd; echo -e \"\\n\"; done;"
echo -e "\n"
for i in {1..5}; do
	cat /dev/fisl15rd
	echo -e "\n"
done;
echo -e "\n"
read -p "Continuar ... "
echo -e "----------------------------------------------"

# write once and read again from /dev/fisl15rd 
echo -e "escreve uma vez e lê de novo 5x a partir de /dev/fisl15rd\n"
echo -e "# echo \"Vai ter linux!\" > /dev/fisl15rd\n"
echo "Vai ter linux!" > /dev/fisl15rd

echo "# for i in {1..5}; do cat /dev/fisl15rd; echo -e \"\\n\"; done;"
echo -e "\n"
for i in {1..5}; do
	cat /dev/fisl15rd
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
echo -e "# rmmod ramdisk.ko\n"
rmmod ramdisk.ko
read -p "Continuar ... "
echo -e "----------------------------------------------"


# message on dmesg
echo -e "mensagem no dmesg (display messages)\n"
echo -e "dmesg | tail\n"
dmesg | tail
echo -e "----------------------------------------------"
