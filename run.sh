echo "Running CTF Docker..."

if [[ $# -eq 0 ]]; then
    docker run -p 1337:1337 -it ctf-docker:latest bash -c "tmux new-session -d 'bash'; tmux new-window; tmux send 'python3 -m jupyter lab --port=1337 --no-browser --ip=0.0.0.0 --allow-root' ENTER; tmux a;"
else
    MOUNTS=""
    I=0
    for VAR in "$@"; do
        MOUNT="-v ${VAR}:/home/ctf/mount${I}"
        MOUNTS="${MOUNTS} ${MOUNT}"
        ((I=I+1))
    done
    echo "Mounting with: ${MOUNTS}..."
    echo "Ready. Paste the URL into your browser!"
    docker run -p 1337:1337 -it "${MOUNTS}" ctf-docker:latest bash -c "tmux new-session -d 'bash'; tmux new-window; tmux send 'python3 -m jupyter lab --port=1337 --no-browser --ip=0.0.0.0 --allow-root' ENTER; tmux a;"
fi

