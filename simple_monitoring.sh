#!/bin/bash
# Save it to like /opt and chmod for execute:
# chmod +x /opt/simple_monitoring.sh
# Create cron job by command `crontab -e` for everyminute execute:
# * * * * *   /opt/simple_monitoring.sh
# And you can see it any time by command:
# tail -f /var/log/simple_mon.log

DATE=`date`
TIME=`{ time -p curl -o /dev/null --silent --head --write-out 'C: status %{http_code} | T: ' https://bot-vk.ru/top; } 2>&1 | grep -E "real|status"`
LA=`uptime | awk -F':' '{print $5}'`
CPU=`grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}'`

echo "| D: $DATE | $TIME | LA: $LA | CPU: $CPU |" >> /var/log/simple_mon.log
