# ctf-docker

An easy to use and ready to go pwn docker for CTF players. Uses JupyterLab as a WebUI to manage terminals and editors.

# Prerequisites
- [Docker](https://docs.docker.com/get-docker/)

# Included Tools
- C/C++ Build Tools & Standard Libraries
- gdb w/pwndbg, lldb
- standard binary and system utilities
- angr-dev
- Shellphish Phuzzer
- one_gadget
- ropgadget, ropper
- pwntools

# Building
Build the container by:
```
git clone https://github.com/novafacing/ctf-docker
cd ctf-docker
./build.sh
```

# Running

Run the container by:

```
./run.sh [paths]
```

Where paths is an optional space-separated list of directories to mount to the container. They will be mounted to /root//mount[0...].

Like the output says....copy paste the link to your browser :)

If you get error output trying to use phuzzer, just copy and paste the commands *into your host machine's terminal*. They won't work inside the container.

# Configurables

1. You can modify the username and password with $USER and replacing `password` with something better.
2. You have the dockerfile....go to town. PRs welcome.

# Size

The container is about 6.6GB fully built. That sounds bad until you consider it has Phuzzer on it. Consider commenting out Phuzzer if you need the space, or just buy a bigger hard drive.
