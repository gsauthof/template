# PlatformIO uses SCons which compares the md5sum to decide if a file needs
# to be rebuilt, by default.
#
# This changes the default to the saner mtime timestamp comparison method
# when it is invoked from your platformio.ini via:
#
#     extra_scripts = pre:mtime.py
#
#
# cf. https://github.com/platformio/platformio-core/issues/4316#issuecomment-1153814893
# cf. https://docs.platformio.org/en/latest/scripting/actions.html

Import("env")
env.Decider("make")
