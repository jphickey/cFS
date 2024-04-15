project(LIST C)

# Create the app module
add_cfe_app(list src/list.c)
target_include_directories(list PUBLIC ${LIST_SOURCE_DIR}/inc)
