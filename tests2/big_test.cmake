function(dump_var name)
    message(STATUS "Variable ${name}: ${${name}}")
endfunction()
foreach(var CMAKE_COMMAND TEST INPUT OUTPUT EXPECTED)
    dump_var(${var})
endforeach()

execute_process(COMMAND "${TEST}" < "${INPUT}" > "${OUTPUT}"
    RESULT_VARIABLE status)
if(${status})
    message(FATAL_ERROR "Test execution failed with status ${status}")
endif()
execute_process(COMMAND "${CMAKE_COMMAND}" -E compare_files "${EXPECTED}" "${OUTPUT}"
    RESULT_VARIABLE status)
if(${status})
    message(FATAL_ERROR "Output does not match expected output: ${EXPECTED} vs ${OUTPUT}")
endif()
