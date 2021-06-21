#!/bin/bash

# Copyright 2021 Authors of Cilium
# SPDX-License-Identifier: Apache-2.0

set -o errexit
set -o pipefail
set -o nounset

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

distro="${1}"
version="${2}"

config_dir="${3}"

shift 3

binary="${script_dir}/bin/openshift-install-${distro}-${version}"

if [ "$#" -gt 0 ] ; then
  extra_manifests=("${@}")
  for i in "${extra_manifests[@]}" ; do cp "${i}" "${config_dir}/manifests" ; done
fi

"${binary}" create ignition-configs --dir "${config_dir}"