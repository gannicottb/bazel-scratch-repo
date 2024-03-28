load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive", "http_file")

skylib_version = "1.3.0"

protobuf_version = "3.19.4"

rules_jvm_external_version = "4.5"

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

load("@io_bazel_rules_scala//scala_proto:scala_proto.bzl", "scala_proto_repositories")
load("@io_bazel_rules_scala//scala_proto:toolchains.bzl", "scala_proto_register_toolchains")

scala_proto_repositories()

scala_proto_register_toolchains()

load("@io_bazel_rules_scala//scala:scala.bzl", "scala_repositories")

scala_repositories(
    fetch_sources = True,
)

load("@io_bazel_rules_scala//scala:toolchains.bzl", "scala_register_toolchains")

scala_register_toolchains()

load("@io_bazel_rules_scala//testing:scalatest.bzl", "scalatest_repositories", "scalatest_toolchain")

scalatest_repositories()

scalatest_toolchain()

# rules_jvm_external

http_archive(
    name = "rules_jvm_external",
    sha256 = "b17d7388feb9bfa7f2fa09031b32707df529f26c91ab9e5d909eb1676badd9a6",
    strip_prefix = "rules_jvm_external-%s" % rules_jvm_external_version,
    url = "https://github.com/bazelbuild/rules_jvm_external/archive/%s.zip" % rules_jvm_external_version,
)

load("@rules_jvm_external//:repositories.bzl", "rules_jvm_external_deps")

rules_jvm_external_deps()

load("@rules_jvm_external//:setup.bzl", "rules_jvm_external_setup")

rules_jvm_external_setup()

# deps - TODO: how to put this section into a separate file? do we need a repository_rule for that?

load("@rules_jvm_external//:defs.bzl", "maven_install")
load("@rules_jvm_external//:specs.bzl", "maven")
load("//deps:extensions.bzl", "scala")

maven_install(
    name = "maven",
    artifacts = [
        # out of date
        scala("org.slf4j:slf4j-api:2.0.7", foo = "bar", baz = []),
        maven.artifact(
            artifact = "logback-classic",
            exclusions = [
                "org.slf4j:slf4j-log4j12",
            ],
            group = "ch.qos.logback",
            version = "1.4.14",
        ),
        maven.artifact(
            artifact = "scala-logging_2.12",
            group = "com.typesafe.scala-logging",
            version = "3.9.5",
        ),
    ],
    fail_if_repin_required = True,
    fail_on_missing_checksum = True,
    fetch_javadoc = True,
    fetch_sources = True,
    maven_install_json = "@//deps:maven_install.json",  # where is the pin file
    override_targets = {
        # same as bazel-deps "replacements"
        "org.scala-lang:scala-compiler": "@io_bazel_rules_scala_scala_compiler",
        "org.scala-lang:scala-library": "@io_bazel_rules_scala_scala_library",
        "org.scala-lang:scala-reflect": "@io_bazel_rules_scala_scala_reflect",
    },
    repositories = [
        "https://oss.sonatype.org/content/repositories/public/",
        "https://repo1.maven.org/maven2",
    ],
    strict_visibility = True,
    version_conflict_policy = "pinned",
)

load("@maven//:defs.bzl", "pinned_maven_install")

pinned_maven_install()
