# remote-desktop
最小的远程桌面

# 构建

```
docker buildx build --platform linux/amd64 -t lihaixin/remote-desktop:alpine.fluxbox . --push
```

# 运行

```
docker run -d --name rdp --shm-size 1g -p 3389:3389 -p 5901:5901 -p 6901:6901 lihaixin/remote-desktop:alpine.fluxbox
```
