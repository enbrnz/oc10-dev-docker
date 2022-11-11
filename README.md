# oc10-dev-docker
owncloud-php-development-docker container

## Installation
Checkout repo
- `git clone https://github.com/enbrnz/oc10-dev-docker.git`

Change into directory
- `cd oc10-dev-docker`

Docker pull dependencies, to make sure they are up to date
- `docker pull mlocati/php-extension-installer`
- `docker pull node:16-bullseye-slim`

Run docker build
- `docker build -t oc10-dev:latest .`

Start docker container like so:
- `docker run --name oc10-dev -e 8000 -v /path/to/your/local/owncloud/repo:/home/owncloud oc10-dev:latest`

This works very well on Debian based systems as your user id group id combination, the owner of the repository files, is very likely the same as the owncloud user inside the docker container.

If your `uid:gid` is not `1000:1000`, make sure to adjust the `useradd` command in Line 37 of the `Dockerfile` like so:
```
- RUN useradd owncloud
+ RUN useradd -u <your UID number> -g <your GID number> owncloud
```

## Usage
Make sure to run make commands inside the container, e.g:
- `docker exec -ti oc10-dev bash` 

OR
- `docker exec -ti oc10-dev make test...`

When working inside an ownCloud app, run the make command with a specific working directory:
- `docker exec -ti -w /home/owncloud/apps/<appid> oc10-dev make test..`