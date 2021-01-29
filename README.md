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

Where paths is a space-separated list of directories to mount to the container. They will be mounted to /home/$USER/mount[0...].

# Configurables

A couple built in configurables:

1. You can use any JupyterLab theme from [here](https://github.com/arbennett/jupyterlab-themes) by modifying $THEME
2. You can modify the username and password with $USER and replacing `password` with something better.
3. You have the dockerfile....go to town. PRs welcome.
