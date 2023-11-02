project(LIST C)

# Create the app module
include_directories(${LIST_SOURCE_DIR}/inc)
add_cfe_app(list src/list.c)

