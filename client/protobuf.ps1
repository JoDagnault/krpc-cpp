Invoke-WebRequest "https://github.com/protocolbuffers/protobuf/releases/download/v3.19.4/protobuf-cpp-3.19.4.zip" -OutFile "protobuf.zip"

7z x protobuf.zip

cd protobuf-3.19.4
cd cmake
mkdir build
cd build
mkdir release 
cd release
cmake -G "Visual Studio 16 2019" -A x64 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=protobuf-install ../..
cmake --build . --config Release
cmake --build . --target INSTALL --config Release

cd ../../../..

xcopy /E '.\protobuf-3.19.4\cmake\build\release\protobuf-install\' '.\dependencies\protobuf\'

del '.\protobuf.zip'
del '.\protobuf-3.19.4\' -recurse