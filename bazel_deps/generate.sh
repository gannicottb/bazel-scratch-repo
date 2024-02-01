#!/bin/bash

REPO_ROOT=$(git rev-parse --show-toplevel)

scala::deps() {
  # `deps_dir` is relative from REPO_ROOT to the folder that contains:
  #  
  # dependencies.yaml
  # 3rdparty/
  #   workspace.bzl
  #   target_file.bzl
  # example usage: `generate.sh scala`

  local deps_dir=${1%/}

  echo "Fetching Bazel deps according to $deps_dir/dependencies.yaml..." 
  _scala::deps::generate "$deps_dir" --resolved-output $deps_dir/3rdparty/artifacts.json
  # A note on the above: --resolved-output is used to generate a dependency reference that's easier on the eyes than workspace.bzl or target_file.bzl

  echo "Formatting $deps_dir/dependencies.yaml..."
  _scala::deps::format "$deps_dir"
}

_scala::deps::format() {
  local deps_dir=${1%/}
  bazel run --ui_event_filters=-info $(_scala::deps::bazel-deps-target) -- format-deps -d $deps_dir/dependencies.yaml -o
}

_scala::deps::generate() {
  local deps_dir=${1%/}
  shift
  local args="$@"
  
  bazel run --ui_event_filters=-info $(_scala::deps::bazel-deps-target) -- generate \
    --repo-root ${REPO_ROOT} \
    --deps $deps_dir/dependencies.yaml \
    --sha-file $deps_dir/3rdparty/workspace.bzl \
    --target-file $deps_dir/3rdparty/target_file.bzl \
    --disable-3rdparty-in-repo \
    $args
}

_scala::deps::bazel-deps-target(){
  echo "//bazel_deps"
}

scala::deps $@
