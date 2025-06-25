add_executable(uinttest
	main.cpp uinttest.cpp uinttest.h
)
target_link_libraries(uinttest PUBLIC ttmath)
target_folder(uinttest "Tests")
add_test(NAME uinttest COMMAND uinttest WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR})
