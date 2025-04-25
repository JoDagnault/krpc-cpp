# krpc-cpp (Fork)

This repository is a fork of a collection of build scripts originally from [krpc-cpp](https://github.com/nullprofile/krpc-cpp), updated to build the kRPC C++ client for Windows with compatibility for kRPC 0.5.4.

## What’s Changed in This Fork

- **Protobuf upgraded to v3.3.0**  
  kRPC 0.5.4 requires v3.2.0 but it triggered compiler errors.  

- **Asio upgraded to v1.30.2**  

- **kRPC C++ client upgraded to v0.5.4**  

- **Switched to Visual Studio 2022 toolchain**  
  Uses the “Visual Studio 17 2022” generator (`-G "Visual Studio 17 2022" -A x64 -T v142`).
  
- **Added support for newer CMake versions**  
  Adds `"-DCMAKE_POLICY_VERSION_MINIMUM=3.10"`
  
### Usage

1. Open PowerShell in project root

2. Run `.\protobuf.ps1`

3. Run `.\krpc-cpp.ps1`

4. Run `.\krpc-demo.ps1`

5. Your demo executable will be in `build\Release\krpc-demo.exe`
