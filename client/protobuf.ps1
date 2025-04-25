Invoke-WebRequest "https://github.com/protocolbuffers/protobuf/releases/download/v3.3.0/protobuf-cpp-3.3.0.zip" -OutFile "protobuf.zip"

7z x protobuf.zip

cd protobuf-3.3.0
cd cmake
mkdir build
cd build
mkdir release 
cd release
cmake -G "Visual Studio 17 2022" -A x64 -T v142 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=protobuf-install "-DCMAKE_POLICY_VERSION_MINIMUM=3.10" ../..
cmake --build . --config Release
cmake --build . --target INSTALL --config Release

cd ../../../..

xcopy /E '.\protobuf-3.3.0\cmake\build\release\protobuf-install\' '.\third_party\protobuf\'

del '.\protobuf.zip'
del '.\protobuf-3.3.0\' -recurse