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
RUN python3 -m pip install -U pip
RUN python -m pip install -U pip
RUN python3 -m pip install virtualenv
RUN python -m pip install virtualenv

# Install angr and phuzzer
# Note, you need cpu governor = performance
# It'll yell at you though no worries...
WORKDIR /root
RUN git clone https://github.com/angr/angr-dev /root/angr-dev
WORKDIR /root/angr-dev
RUN ./setup.sh -i -u
RUN python3 -m pip install \
    https://github.com/angr/wheels/blob/master/shellphish_afl-1.2.1-py2.py3-none-manylinux1_x86_64.whl?raw=true
RUN python3 -m pip install \
    https://github.com/angr/wheels/blob/master/shellphish_qemu-0.10.0-py3-none-manylinux1_x86_64.whl?raw=true
RUN ./setup.sh -u phuzzer
RUN python3 -c 'import phuzzer; print("Phuzzer Installed")'
WORKDIR /root/

RUN python3 -m pip install \
    one_gadget \
    jupyter \
    jupyterlab \
    ropgadget \
    pwntools \
    ropper \
    r2pipe

RUN git clone https://github.com/pwndbg/pwndbg /root/pwndbg
WORKDIR /root/pwndbg
RUN ./setup.sh
WORKDIR /root

# ENV THEME=nord
RUN bash -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

