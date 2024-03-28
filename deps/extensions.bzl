load("@rules_jvm_external//:specs.bzl", "parse")

def wrap(things, args = []):
    return things

def add_scala_version(object, version):
    if type(object) == "string":
        parsed = parse.parse_maven_coordinate(object)
        parsed["artifact"] = parsed["artifact"] + "_" + version
        return parsed
    else:
        object["artifact"] = object["artifact"] + "_" + version
        return object

def scala(object_or_name):
    return ("scala", object_or_name)

def java(object_or_name):
    return ("java", object_or_name)

def _handle_entry(tagged_artifact, scala_version):
    if type(tagged_artifact) != "tuple":
        fail("Expected tuple, got string - did you wrap with scala() or java()?")
    (lang, artifact) = tagged_artifact
    if lang == "scala":
        return add_scala_version(artifact, scala_version)
    else:
        return artifact

def derive(items, scala_versions):
    artifacts = []
    for item in items:
        #        if type(item) == "string":
        #            item = ("java", item)
        derived = [_handle_entry(item, ver) for ver in scala_versions]
        artifacts.extend(derived)
    return artifacts
