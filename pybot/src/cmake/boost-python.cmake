function(boost_python_module NAME)
  find_package(Boost COMPONENTS python REQUIRED)

  # Support for py 2/3 compat
  # Alternatively, use find_package(PythonLibs 2.7 REQUIRED)
  # for Python 2.7 support
  find_package(PythonLibs REQUIRED)
  # find_package(Numpy)

  set(DEP_LIBS
    ${Boost_PYTHON_LIBRARY}
    ${PYTHON_LIBRARIES}
    )
  #these are required includes for every ecto module
  include_directories(
    ${PYTHON_INCLUDE_PATH}
    ${Boost_INCLUDE_DIRS}
    )
  add_library(${NAME} SHARED
    ${ARGN}
    )
  set_target_properties(${NAME}
    PROPERTIES
    OUTPUT_NAME ${NAME}
    COMPILE_FLAGS "${FASTIDIOUS_FLAGS}"
    LINK_FLAGS -dynamic
    PREFIX ""
    )
  if( WIN32 )
    set_target_properties(${NAME} PROPERTIES SUFFIX ".pyd")
  elseif( APPLE OR ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    # on mac osx, python cannot import libraries with .dylib extension
    set_target_properties(${NAME} PROPERTIES SUFFIX ".so")
  endif()
  target_link_libraries(${NAME}
    ${DEP_LIBS}
    )
endfunction()
