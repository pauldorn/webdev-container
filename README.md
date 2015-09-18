# webdev-container
Dockerized WebStorm and CLion (Requires license, not provided. 30 day trial)

My teams are not allowed to install NodeJS on bare metal to force the use of Docker for development.
This tool is meant to automate building a friendly environment in which to run Webstorm or CLion in docker.

It automatically:
- Downloads the latest WebStorm and CLion IDEs from JetBrains
- Creates Desktop launchers to run your IDEs and a Shell in the same docker container.
- The shell also gives you the container ID so you can open other connections/manipulate the container.
- Installs nodejs 0.10.x (Yeah, I know, if you want a newer one, just tweak the Dockerfile)
- Mount your .ssh directory in the container to allow you access to your git repos.
- Mounts .clionXX and .WebStormXX in the container so that all of your CLion and WebStorm instances share configs and licenses.
- Mount a directory named workspace under your user account.  This is where my team
  typically will clone repos to work with them.

Run the init.sh script to build out a Dockerfile and build your image.

Once init.sh completes, you should be able to use the desktop launchers to run the IDEs.

This tool was developed on Ubuntu 14.04.  If you are using another desktop OS your mileage may vary.
