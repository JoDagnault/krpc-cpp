cmake_minimum_required(VERSION 3.10)

project(krpc-demo)

if(MSVC)
  # protobuf statically links against MT, so need to compile with /MT not /MD
  foreach(var
        CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
        CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
      if(${var} MATCHES "/MD")
        string(REGEX REPLACE "/MD" "/MT" ${var} "${${var}}")
      endif()
    endforeach()
endif()

add_executable(
	${PROJECT_NAME}
	src/krpc.pb.cpp
	src/main.cpp
)

# Include directories
target_include_directories( ${PROJECT_NAME}
    PRIVATE
        "include/"
		"dependencies/asio-1.22.1/include/"
		"dependencies/protobuf/include/"
		"dependencies/krpc-cpp/include/"
)

# Add protobuf
add_library(protobuf STATIC IMPORTED)
set(PROTOBUF_FILE_PATH "${PROJECT_SOURCE_DIR}/dependencies/protobuf/lib/libprotobuf.lib")
set_target_properties(protobuf PROPERTIES IMPORTED_LOCATION ${PROTOBUF_FILE_PATH})

add_library(protobuf-lite STATIC IMPORTED)
set(PROTOBUF_LITE_FILE_PATH "${PROJECT_SOURCE_DIR}/dependencies/protobuf/lib/libprotobuf-lite.lib")
set_target_properties(protobuf-lite PROPERTIES IMPORTED_LOCATION ${PROTOBUF_LITE_FILE_PATH})

add_library(protoc STATIC IMPORTED)
set(PROTOC_FILE_PATH "${PROJECT_SOURCE_DIR}/dependencies/protobuf/lib/libprotoc.lib")
set_target_properties(protoc PROPERTIES IMPORTED_LOCATION ${PROTOC_FILE_PATH})

# Add krpc
add_library(krpc STATIC IMPORTED)
set(KRPC_FILE_PATH "${PROJECT_SOURCE_DIR}/dependencies/krpc-cpp/lib/krpc.lib")
set_target_properties(krpc PROPERTIES IMPORTED_LOCATION ${KRPC_FILE_PATH})


target_link_libraries(${PROJECT_NAME} 
	protobuf
	protobuf-lite
	protoc
	krpc
)
