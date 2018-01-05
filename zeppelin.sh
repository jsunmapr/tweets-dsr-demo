#Drill interpreter

sessionID=`curl -i --data 'userName=mapr&password=mapr' -k -X POST https://localhost:9995/api/login | grep HttpOnly | tail -1 | awk -F: '{print $2}'`
iID=`curl -b $sessionID -k https://localhost:9995/api/interpreter/setting | python -m json.tool |egrep -A 1 "group.*drill" | grep id | awk -F: '{print $2}' | sed 's/,//g' | sed 's/"//g' | sed 's/ +//g'`

interpreterID="$(echo -e "${iID}" | sed -e 's/^[[:space:]]*//')"

#curl -b $sessionID -k https://localhost:9995/api/interpreter/setting/${interpreterID} | python -m json.tool > /tmp/drill.json

curl -b $sessionID -k -i -X PUT -H "Content-Type: application/json" -d @drill.json https://localhost:9995/api/interpreter/setting/${interpreterID}

#Hive interpreter

sessionID=`curl -i --data 'userName=mapr&password=mapr' -k -X POST https://localhost:9995/api/login | grep HttpOnly | tail -1 | awk -F: '{print $2}'`
iID=`curl -b $sessionID -k https://localhost:9995/api/interpreter/setting | python -m json.tool |egrep -A 1 "group.*hive" | grep id | awk -F: '{print $2}' | sed 's/,//g' | sed 's/"//g' | sed 's/ +//g'`

interpreterID="$(echo -e "${iID}" | sed -e 's/^[[:space:]]*//')"

curl -b $sessionID -k -i -X PUT -H "Content-Type: application/json" -d @hive.json https://localhost:9995/api/interpreter/setting/${interpreterID}
