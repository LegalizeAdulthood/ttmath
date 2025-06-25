# CMake configuration for ttmath/samples

set(SAMPLES big big2 int uint parser)
foreach(sample ${SAMPLES})
	add_executable(${sample} ${sample}.cpp)
	# Allow to run all utilities at once as a test
	add_test(${sample} ${sample})
	target_link_libraries(${sample} PUBLIC ttmath)
	target_folder(${sample} "Samples")
endforeach()
