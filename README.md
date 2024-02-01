# Bazel Scratch Repo

Purpose: Establish a minimal Bazel environment for isolated testing of various Scala build issues.

## Getting started

Comment out these lines in WORKSPACE
```
load("//scala/3rdparty:workspace.bzl", maven_dependencies = "maven_dependencies")
load("//scala/3rdparty:target_file.bzl", build_external_workspace = "build_external_workspace")

maven_dependencies()
build_external_workspace(name = "scratch_3rdparty")
```

```shell
./bazel_deps/generate.sh scala
```

Uncomment the above lines.

```shell
bazel run //scala/app:bin
```
