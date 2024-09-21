add_subdirectory(sim)

add_executable(start start.c app.c)
target_link_libraries(start sim -lSDL2)