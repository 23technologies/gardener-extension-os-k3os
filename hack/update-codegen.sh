#!/bin/bash
#
# Copyright (c) 2020 SAP SE or an SAP affiliate company. All rights reserved. This file is licensed under the Apache Software License, v. 2 except as noted otherwise in the LICENSE file
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

rm -f $GOPATH/bin/*-gen

PROJECT_ROOT=$(dirname $0)/..

bash "${PROJECT_ROOT}"/vendor/k8s.io/code-generator/generate-internal-groups.sh \
  deepcopy,defaulter \
  github.com/gardener/gardener-extension-os-gardenlinux/pkg/client \
  github.com/gardener/gardener-extension-os-gardenlinux/pkg/apis \
  github.com/gardener/gardener-extension-os-gardenlinux/pkg/apis \
  "memoryonechost:v1alpha1" \
  --go-header-file "${PROJECT_ROOT}/vendor/github.com/gardener/gardener/hack/LICENSE_BOILERPLATE.txt"

bash "${PROJECT_ROOT}"/vendor/k8s.io/code-generator/generate-internal-groups.sh \
  conversion \
  github.com/gardener/gardener-extension-os-gardenlinux/pkg/client \
  github.com/gardener/gardener-extension-os-gardenlinux/pkg/apis \
  github.com/gardener/gardener-extension-os-gardenlinux/pkg/apis \
  "memoryonechost:v1alpha1" \
  --extra-peer-dirs=github.com/gardener/gardener-extension-os-gardenlinux/pkg/apis/memoryonechost,github.com/gardener/gardener-extension-os-gardenlinux/pkg/apis/memoryonechost/v1alpha1,k8s.io/apimachinery/pkg/apis/meta/v1,k8s.io/apimachinery/pkg/conversion,k8s.io/apimachinery/pkg/runtime \
  --go-header-file "${PROJECT_ROOT}/vendor/github.com/gardener/gardener/hack/LICENSE_BOILERPLATE.txt"