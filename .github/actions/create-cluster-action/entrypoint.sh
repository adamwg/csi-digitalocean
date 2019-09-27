#!/bin/sh -l


# echo "Creating droplet"
# /app/doctl compute droplet create foobar --region nyc3 --image ubuntu-18-04-x64 --size s-1vcpu-1gb

RANDOM_STRING=$(hexdump -n 12 -e '3/4 "%08X" 1 "\n"' /dev/random)
NAME=test-cluster-$(echo ${RANDOM_STRING} | tr '[:upper:]' '[:lower:]')

echo "Creating k8s cluster: ${NAME}"
/app/doctl kubernetes cluster create ${NAME} --update-kubeconfig=false
CLUSTER_ID=$(/app/doctl kubernetes cluster get ${NAME} | grep ${NAME} | awk '{print $1}')
KUBECONFIG=$(/app/doctl kubernetes cluster kubeconfig show ${NAME} | base64)

echo "::set-output name=CLUSTER_NAME::${NAME}"
echo "::set-output name=CLUSTER_ID::${CLUSTER_ID}"
echo "::set-output name=KUBECONFIG::${KUBECONFIG}"

cp /github/home/.kube/config ${HOME}/kconfig
