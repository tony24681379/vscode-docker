# vscode-docker

## On Linux

```
xhost +local:docker
docker run -d \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-e DISPLAY=unix${DISPLAY} \
--device /dev/snd \
tony24681379/vscode
```

## On Mac

Pre Require:

[Docker for Mac and GUI applications](https://fredrikaverpil.github.io/2016/07/31/docker-for-mac-and-gui-applications/)

```
brew cask install xquartz
brew install socat
```

```
xhost +local:docker
ip=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost + $ip

docker run -d \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
-e DISPLAY=$ip:0 \
tony24681379/vscode
``` 