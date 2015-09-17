#!/bin/bash
#[ -z $REPO ] && echo "You did not provide a repository." && exit 1
#[ -z $BRANCH ] && echo "You did not provide a branch." && exit 1
#[ -z $GIT_NAME ] && echo "You must provide a user name for git." && exit 1
#[ -z $GIT_EMAIL ] && echo "You must provide an email address for git." && exit 1

#git config --global user.email $GIT_EMAIL
#git config --global user.name $GIT_NAME


mkdir /home/developer/.ssh
cp -r /ssh/* /home/developer/.ssh/
#git clone -b $BRANCH $REPO $BRANCH
#cd $BRANCH
#git checkout $BRANCH

echo "***********************************************"
echo "You are starting $APPLICATION in a container"
#echo "You have cloned $REPO at $BRANCH"
#echo "Make sure you commit AND PUSH your changes or"
#echo "THEY WILL BE LOST when the container ends"
echo
echo "To get a shell in this container:"
echo "docker exec -it $HOSTNAME /bin/bash"
#/WebStorm-141.1550/bin/webstorm.sh /home/developer/$BRANCH > /home/developer/webstorm.log 2>&1 

echo
if [ "$APPLICATION" = "WEBSTORM" ]; then
/WebStorm-141.1550/bin/webstorm.sh > /home/developer/webstorm.log 2>&1 &
fi
if [ "$APPLICATION" = "CLION" ]; then
/clion-1.1.1/bin/clion.sh > /home/developer/clion.log 2>&1 &
fi

bash
