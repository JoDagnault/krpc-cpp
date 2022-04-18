Invoke-WebRequest "https://telkomuniversity.dl.sourceforge.net/project/asio/asio/1.22.1%20%28Stable%29/asio-1.22.1.zip" -OutFile "asio-1.22.1.zip"
7z x asio-1.22.1.zip
xcopy /E '.\asio-1.22.1\' '.\dependencies\asio-1.22.1\'

7z x krpc.zip
7z x krpc-0.4.9.zip client/krpc-cpp-0.4.9.zip
7z x client\krpc-cpp-0.4.9.zip

Set-Variable -Name "arg1" -Value ("-DCMAKE_BUILD_TYPE=Release")
Set-Variable -Name "arg2" -Value ("-DCMAKE_INSTALL_PREFIX=krpc-install")
Set-Variable -Name "arg3" -Value ("-DASIO_INCLUDE_DIR=" + $((Get-Item .).FullName) + "/dependencies/asio-1.22.1/include")
Set-Variable -Name "arg4" -Value ("-DProtobuf_INCLUDE_DIR=" + $((Get-Item .).FullName) + "/dependencies/protobuf/include")
Set-Variable -Name "arg5" -Value ("-DProtobuf_LIBRARY_RELEASE=" + $((Get-Item .).FullName) + "/dependencies/protobuf/lib/libprotobuf.lib")
Set-Variable -Name "arg6" -Value ("-DProtobuf_LITE_LIBRARY_RELEASE=" + $((Get-Item .).FullName) + "/dependencies/protobuf/lib/libprotobuf-lite.lib")
Set-Variable -Name "arg7" -Value ("-DProtobuf_PROTOC_EXECUTABLE=" + $((Get-Item .).FullName) + "/dependencies/protobuf/bin/protoc.exe")
Set-Variable -Name "arg8" -Value ("-DProtobuf_PROTOC_LIBRARY_RELEASE=" + $((Get-Item .).FullName) + "/dependencies/protobuf/lib/libprotoc.lib")

cd krpc-cpp-0.4.9
mkdir build
cd build
		  
cmake -G "Visual Studio 16 2019" -A x64 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 ..
cmake --build . --config Release
cmake --build . --target INSTALL --config Release

Set-Variable -Name "arg1" -Value ("-DCMAKE_BUILD_TYPE=RelWithDebInfo")
Set-Variable -Name "arg2" -Value ("-DCMAKE_INSTALL_PREFIX=krpc-install-debug")
cmake -G "Visual Studio 16 2019" -A x64 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 ..
cmake --build . --config RelWithDebInfo
cmake --build . --target INSTALL --config RelWithDebInfo

cd ../..

xcopy /E '.\krpc-cpp-0.4.9\build\krpc-install\' '.\dependencies\krpc-cpp\'
xcopy /E '.\krpc-cpp-0.4.9\build\protobuf\src\' '.\src\'

del 'asio-1.22.1.zip'
del '.\asio-1.22.1\' -recurse
del '.\krpc-0.4.9.zip'
del '.\client\' -recurse
del '.\krpc-cpp-0.4.9\' -recurse