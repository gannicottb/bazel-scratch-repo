def scala(name, **kwargs):
    return name

def wrap(things, args = []):
    return things

def add_scala_version(object, version):
    object["artifact"] = object["artifact"] + "_" + version
    return object
