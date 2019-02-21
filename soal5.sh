# !/bin/bash


awk '{if ($0 ~ /cron/ && $0 !~ /sudo/ && NF < 13) print $0}' /var/log/syslog >> /home/yudhis/modul1/syslogno5.log
