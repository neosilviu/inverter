#!/bin/bash

MQTT_SERVER=`cat /home/hass/inverter/mqtt.json | jq '.server' -r`
MQTT_PORT=`cat /home/hass/inverter/mqtt.json | jq '.port' -r`
MQTT_TOPIC=`cat /home/hass/inverter/mqtt.json | jq '.topic' -r`
MQTT_DEVICENAME=`cat /home/hass/inverter/mqtt.json | jq '.devicename' -r`
MQTT_USERNAME=`cat /home/hass/inverter/mqtt.json | jq '.username' -r`
MQTT_PASSWORD=`cat /home/hass/inverter/mqtt.json | jq '.password' -r`

while read rawcmd;
do

    echo "Incoming request send: [$rawcmd] to inverter."
    /home/hass/inverter/cli/inverter_poller -r $rawcmd;

done < <(mosquitto_sub -h $MQTT_SERVER -p $MQTT_PORT -u "$MQTT_USERNAME" -P "$MQTT_PASSWORD" -t "$MQTT_TOPIC/sensor/$MQTT_DEVICENAME" -q 1)