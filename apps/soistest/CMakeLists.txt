set(APP_SRC_FILES
  fsw/src/soistest.c
)

# Create the app module
add_cfe_app(soistest ${APP_SRC_FILES})
