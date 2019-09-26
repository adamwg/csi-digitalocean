#!/bin/sh -l

set -euo pipefail

echo "Deleting k8s cluster ${INPUT_CLUSTER_ID}"
/app/doctl kubernetes cluster rm -f ${INPUT_CLUSTER_ID}
