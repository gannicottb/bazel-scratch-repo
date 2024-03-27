#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd -P)"

GIT_SHA="$(git describe --match=foobar --always --abbrev=16 --dirty)"
echo "STABLE_GIT_SHA ${GIT_SHA}"
