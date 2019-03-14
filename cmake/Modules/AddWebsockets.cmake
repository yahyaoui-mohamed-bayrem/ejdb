include(ExternalProject)

set(LWS_SOURCE_DIR "${CMAKE_BINARY_DIR}/src/extern_lws")
set(LWS_BINARY_DIR "${CMAKE_BINARY_DIR}/lws")
set(LWS_INCLUDE_DIR "${LWS_BINARY_DIR}/include")
set(LWS_LIBRARY_DIR "${LWS_BINARY_DIR}/lib")

ExternalProject_Add(
  extern_lws
  GIT_REPOSITORY https://github.com/warmcat/libwebsockets.git
  GIT_TAG v3.1.0
  PREFIX ${CMAKE_BINARY_DIR}
  BUILD_IN_SOURCE ON
  GIT_PROGRESS ON
  UPDATE_COMMAND ""
  UPDATE_DISCONNECTED ON
  LOG_DOWNLOAD OFF
  LOG_UPDATE OFF
  LOG_BUILD OFF
  LOG_CONFIGURE OFF
  LOG_INSTALL OFF
  BUILD_BYPRODUCTS "${LWS_LIBRARY_DIR}/libwebsockets.a"
  CMAKE_ARGS -DCMAKE_BUILD_TYPE=RelWithDebInfo
             -DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/lws
             -DLWS_WITHOUT_CLIENT=ON
             -DLWS_WITHOUT_TEST_CLIENT=ON
             -DLWS_WITHOUT_TEST_PING=ON
             -DLWS_WITHOUT_TEST_SERVER_EXTPOLL=ON
             -DLWS_WITHOUT_TEST_SERVER=ON
             -DLWS_WITHOUT_TESTAPPS=ON
             -DLWS_ROLE_H1=ON
             -DLWS_ROLE_WS=ON
             -DLWS_WITH_LIBUV=ON
             -DLWS_WITH_SSL=OFF
             -DLWS_WITH_SHARED=OFF
)

add_library(websockets_s STATIC IMPORTED GLOBAL)
set_target_properties(
  websockets_s
  PROPERTIES
  IMPORTED_LOCATION "${LWS_LIBRARY_DIR}/libwebsockets.a"
)
add_dependencies(websockets_s extern_lws)

list(APPEND PROJECT_LLIBRARIES websockets_s)
list(APPEND PROJECT_INCLUDE_DIRS "${LWS_INCLUDE_DIR}")