FROM ubuntu:18.04

ENV TERM=xterm-256color
ENV TZ America/Indiana/Indianapolis
ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386
RUN apt-get -y update
RUN apt-get -y install \
    autoconf \
    automake \
    binutils \
    binwalk \
    bison \
    build-essential \
    clang \
    cmake \
    coreutils \
    curl \
    debian-archive-keyring \
    debootstrap \
    file \
    flex \
    g++-multilib \
    gcc-multilib \
    gdb \
    gdb-multiarch \
    git \
    lib32stdc++6 \
    libc6-dbg \
    libc6-dbg:i386 \
    libc6:i386 \
    libtool \
    libtool-bin \
    lldb \
    llvm \
    ltrace \
    nasm \
    neovim \
    netcat \
    openjdk-11-jdk \
    python \
    python-pip \
    python3 \
    python3-distutils \
    python3-pip \
    radare2 \
    socat \
    strace \
    tmux \
    unzip \
    wget \
    zsh \
    tzdata --fix-missing

RUN ln -fs /usr/share/zoneinfo/$TZ /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN sed -i 's/# deb-src/deb-src/' /etc/apt/sources.list
RUN apt-get -y update
RUN apt-get -y build-dep qemu
RUN python3 -m pip install -U pip
RUN python3 -m pip install virtualenv

WORKDIR /
RUN wget https://ghidra-sre.org/ghidra_9.1.2_PUBLIC_20200212.zip
RUN unzip ghidra_9.1.2_PUBLIC_20200212.zip

RUN git clone https://github.com/pwndbg/pwndbg /pwndbg
WORKDIR /pwndbg
RUN ./setup.sh
WORKDIR /

RUN git clone https://github.com/angr/angr-dev /angr-dev
WORKDIR /angr-dev
RUN ./setup.sh -i -e angr
WORKDIR /

RUN python3 -m pip install \
    git+https://github.com/shellphish/shellphish-afl \
    git+https://github.com/shellphish/driller \
    git+https://github.com/angr/tracer \
    one_gadget \
    jupyter \
    jupyterlab \
    ropgadget \
    pwntools \
    ropper \
    r2pipe

RUN python3 -m pip install \
    git+https://github.com/angr/phuzzer


ENV USER=ctf
ENV SHELL=/usr/bin/zsh

RUN apt-get -y install sudo
RUN useradd -m $USER -s $SHELL
RUN touch /home/$USER/.zshrc
RUN echo "$USER:password" | chpasswd && adduser $USER sudo

# ENV THEME=nord
USER $USER
RUN bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
WORKDIR /home/$USER/

