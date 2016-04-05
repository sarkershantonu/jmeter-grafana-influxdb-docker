
set -m
CONFIG_FILE="/etc/influxdb/influxdb.conf"
API_URL="http://localhost:8086"

#i am creating db when startm no need the bottom part if you dont want to create DB

echo "=> About to create the following database: ${PRE_CREATE_DB}"
if [ -f "/.influxdb_configured" ]; then
    echo "=> Database had been created before, skipping ..."
else
    echo "=> Starting InfluxDB ..."
    exec /usr/bin/influxdb -config=${CONFIG_FILE} &
    arr=$(echo ${PRE_CREATE_DB} | tr ";" "\n")

    #wait for the startup of influxdb
    RET=1
    while [[ RET -ne 0 ]]; do
        echo "=> Waiting for confirmation of InfluxDB service startup ..."
        sleep 3 
        curl -k ${API_URL}/ping 2> /dev/null
        RET=$?
    done
    echo ""

    for x in $arr
    do
        echo "=> Creating database: ${x}"
        curl -s -k -X POST -d "{\"name\":\"${x}\"}" $(echo ${API_URL}'/db?u=root&p=root')
    done
    echo ""
    
    echo "=> Creating User for database: data"
    curl -s -k -X POST -d "{\"name\":\"${INFLUXDB_DATA_USER}\",\"password\":\"${INFLUXDB_DATA_PW}\"}" $(echo ${API_URL}'/db/data/users?u=root&p=root')
    echo "=> Creating User for database: grafana"
    curl -s -k -X POST -d "{\"name\":\"${INFLUXDB_GRAFANA_USER}\",\"password\":\"${INFLUXDB_GRAFANA_PW}\"}" $(echo ${API_URL}'/db/grafana/users?u=root&p=root')
    echo ""
    
    echo "=> Changing Password for User: root"
    curl -s -k -X POST -d "{\"password\":\"${ROOT_PW}\"}" $(echo ${API_URL}'/cluster_admins/root?u=root&p=root')
    echo ""

    touch "/.influxdb_configured"
    exit 0
fi

exit 0