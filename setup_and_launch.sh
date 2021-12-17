#!/bin/bash
#basic script to move things around, ensure docker-compose is installed and update local files with necessary IP changes.
#Will make the following adjustments to the file contents:
#1. will query for and install docker-compose if not found
#2. will prompt for you to set the HOST_IP variable
#3. will move daemon.json to /etc/docker/
#4. will start the stack on 'y' return when prompted.


###############################################################
if dpkg -l | grep docker-compose;
then echo "docker-compose already installed, skipping"
else sudo apt install docker-compose
fi

echo "Please set the HOST_IP"
echo "insert your localhost IP address <example: 192.168.0.2> and press return"
echo ""
read NEW_HOST_IP

sed -i 's/HOST_IP/$NEW_HOST_IP/g' ./docker-compose.yml
sed -i 's/HOST_IP/$NEW_HOST_IP/g' ./prometheus.yml
sed -i 's/HOST_IP/$NEW_HOST_IP/g' ./daemon.json

mv daemon.json /etc/docker/daemon.json.bak
cp daemon.json /etc/docker/

echo "docker restart needs to occur in order to update the metrics export"
echo "continue to restart docker service with systemctl? (y/n)"
read option
case $option in
    y|Y) echo "restarting docker"
        sudo systemctl restart docker
      ;;
    n|N) echo "skipping docker reload - note that docker metric scrape will be unavailable until next service restart"
      ;;
    *) echo "non y/n answer recieved, defaulting to no change"
      ;;
esac

echo "would you like to launch the stack now? (y/n)"
read option2
case $option2 in
    y|Y) echo "starting stack - press ctrl + c to stop the build"
        docker-compose up
      ;;
    n|N) echo "install completed - you may start the stack with 'docker-compose up' in this folder."
      ;;
    *) echo "non y/n answer recieved, exiting"
      ;;
esac
