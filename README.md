# docker-prometheus
local polling instance using docker to host: prometheus/cadvisor/redis for host node monitoring

Still a work in progress, but updating your local paths to reflect properly, it ought to at least launch. 

Nailing down the services and directories and will replace all the paths with some cleaner VARS at the top of the compose and pometheus.yml for easier integration when cloned into your local repo. Might even set up a nice "setup.sh" script that moves a few things around before kickoff but we'll see how far I get.

Feel free to clone and use in your projects, I'm just tinkering with a better monitoring setup and hopefully this'll do what I want it to when I'm done with it.

~Scotchman0


** Copy daemon.json to /etc/docker and then run: $ sudo systemctl restart docker to integrate.
