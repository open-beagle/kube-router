module github.com/cloudnativelabs/kube-router

require (
	github.com/aws/aws-sdk-go v1.38.70
	github.com/containerd/containerd v1.5.4 // indirect
	github.com/containernetworking/cni v0.8.1
	github.com/containernetworking/plugins v0.9.1
	github.com/coreos/go-iptables v0.6.0
	github.com/docker/distribution v2.7.1+incompatible // indirect
	github.com/docker/docker v20.10.8+incompatible
	github.com/docker/go-connections v0.4.0 // indirect
	github.com/golang/protobuf v1.4.3
	github.com/gorilla/mux v1.8.0 // indirect
	github.com/moby/ipvs v1.0.1
	github.com/morikuni/aec v1.0.0 // indirect
	github.com/onsi/ginkgo v1.16.4
	github.com/onsi/gomega v1.11.0
	github.com/osrg/gobgp v0.0.0-20210801043420-9e48a36ed97c
	github.com/prometheus/client_golang v1.11.0
	github.com/spf13/pflag v1.0.5
	github.com/stretchr/testify v1.7.0
	github.com/vishvananda/netlink v1.1.1-0.20201029203352-d40f9887b852
	github.com/vishvananda/netns v0.0.0-20210104183010-2eb08e3e575f
	golang.org/x/net v0.0.0-20210805182204-aaa1db679c0d
	google.golang.org/grpc v1.39.1
	k8s.io/api v0.21.3
	k8s.io/apimachinery v0.21.3
	k8s.io/client-go v0.21.3
	k8s.io/cri-api v0.21.3
	k8s.io/klog/v2 v2.10.0
)

replace github.com/containerd/containerd => github.com/containerd/containerd v1.5.4 // CVE-2021-32760

go 1.16
