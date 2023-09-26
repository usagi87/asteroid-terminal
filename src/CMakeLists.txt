add_library(asteroid-terminal main.cpp terminal.h terminal.cpp resources.qrc)

target_link_libraries(asteroid-terminal PUBLIC
	AsteroidApp)

install(TARGETS asteroid-terminal
	DESTINATION ${CMAKE_INSTALL_LIBDIR})
