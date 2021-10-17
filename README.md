# docker-prometheus
local polling instance using docker to host: prometheus/cadvisor/redis for host node monitoring

Still a work in progress, but updating your local paths to reflect properly, it ought to at least launch. 

Nailing down the services and directories and will replace all the paths with some cleaner VARS at the top of the compose and pometheus.yml for easier integration when cloned into your local repo. Might even set up a nice "setup.sh" script that moves a few things around before kickoff but we'll see how far I get.

Feel free to clone and use in your projects, I'm just tinkering with a better monitoring setup and hopefully this'll do what I want it to when I'm done with it.

~Scotchman0


** Copy daemon.json to /etc/docker and then run:
$ sudo systemctl daemon-reload #to restart the dockerd configs before restarting the service
$ sudo systemctl restart docker #to restart the service

To launch the stack, install docker-compose, then run: `$ docker-compose up` in the folder that owns this service

See: https://docs.docker.com/config/daemon/prometheus/ for more information/usage guidance, this is just a version that also includes cadvisor and grafana in the build for ease of access.

If it launches correctly you should see:
"prometheus_new | level=info ts=2021-10-17T02:14:38.433Z caller=main.go:794 msg="Server is ready to receive│" in the output

access the prometheus instance at localhost:30090 (moved from default 9090 since cockpit rides on that port)
grafana at localhost:3000

Accessing the below values in prometheus is still a work in progress - it doesn't appear to want to scrape correctly, even though the content is available. Working on it.
raw docker value output at localhost:9323/metrics
raw node_exporter content/redis at localhost:9100/metrics (depending on build develop/main)
