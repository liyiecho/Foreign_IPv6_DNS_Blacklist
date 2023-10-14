#!/bin/bash

echo -e "--------------------------------------------------------------\n"
raw_url="https://raw.githubusercontent.com/hezhijie0327/GFWList2AGH/main/gfwlist2adguardhome/blacklist_lite.txt"
raw_file_name=$(echo ${raw_url} | awk -F "/" '{print $NF}')
echo -e "开始下载：${raw_url} \n\n保存路径：${raw_file_name}\n"
wget -q --no-check-certificate -O "${raw_file_name}.new" ${raw_url}
if [[ $? -eq 0 ]]; then
    mv "${raw_file_name}.new" "${raw_file_name}"
    echo -e "下载 ${raw_file_name} 成功...\n"
    sed -i '1d ; s#\[##g ; s#]https://dns.opendns.com:443/dns-query##g ; s#\/#\n#g' "${raw_file_name}"
    sed -i '/^[  ]*$/d ; s#^#||&#g ; s#$#&^$dnstype=AAAA#g' "${raw_file_name}"
    mv "${raw_file_name}" Foreign_IPv6_DNS_Blacklist.txt
    echo -e "替换格式成功...\n"
else
    echo -e "下载 ${raw_file_name} 失败，保留之前正常下载的版本...\n"
    [ -f "${raw_file_name}.new" ] && rm -f "${raw_file_name}.new"
fi
