# docker-prometheus
local polling instance using docker to host: prometheus/cadvisor/redis for host node monitoring

Still a work in progress, but updating your local paths to reflect properly, it ought to at least launch. 

Nailing down the services and directories and will replace all the paths with some cleaner VARS at the top of the compose and pometheus.yml for easier integration when cloned into your local repo. Might even set up a nice "setup.sh" script that moves a few things around before kickoff but we'll see how far I get.

Feel free to clone and use in your projects, I'm just tinkering with a better monitoring setup and hopefully this'll do what I want it to when I'm done with it.

~Scotchman0


** Copy daemon.json to /etc/docker and update the file with your local IP address for the node and then run:
- `$ sudo systemctl daemon-reload` #to restart the dockerd configs before restarting the service
- `$ sudo systemctl restart docker` #to restart the service

Then, update all instances of `HOST_IP` with your local node IP:
- `$ sed -i 's/HOST_IP/<your_node_IP>/g' docker-compose.yml`
- `$ sed -i 's/HOST_IP/<your_node_IP>/g' prometheus.yml`

To launch the stack: (deb/ubuntu)
1. `$ sudo apt install docker-compose`
2. `$ docker-compose up` # in the folder that owns this service

To launch the stack: (rhel/fedora) #you may need to modify the docker-compose.yml file to update the permissions for the stack somewhat, but it should still boot the basic pod setup - this will be improved in future versions - may not work correctly.
1. `$ sudo yum install podman-compose`
2. `$ podman-compose up` # in the folder that owns this service

See: https://docs.docker.com/config/daemon/prometheus/ for more information/usage

If it launches correctly you should see:
`prometheus_new | level=info ts=<date>T02:14:38.433Z caller=main.go:794 msg="Server is ready to receive│` in the output

# access addresses after spin up:
- prometheus instance at http://localhost:30090 (moved from default 9090 since cockpit rides on that port)
- grafana at http://localhost:3000
- raw docker value output at http://localhost:9323/metrics
- raw node_exporter content/redis at http://localhost:9100/metrics (depending on build develop/main)
