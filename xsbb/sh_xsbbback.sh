#!/bin/sh
source /etc/storage/script/init.sh
appid=91UroQk3R6xRP5p6CD7bfDJm-MdYXbMMI
masterkey=nTvuqY42PHTv3aVknPqx9F28
api_base_url=91uroqk3.api.lncldglobal.com


logger -t "xsbb备份" "开始备份"�
result1=`curl -X POST \
  -H "X-LC-Id: ${appid}" \
  -H "X-LC-Key: ${masterkey},master" \
  -H "Content-Type: application/json" \
  -d '{"classes":"content"}' \
  https://${api_base_url}/1.1/exportData`

echo ${result1}
status1=`echo ${result1} | sed 's/,/\n/g' | grep -w 'status'| sed 's/:/\n/g' | sed 's/"//g'| sed '1d'`
id=`echo ${result1} | sed 's/,/\n/g'| grep -w 'id' | sed 's/:/\n/g'| sed 's/"//g' | sed '1d'`

sleep 10
if [ ${status1}=running ] ; then
   result2=`curl -X GET -H "X-LC-Id: ${appid}" -H "X-LC-Key: ${masterkey},master" https://${api_base_url}/1.1/exportData/${id}`    
   echo ${result2}
   status2=`echo ${result2} | sed 's/,/\n/g'|grep -w 'status'|sed 's/:/\n/g' | sed 's/"//g'|sed '1d'`
   download=`echo ${result2} | sed 's/,/\n/g'|grep -w 'download'|sed 's/:/\n/' | sed 's/"//g' | sed 's/}//' | sed '1d' | sed 's/\\\//g'`
  # echo ${status2}
  # echo ${download} 
   ls_date=`date +%Y%m%d%H%M%S`
  # echo ${ls_date}
   filepath=/media/entertainment/tmp/xsbbback/${ls_date}.tar.gz
   sleep 10 
   if [ ${status2}=done ] ; then
      curl -L ${download}  -o ${filepath}
      sleep 30
      if [ -f ${filepath} ] ; then
         Sh45_wx_send.sh send_message "${ls_date}.tar.gz xsbb 已备份至 ${filepath}!" 
      fi
  fi
fi

logger -t "xsbb备份" "备份完成"
