#!/usr/bin/env bash 

mkdir /home/developer/.ssh
cp -r /ssh/* /home/developer/.ssh/

echo "***********************************************"
echo "You are starting $APPLICATION in a container"
echo
echo "To get an addition shell in this container, in another shell run:"
echo "docker exec -it $HOSTNAME /bin/bash"

echo
if [ "$APPLICATION" = "WEBSTORM" ]; then
/Applications/WebStorm-143.1559.5/bin/webstorm.sh > /home/developer/webstorm.log 2>&1 &
fi
if [ "$APPLICATION" = "CLION" ]; then
/Applications/clion-1.2.4/bin/clion.sh > /home/developer/clion.log 2>&1 &
fi

bash -i
