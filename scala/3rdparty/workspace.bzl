# Do not edit. bazel-deps autogenerates this file from scala/dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output = ctx.path("jar/%s" % jar_name),
        url = ctx.attr.urls,
        sha256 = ctx.attr.sha256,
        executable = False
    )
    src_name = "%s-sources.jar" % ctx.name
    srcjar_attr = ""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output = ctx.path("jar/%s" % src_name),
            url = ctx.attr.src_urls,
            sha256 = ctx.attr.src_sha256,
            executable = False
        )
        srcjar_attr = '\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "ch.qos.logback:logback-classic:1.4.14", "lang": "scala/unmangled", "sha1": "d98bc162275134cdf1518774da4a2a17ef6fb94d", "sha256": "8e832f7263ca606ae36dabb2d8b24c2f43d82cf634e81dad9d1640fa6ee3c596", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/ch/qos/logback/logback-classic/1.4.14/logback-classic-1.4.14.jar", "source": {"sha1": "1b0b0b96069e3ec3b4d8e5cbffc0a56e633063de", "sha256": "b3e670ccb6a8f2cfc6445f54c6fbfbc62bdd3912d147498d81e425d578dfb468", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/ch/qos/logback/logback-classic/1.4.14/logback-classic-1.4.14-sources.jar"} , "name": "ch_qos_logback_logback_classic", "actual": "@ch_qos_logback_logback_classic//jar:file", "bind": "jar/ch/qos/logback/logback_classic"},
    {"artifact": "ch.qos.logback:logback-core:1.4.14", "lang": "java", "sha1": "4d3c2248219ac0effeb380ed4c5280a80bf395e8", "sha256": "f8c2f05f42530b1852739507c1792f0080167850ed8f396444c6913d6617a293", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/ch/qos/logback/logback-core/1.4.14/logback-core-1.4.14.jar", "source": {"sha1": "7d9dcce57ba091e1e4b4793b244508ea28f52b48", "sha256": "760175e067af94b6d43b5d1558e154d60766de320618f78ff8cb8f956a7da92f", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/ch/qos/logback/logback-core/1.4.14/logback-core-1.4.14-sources.jar"} , "name": "ch_qos_logback_logback_core", "actual": "@ch_qos_logback_logback_core//jar", "bind": "jar/ch/qos/logback/logback_core"},
    {"artifact": "com.typesafe.scala-logging:scala-logging_2.12:3.9.5", "lang": "scala", "sha1": "40dc9977c3f044e3cf041f3316dbd67c8de6b269", "sha256": "392979e5525856737a6f2398e25789d0b2057c8e3c55045a6e8d9704c21de7a6", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/com/typesafe/scala-logging/scala-logging_2.12/3.9.5/scala-logging_2.12-3.9.5.jar", "source": {"sha1": "e4ca8dc10083094265e8481a5557126c771f86b3", "sha256": "db07c47dd691dc4208338364f395fb39448f2d5d29a8b68d099488e9adb1af05", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/com/typesafe/scala-logging/scala-logging_2.12/3.9.5/scala-logging_2.12-3.9.5-sources.jar"} , "name": "com_typesafe_scala_logging_scala_logging_2_12", "actual": "@com_typesafe_scala_logging_scala_logging_2_12//jar:file", "bind": "jar/com/typesafe/scala_logging/scala_logging_2_12"},
    {"artifact": "org.scala-lang:scala-library:2.12.15", "lang": "scala/unmangled", "sha1": "0f2e89c89340282c9625ac57efb451056f31af57", "sha256": "e518bb640e2175de5cb1f8e326679b8d975376221f1b547757de429bbf4563f0", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/org/scala-lang/scala-library/2.12.15/scala-library-2.12.15.jar", "source": {"sha1": "5e789d895ee2b8b02577db7b6bbb5409798b7daf", "sha256": "e6be8e8ad322cfd312b06fe96e38f58db30a512efc009b91d9045c2d4f331ce2", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/org/scala-lang/scala-library/2.12.15/scala-library-2.12.15-sources.jar"} , "name": "org_scala_lang_scala_library", "actual": "@org_scala_lang_scala_library//jar:file", "bind": "jar/org/scala_lang/scala_library"},
    {"artifact": "org.scala-lang:scala-reflect:2.12.15", "lang": "scala/unmangled", "sha1": "3eca572cf97238683a8a545dabb22b52781547c8", "sha256": "d5a21ab16b35dbe1fa9f50267d3c198d4797084a61557874ca53c85f15747e48", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/org/scala-lang/scala-reflect/2.12.15/scala-reflect-2.12.15.jar", "source": {"sha1": "2dba219f833d494a920c8d884d68788e2c508f18", "sha256": "c37245fc5111bc7180e7b8d1b0c9524eb0f99c50d5fee83b086da22ee4abf486", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/org/scala-lang/scala-reflect/2.12.15/scala-reflect-2.12.15-sources.jar"} , "name": "org_scala_lang_scala_reflect", "actual": "@org_scala_lang_scala_reflect//jar:file", "bind": "jar/org/scala_lang/scala_reflect"},
# duplicates in org.slf4j:slf4j-api promoted to 2.0.7
# - ch.qos.logback:logback-classic:1.4.14 wanted version 2.0.7
# - com.typesafe.scala-logging:scala-logging_2.12:3.9.5 wanted version 1.7.36
    {"artifact": "org.slf4j:slf4j-api:2.0.7", "lang": "java", "sha1": "41eb7184ea9d556f23e18b5cb99cad1f8581fc00", "sha256": "5d6298b93a1905c32cda6478808ac14c2d4a47e91535e53c41f7feeb85d946f4", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/org/slf4j/slf4j-api/2.0.7/slf4j-api-2.0.7.jar", "source": {"sha1": "f887f95694cd20d51a062446b6e3d09dd02d98ff", "sha256": "2d6c1e7bc70fdbce8e5c6ffaaaa6673ec1a05e1cf5b9d7ae3285bf19cc81a8f1", "repository": "https://oss.sonatype.org/content/repositories/public/", "url": "https://oss.sonatype.org/content/repositories/public/org/slf4j/slf4j-api/2.0.7/slf4j-api-2.0.7-sources.jar"} , "name": "org_slf4j_slf4j_api", "actual": "@org_slf4j_slf4j_api//jar", "bind": "jar/org/slf4j/slf4j_api"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
