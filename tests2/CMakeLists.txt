
function(add_ttmath_test exponent mantissa)
	add_executable(big_${exponent}_${mantissa} main.cpp)
	target_compile_definitions(big_${exponent}_${mantissa} PRIVATE TTMATH_TEST_BIG_EXPONENT=${exponent} TTMATH_TEST_BIG_MANTISSA=${mantissa})
	target_link_libraries(big_${exponent}_${mantissa} PUBLIC ttmath)
	target_folder(big_${exponent}_${mantissa} "Tests")
	add_test(NAME big_${exponent}_${mantissa}
		COMMAND "${CMAKE_COMMAND}"
			"-DCMAKE_COMMAND=${CMAKE_COMMAND}"
			"-DTEST=$<TARGET_FILE:big_${exponent}_${mantissa}>"
			"-DINPUT=${CMAKE_CURRENT_SOURCE_DIR}/tests.txt"
			"-DOUTPUT=$<PATH:NATIVE_PATH,${CMAKE_CURRENT_BINARY_DIR}/big_${exponent}_${mantissa}.txt>"
			"-DEXPECTED=${CMAKE_CURRENT_SOURCE_DIR}/big_${exponent}_${mantissa}.expected"
			-P "${CMAKE_CURRENT_SOURCE_DIR}/big_test.cmake"
		WORKING_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}")
	# disabled until test modified to accept input on stdin instead of argv
	set_property(TEST big_${exponent}_${mantissa} PROPERTY DISABLED ON)
endfunction()

foreach(mantissa 64 128 192 256 512 1024 2048 4096)
	add_ttmath_test(64 ${mantissa})
endforeach()
add_ttmath_test(128 512)
add_ttmath_test(128 4096)
add_ttmath_test(256 1024)
add_ttmath_test(512 2048)
