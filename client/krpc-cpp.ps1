Invoke-WebRequest "https://phoenixnap.dl.sourceforge.net/project/asio/asio/1.30.2%20%28Stable%29/asio-1.30.2.zip?viasf=1" -OutFile "asio-1.30.2.zip"
7z x asio-1.30.2.zip
xcopy /E /Y '.\asio-1.30.2' '.\third_party\asio\'

Invoke-WebRequest "https://github.com/krpc/krpc/releases/download/v0.5.4/krpc-cpp-0.5.4.zip" -OutFile "krpc-cpp.zip"
7z x krpc-cpp.zip

Set-Variable -Name "arg1" -Value ("-DCMAKE_BUILD_TYPE=Release")
Set-Variable -Name "arg2" -Value ("-DCMAKE_INSTALL_PREFIX=krpc-install")
Set-Variable -Name "arg3" -Value ("-DCMAKE_POLICY_VERSION_MINIMUM=3.10")
Set-Variable -Name "arg4" -Value ("-DASIO_INCLUDE_DIR=" + $((Get-Item .).FullName) + "/third_party/asio/include")
Set-Variable -Name "arg5" -Value ("-DProtobuf_INCLUDE_DIR=" + $((Get-Item .).FullName) + "/third_party/protobuf/include")
Set-Variable -Name "arg6" -Value ("-DProtobuf_LIBRARY_RELEASE=" + $((Get-Item .).FullName) + "/third_party/protobuf/lib/libprotobuf.lib")
Set-Variable -Name "arg7" -Value ("-DProtobuf_LITE_LIBRARY_RELEASE=" + $((Get-Item .).FullName) + "/third_party/protobuf/lib/libprotobuf-lite.lib")
Set-Variable -Name "arg8" -Value ("-DProtobuf_PROTOC_EXECUTABLE=" + $((Get-Item .).FullName) + "/third_party/protobuf/bin/protoc.exe")
Set-Variable -Name "arg9" -Value ("-DProtobuf_PROTOC_LIBRARY_RELEASE=" + $((Get-Item .).FullName) + "/third_party/protobuf/lib/libprotoc.lib")

cd krpc-cpp-0.5.4
mkdir build
cd build
		  
cmake -G "Visual Studio 17 2022" -A x64 -T v142 $arg1 $arg2 $arg3 $arg4 $arg5 $arg6 $arg7 $arg8 $arg9 ..
cmake --build . --config Release
cmake --build . --target INSTALL --config Release

cd ../..

xcopy /E /Y'.\krpc-cpp-0.5.4\build\krpc-install\' '.\third_party\krpc-cpp\'
xcopy /E /Y '.\krpc-cpp-0.5.4\build\protobuf\src\' '.\src\'

del 'asio-1.30.2.zip'
del '.\asio-1.30.2\' -recurse
del '.\krpc-cpp.zip'
del '.\krpc-cpp-0.5.4\' -recurse

