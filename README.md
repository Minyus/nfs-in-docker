# NFS in Docker

NFS version 3 server and client in docker.

A fork of [nfs-in-docker](https://github.com/mjstealey/nfs-in-docker)

Changes:
- bind-mount the server volume instead of volume-mounting.
- bind-mount the client volume.
- simplify the 4 directories to 2.

## About

Definitions for both an NFS server and client have been defined using CentOS 7 as the base. Using docker-compose to coordinate two node demonstration.

Volumes served by the NFS server can be defined as host volume mounts, or reside strictly inside the docker container. Volumes are mounted at runtime based on environment variables passed into the container.

## Environment variables

### Server

### `RPCNFSDCOUNT`

nfsd threads - number of nfsd threads to use. Default `=8`.

### `NFS_SERVER_DIRS`

NSF mounts - full path for server side NFS volumes, as seen by the container, that will be serviced. Default `='/nfs/share'`. All volumes should begin with `/nfs` and a semicolon (`:`) should be used between each path definition.

### Client

### `NFS_SERVER`

FQDN or IP - of the NFS server. Default `=server`.

### `NFS_SERVER_DIRS`

Volumes as provided from the NFS server. Default `='/nfs/share'`.

### `NFS_CLIENT_DIRS`

Volumes to mount on the client. Default `='/mnt/share'`. Must be an in order correlation to the volumes as defined in `NFS_SERVER_DIRS` as that is the order they will be mounted in. Example: `mount ${NFS_SERVER}:${NFS_SERVER_DIRS[0]} ${NFS_CLIENT_DIRS[0]}`

## Preliminary setup

## Start the `docker-compose.yml` file

A [docker-compose.yml](docker-compose.yml) file has been provided to create the two node server and client network for demonstration.

```console
$ docker-compose up -d
Creating client ... done
Creating server ... done
```

Once run the user should observe two new containers

```console
$ docker-compose ps
 Name               Command               State         Ports
-------------------------------------------------------------------
client   /usr/local/bin/tini -- /do ...   Up
server   /usr/local/bin/tini -- /do ...   Up      111/udp, 2049/tcp
```

At this point the NFS server container should be serving four directories to the NFS client container.


## Test with `nfs-test.sh`

A script named [nfs-test.sh](nfs-test.sh) has been provided to test the NFS mounts.
