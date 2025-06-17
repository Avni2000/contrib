#When the project starts, set up an isolated environment where you hardcode all these variables.
# I want to see if I can exchange some parameters for others,
MACRO(OPENMS_CONTRIB_BUILD_ARROW)
    OPENMS_LOGHEADER_LIBRARY("ARROW") 
    if(MSVC)
      set(ZIP_ARGS "x -y -osrc")
    else()
      set(ZIP_ARGS "xzf")
    endif()
    OPENMS_SMARTEXTRACT(ZIP_ARGS ARCHIVE_ARROW "ARROW" "CREDITS")


    set( ARROW_BUILD_TYPE "static")
    if (BUILD_SHARED_LIBRARIES)
	  set( ARROW_BUILD_TYPE "shared")
    endif()
    
    
 
  cmake_minimum_required(VERSION 3.16)
  #I wonder if all cmake generators work with arrow? IDE vs Ninja for example? #TODO This is worth further testing.
  #Also check in docs what users are required to install beforehand.
#   if(Win32)
#   execute_process(COMMAND ${CMAKE_COMMAND}

#   -D CMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
#   -D CMAKE_C_COMPILER=${CMAKE_C_COMPILER}
#   -D BUILD_SHARED_LIBS=${BUILD_SHARED_LIBRARIES}
#   -D CMAKE_DISABLE_FIND_PACKAGE_ICU=TRUE #https://cmake.org/cmake/help/latest/module/FindICU.html. 
# # What do we use instead?
#   -G "${CMAKE_GENERATOR}"
#   ${ARCHITECTURE_OPTION_CMAKE}
#   -D CMAKE_INSTALL_PREFIX=${PROJECT_BINARY_DIR}
#   -D CMAKE_POSITION_INDEPENDENT_CODE=ON
#   .
#   WORKING_DIRECTORY ${ARROW_DIR}
#   )
	
  execute_process(COMMAND ${CMAKE_COMMAND}
  --build .
  --config Release
  --target install
WORKING_DIRECTORY ${ARROW_DIR}
  )

ENDMACRO(OPENMS_CONTRIB_BUILD_ARROW)