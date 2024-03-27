# Bazel Scratch Repo

Purpose: Establish a minimal Bazel environment for isolated testing of various Scala build issues.

## Getting Started
```shell
bazel run //scala/app:bin
```

## If you change deps

```shell
./deps/repin.sh   
```
