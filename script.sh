#!/bin/bash

DATA=$(date +%d/%m/%Y)

HORA=$(date +%H:%M:%S)

SERVICO="httpd"

STATUS=$(systemctl is-active $SERVICO)

if [ $STATUS == "active" ]; then

    MENSAGEM="O $SERVICO está ONLINE"echo "$DATA $HORA - $SERVICO - active - $MENSAGEM" >> /nfs/paulo/online.txt

else

    MENSAGEM="O $SERVICO está offline"echo "$DATA $HORA - $SERVICO - inactive - $MENSAGEM" >> /nfs/paulo/offline.txt

Fi 
