# qnimbus/llvd <!-- omit in toc -->

![Linting](https://github.com/qnimbus/docker-llvd/workflows/Linting/badge.svg?style=for-the-badge) ![Docker](https://github.com/qnimbus/docker-llvd/workflows/Docker/badge.svg?style=for-the-badge) ![Publish Docker image](https://github.com/QNimbus/docker-llvd/workflows/Publish%20Docker%20image/badge.svg?style=for-the-badge)

`llvd` - LLVD (Linkedin Learning Video Downloader) in a Docker container

## Table of Contents <!-- omit in toc -->

- [Quick Start](#quick-start)
- [Environment variables](#environment-variables)
- [Shell access](#shell-access)
- [Configuration](#configuration)
- [Support or Contact](#support-or-contact)
- [Troubleshooting](#troubleshooting)

## Quick Start

**NOTE**: The docker command provided in this quick start is just an example. You will likely need to add additional parameters depending on how you would like to use `llvd`.

It is suggested to configure an shell function as follows (and append to your `~/.profile` file):

```bash
function llvd() {
    docker run \
        --rm -it \
        --name llvd \
        -e PGID=$(id -g) \
        -e PUID=$(id -u) \
        -v "$(pwd)"/downloads:/downloads:rw \
        qnimbus/llvd $@
}
```

Or using `docker-compose`:

```bash
PGID=$(id -g) PUID=$(id -u) docker-compose run --rm llvd
```

**HANDY HINT:** After updating your `~/.profile` file, run `source ~/.profile` to make your changes live! Alternatively you can logout of your shell and log back in.

When you run `llvd` (e.g: `llvd <video_url>`) it will download the video file to the `./downloads` folder in your current working directory.

## Environment variables

| Environment variable | Default    | Possible values      | Description                                               |
| -------------------- | ---------- | -------------------- | --------------------------------------------------------- |
| `LOG`                | `yes`      | yes, no, true, false | Writes stderr and stdout to `/downloads/log` folder. |
| `PGID`               | `$(id -g)` | valid GID            | The group id (GID) used to run the `llvd` as.       |
| `PUID`               | `$(id -u)` | valid UID            | The user id (UID) used to run the `llvd` as.        |

## Shell access

To get shell access to a running container execute the following command:

```bash
docker exec -ti [CONTAINER NAME] /bin/bash
```

Where `CONTAINER` is the name of the running container.

To start a fresh container with a shell (instead of `llvd`) execute the following command:

```bash
docker run --rm -ti --entrypoint=/bin/bash qnimbus/llvd
```

## Configuration

Visit the official [`llvd`](https://github.com/knowbee/llvd/blob/master/README.md) documentation for options.

## Support or Contact

Having troubles with the container or have questions? Please [create a new issue](https://github.com/qnimbus/docker-llvd/issues).

## Troubleshooting

When running the docker commands from a Windows Git Bash shell (MSYS) you may need to prepend the `MSYS_NO_PATHCONV=1` environment variable to the commands like so:

```bash
MSYS_NO_PATHCONV=1 docker run --rm -it -v ${PWD}/downloads:/downloads qnimbus/llvd --version
```
