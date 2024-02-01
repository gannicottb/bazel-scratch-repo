load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_file", "http_archive")

skylib_version = "1.3.0"
protobuf_version = "3.19.4"
bazel_deps_version = "0.1-52"
rules_scala_version = "6.3.0"
scala_version = "2.12.18"

maybe(
    http_archive,
    name = "bazel_skylib",
    sha256 = "74d544d96f4a5bb630d465ca8bbcfe231e3594e5aae57e1edbf17a6eb3ca2506",
    type = "tar.gz",
    url = "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/{}/bazel-skylib-{}.tar.gz".format(skylib_version, skylib_version),
)
maybe(
    http_archive,
    name = "com_google_protobuf",
    sha256 = "3bd7828aa5af4b13b99c191e8b1e884ebfa9ad371b0ce264605d347f135d2568",
    strip_prefix = "protobuf-{}".format(protobuf_version),
    urls = [
        "https://github.com/protocolbuffers/protobuf/archive/v{}.tar.gz".format(protobuf_version),
    ],
)

load("@bazel_skylib//:workspace.bzl", "bazel_skylib_workspace")
bazel_skylib_workspace()

load("@com_google_protobuf//:protobuf_deps.bzl", "protobuf_deps")
protobuf_deps()

# Python, Apparently??
# maybe(
#     http_archive,
#     name = "rules_python",
#     sha256 = "d71d2c67e0bce986e1c5a7731b4693226867c45bfe0b7c5e0067228a536fc580",
#     strip_prefix = "rules_python-0.29.0",
#     url = "https://github.com/bazelbuild/rules_python/releases/download/0.29.0/rules_python-0.29.0.tar.gz",
# )

# load("@rules_python//python:repositories.bzl", "py_repositories")

# py_repositories()

# Scala
maybe(
    http_archive,
    name = "io_bazel_rules_scala",
    sha256 = "7adaec1cc787ca1519550e71dbd0cb9c149ee1b06f04ba91dda07c12483aae57",
    strip_prefix = "rules_scala-{}".format(rules_scala_version),
    url = "https://github.com/bazelbuild/rules_scala/releases/download/v{}/rules_scala-v{}.tar.gz".format(rules_scala_version, rules_scala_version),
)

load("@io_bazel_rules_scala//:scala_config.bzl", "scala_config")
scala_config(scala_version = scala_version)


load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")
scala_repositories(fetch_sources = True)

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")
scala_register_toolchains()

load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")
scalatest_repositories()
scalatest_toolchain()

# Bazel-Deps
maybe(
    http_file,
    name = "bazeltools_bazel_deps_macos",
    sha256 = "a37ebb76fefc3961c5c1cf5461395dcd18694f200ea12ea140947838d1946d19",
    url = "https://github.com/bazeltools/bazel-deps/releases/download/v{}/bazel-deps-macos".format(bazel_deps_version),
    executable = True,
)
maybe(
    http_file,
    name = "bazeltools_bazel_deps_linux",
    sha256 = "bf9395f2d664cb4871fc48a1062e0b2e7d6cf0c0e442e115f654d275c5e6560e",
    url = "https://github.com/bazeltools/bazel-deps/releases/download/v{}/bazel-deps-linux".format(bazel_deps_version),
    executable = True,
)

load("//scala/3rdparty:workspace.bzl", maven_dependencies = "maven_dependencies")
load("//scala/3rdparty:target_file.bzl", build_external_workspace = "build_external_workspace")

maven_dependencies()
build_external_workspace(name = "scratch_3rdparty")
