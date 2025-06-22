#When the project starts, set up an isolated environment where you hardcode all these variables.
# I want to see if I can exchange some parameters for others,
MACRO(OPENMS_CONTRIB_BUILD_ARROW)
    message(STATUS "does this even work??")
    OPENMS_LOGHEADER_LIBRARY("ARROW") 
    if(MSVC)
      set(ZIP_ARGS "x -y -osrc")
    else()
      set(ZIP_ARGS "xzf")
    endif()
    OPENMS_SMARTEXTRACT(ZIP_ARGS ARCHIVE_ARROW "ARROW" "CREDITS")
    if(UNIX AND NOT APPLE)
      set(LINUX TRUE) #make a linux flag for readability.
  endif()

    set( ARROW_BUILD_TYPE "static")
    if (BUILD_SHARED_LIBRARIES)
	  set( ARROW_BUILD_TYPE "shared")
    endif()
    ##################################################################################
if(APPLE) #both linux and apple fyi...
  message(STATUS "Configuring Apache Arrow on macOS...")

  set(_ARROW_CMAKE_ARGS
    -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
    -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
    -DBUILD_SHARED_LIBS=${BUILD_SHARED_LIBRARIES}
    -DCMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}
    -DARROW_BUILD_TESTS=ON
    -DARROW_BUILD_SHARED=${BUILD_SHARED_LIBRARIES}
  )
  message(STATUS "Setting working directory/output vars for args")
  execute_process(COMMAND ${CMAKE_COMMAND}
    ${_ARROW_CMAKE_ARGS}
    .
    WORKING_DIRECTORY ${ARROW_DIR}
    OUTPUT_VARIABLE ARROW_CMAKE_OUT
    ERROR_VARIABLE ARROW_CMAKE_ERR
    RESULT_VARIABLE ARROW_CMAKE_SUCCESS
  )

  file(APPEND ${LOGFILE} ${ARROW_CMAKE_OUT} ${ARROW_CMAKE_ERR})

  message(STATUS "Building and installing Apache Arrow on macOS...")

  message(STATUS "")
  execute_process(COMMAND ${CMAKE_COMMAND}
    --build .
    --config Release
    --target install
    WORKING_DIRECTORY ${ARROW_DIR}
    OUTPUT_VARIABLE ARROW_BUILD_OUT
    ERROR_VARIABLE ARROW_BUILD_ERR
    RESULT_VARIABLE ARROW_BUILD_SUCCESS
  )

  file(APPEND ${LOGFILE} ${ARROW_BUILD_OUT} ${ARROW_BUILD_ERR})
endif()
  
#############################################################################

#BACK TO WINDOWS 
  message(STATUS "Setting working directory/output vars for args")
  execute_process(COMMAND ${CMAKE_COMMAND}
    ${BUILD_SHARED_LIBS}
        .
    WORKING_DIRECTORY ${ARROW_DIR}
    OUTPUT_VARIABLE ARROW_CMAKE_OUT
    ERROR_VARIABLE ARROW_CMAKE_ERR
    RESULT_VARIABLE ARROW_CMAKE_SUCCESS)
  execute_process(COMMAND ${CMAKE_COMMAND}
  --build .
  --config Release
  --target install
WORKING_DIRECTORY ${ARROW_DIR}
  )

ENDMACRO(OPENMS_CONTRIB_BUILD_ARROW)