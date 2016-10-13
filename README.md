# quindar-deploy
Files needed to deploy (install) Quindar.


## Architecture

Quindar has three components:

1. The front end (gui)          > quindar-ux
2. The backend (server)         > quindar-svr
3. The simulator (data source)  > quindar-src




## Install

To deploy quindar using docker, do the following:

1. Install Docker
2. Clone this repository

3. Build the docker image
`docker build -t "quindar:ux" .`

4. Run the docker image with ports mapped for various services 

 * ssh     : 22
 * nginx   : 80,443
 * webmin  : 10000
 * netdata : 19999
 
`docker run -d --cap-add SYS_PTRACE \
			-v /proc:/host/proc:ro \
			-v /sys:/host/sys:ro \
			-p    22:22    \
			-p    80:80    \
			-p   443:443   \
			-p 10000:10000 \			
			-p 19999:19999 \						
			quindar:ux`