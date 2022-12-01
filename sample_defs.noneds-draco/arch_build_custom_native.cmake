#
# Example arch_build_custom.cmake
# -------------------------------
#
# On native builds only, add strict cast alignment warnings
# This requires a newer version of gcc
#
add_compile_options(
    -Wcast-align=strict         # Warn about casts that increase alignment requirements
    -Wno-conversion            # Lots of false positives
    -Wno-stringop-truncation   # Lots of false positives
    -Wno-format-truncation     # Lots of false positives
)

