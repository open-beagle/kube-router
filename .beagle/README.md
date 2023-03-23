# cloudnativelabs/kube-router

## repo

```bash
git remote add upstream git@github.com:cloudnativelabs/kube-router.git

git fetch upstream

git merge v1.3.1
```

## build

```bash
# gobgp
docker run -it --rm \
-w /go/src/github.com/cloudnativelabs/kube-router/ \
-v $PWD/:/go/src/github.com/cloudnativelabs/kube-router/ \
registry.cn-qingdao.aliyuncs.com/wod/gobgp:v2.33.0 \
sh -c "mkdir -p dist && cp -r /gobgp/bin/gobgp* dist/"

# golang
docker run -it --rm \
-w /go/src/github.com/cloudnativelabs/kube-router/ \
-v $PWD/:/go/src/github.com/cloudnativelabs/kube-router/ \
-e CI_WORKSPACE=/go/src/github.com/cloudnativelabs/kube-router \
-e PLUGIN_BINARY=kube-router \
-e PLUGIN_MAIN=cmd/kube-router \
registry.cn-qingdao.aliyuncs.com/wod/devops-go-arch:1.19-alpine

# build
docker build \
  --build-arg BASE=registry.cn-qingdao.aliyuncs.com/wod/alpine:3-mips64le \
  --build-arg AUTHOR=mengkzhaoyun@gmail.com \
  --build-arg VERSION=v1.3.1 \
  --build-arg TARGETOS=linux \
  --build-arg TARGETARCH=mips64le \
  --tag registry.cn-qingdao.aliyuncs.com/wod/kube-router:v1.3.1-mips64le \
  --file .beagle/dockerfile .

docker push registry.cn-qingdao.aliyuncs.com/wod/kube-router:v1.3.1-mips64le
```

## cache

```bash
# golang cache
docker run -it --rm \
-v $PWD/:/go/src/github.com/cloudnativelabs/kube-router \
-w /go/src/github.com/cloudnativelabs/kube-router \
registry.cn-qingdao.aliyuncs.com/wod/golang:1.19-alpine \
sh -c "
go mod tidy && \
go mod vendor
"
```

```bash
# 构建缓存-->推送缓存至服务器
docker run -it --rm \
  -e PLUGIN_REBUILD=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="kube-router" \
  -e PLUGIN_MOUNT=".git,./vendor" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0

# 读取缓存-->将缓存从服务器拉取到本地
docker run -it --rm \
  -e PLUGIN_RESTORE=true \
  -e PLUGIN_ENDPOINT=$PLUGIN_ENDPOINT \
  -e PLUGIN_ACCESS_KEY=$PLUGIN_ACCESS_KEY \
  -e PLUGIN_SECRET_KEY=$PLUGIN_SECRET_KEY \
  -e DRONE_REPO_OWNER="open-beagle" \
  -e DRONE_REPO_NAME="drone" \
  -v $(pwd):$(pwd) \
  -w $(pwd) \
  registry.cn-qingdao.aliyuncs.com/wod/devops-s3-cache:1.0
```

