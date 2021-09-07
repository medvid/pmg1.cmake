# CMake based build system for PMG1 designs

[![Build Status](https://dev.azure.com/vmedvid/pmg1.cmake/_apis/build/status/medvid.pmg1.cmake?branchName=master)](https://dev.azure.com/vmedvid/pmg1.cmake/_build/latest?definitionId=16&branchName=master)

## Prerequisites

* ModusToolbox 2.3.1
* CMake >= 3.16
* Ninja build system

### Install prerequisites - Windows

1. Download and install ModusToolbox 2.3:

    [https://www.cypress.com/ModusToolboxForWindows][ModusToolboxForWindows]

2. Download and install ModusToolbox 2.3.1 (patch on top of 2.3):

    [https://www.cypress.com/file/521751/download][ModusToolboxForWindows-2.3.1]

3. Download and install the latest Git for Windows:

    https://gitforwindows.org/

4. Download and install the latest CMake win64-x64 Installer:

    https://cmake.org/download/

5. Download Ninja executable, add to user PATH:

    https://github.com/ninja-build/ninja/releases

    CLI example: to install Ninja 1.10.2 to %LOCALAPPDATA%\Programs\Ninja, execute the below commands in Git Bash terminal:

        curl -fsSL https://github.com/ninja-build/ninja/releases/download/v1.10.2/ninja-win.zip -o $TMPDIR/ninja-win.zip
        mkdir -p $LOCALAPPDATA/Programs/Ninja
        unzip $TMPDIR/ninja-win.zip -d $LOCALAPPDATA/Programs/Ninja

    Then add %LOCALAPPDATA%\Programs\Ninja to user PATH in Windows advanced system settings.

6. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.07

7. _(Optional)_ Download and install Arm Compiler 6:

    https://developer.arm.com/tools-and-software/embedded/arm-compiler/downloads/version-6

    Example installation path:

        C:/Program Files/ARMCompiler6.16

    Arm Compiler 6 is also bundled with Keil uVision 5 IDE:

    https://www.keil.com/arm/

    Installation path assumed in this document:

        C:/Keil_v5/ARM/ARMCLANG

    Note: valid license is required to use the Arm Compiler.

8. _(Optional)_ Download and install IAR Embedded Workbench for ARM:

    https://www.iar.com/iar-embedded-workbench/#!?architecture=Arm

    Installation path assumed in this document:

        C:\Program Files\IAR Systems\Embedded Workbench 9.0

    Note: valid license is required to use the IAR Compiler.

10. _(Optional)_ Download and install LLVM/Clang Compiler:

    https://github.com/llvm/llvm-project/releases/download/llvmorg-12.0.1/LLVM-12.0.1-win64.exe

    Installation path assumed in this document:

        C:/Program Files/LLVM

### Install prerequisites - macOS

1. Download and install ModusToolbox 2.3:

    [https://www.cypress.com/ModusToolboxForMac][ModusToolboxForMac]

2. Download and install ModusToolbox 2.3.1 (patch on top of 2.3):

    [https://www.cypress.com/file/521746/download][ModusToolboxForMac-2.3.1]

3. Install Xcode - this provides git client

4. Download and install Homebrew Package Manager:

    https://brew.sh

5. Install CMake and Ninja using Homebrew:

    brew install cmake ninja

6. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        /Applications/ARM

### Install prerequisites - Linux

1. Download and install ModusToolbox 2.3:

    [https://www.cypress.com/ModusToolboxForLinux][ModusToolboxForLinux]

2. Download and install ModusToolbox 2.3.1 (patch on top of 2.3):

    [https://www.cypress.com/file/521741/download][ModusToolboxForLinux-2.3.1]

3. Download and install Git, CMake>=3.16 and Ninja using the system package manager.

    Example for Ubuntu 20.04:

        sudo apt install git cmake ninja-build

    Note: Ubuntu 18.04 provides an old version CMake, not compatible with CMake recipes in this repo.
    To download latest CMake package, follow the instructions at https://apt.kitware.com.

4. _(Optional)_ Download and install the latest GNU Arm Embedded toolchain:

    https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads

    Installation path assumed in this guide:

        /opt/gcc-arm-none-eabi-10.3-2021.07

    CLI installation example:

        curl -fsSL https://developer.arm.com/-/media/Files/downloads/gnu-rm/10.3-2021.07/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2 -o /tmp/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2
        sudo tar -C /opt -xjf /tmp/gcc-arm-none-eabi-10.3-2021.07-x86_64-linux.tar.bz2

## Quick Start Guide - CLI

1. Open interactive terminal, for example Git Bash on Windows.

2. Check the prerequisite tools were properly installed and added to PATH:

        cmake --version
        ninja --version

3. Clone this repo:

        git clone https://github.com/medvid/pmg1.cmake
        cd pmg1.cmake

4. Generate Ninja build rules using CMake. Example that generates build recipes for bare-metal applications targeting PMG1-CY7110 board and GCC toolchain:

        cmake -G Ninja -S . -B build/PMG1-CY7110/NOOS/GCC/Debug \
            -DTARGET=PMG1-CY7110 -DOS=NOOS -DTOOLCHAIN=GCC \
            -DCMAKE_BUILD_TYPE=Debug

5. Build all applications enabled for the selected TARGET and OS combination:

        cmake --build build/PMG1-CY7110/NOOS/GCC/Debug

6. Connect PMG1-CY7110 to the host. If needed, update the KitProg firmware using fw-loader:

    https://github.com/Infineon/Firmware-loader

    Make sure the kit is in CMSIS-DAP mode.

7. Program hello-world application to the PMG1 MCU:

        cmake --build build/PMG1-CY7110/NOOS/GCC/Debug --target hello-world_PROGRAM

8. Check the application behaves in accorandce with [app/hello-world/README.md][hello-world]

## Usage - Visual Studio Code

1. Install Visual Studio Code:

    https://aka.ms/vscode

2. Start Visual Studio Code. Select File -> Open Folder... -> browse to pmg1.cmake directory (on macOS, use File -> Open menu).

3. Install the required extensions:

    * [ms-vscode.cpptools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cpptools)
    * [ms-vscode.cmake-tools](https://marketplace.visualstudio.com/items?itemName=ms-vscode.cmake-tools)
    * [marus25.cortex-debug](https://marketplace.visualstudio.com/items?itemName=marus25.cortex-debug)

4. Copy .vscode/settings-template-$os.json as .vscode/settings.json, adjust paths as necessary.

    * Example of Windows-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "${env:HOME}/ModusToolbox/tools_2.3",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "${env:HOME}/ModusToolbox/tools_2.3",
                "GCC_TOOLCHAIN_PATH": "C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.07",
                "ARM_TOOLCHAIN_PATH": "C:/Keil_v5/ARM/ARMCLANG",
                "IAR_TOOLCHAIN_PATH": "C:/Program Files/IAR Systems/Embedded Workbench 9.0/arm"
            }
        }
        ```

    * Example of macOS-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "/Applications/ModusToolbox/tools_2.3",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "/Applications/ModusToolbox/tools_2.3",
                "GCC_TOOLCHAIN_PATH": "/Applications/ARM"
            }
        }
        ```

    * Example of Linux-specific tweaks to settings.json:

        ```json
        {
            "modustoolbox.toolsPath": "${env:HOME}/ModusToolbox/tools_2.3",
            "cortex-debug.openocdPath": "${config:modustoolbox.toolsPath}/openocd/bin/openocd",
            "cortex-debug.armToolchainPath": "${config:modustoolbox.toolsPath}/gcc/bin",
            "cmake.configureSettings": {
                "CY_TOOLS_PATHS": "${env:HOME}/ModusToolbox/tools_2.3",
                "GCC_TOOLCHAIN_PATH": "/opt/gcc-arm-none-eabi-10.3-2021.07"
            }
        }
        ```

5. In VSCode menu, select View -> Command Palette -> type: "CMake: Select a Kit" -> select one of the custom kits defined in .vscode/cmake-kits.json, for example: PMG1-CY7110/NOOS/GCC. Never select standard kits scanned from the host OS.

6. In the Command Palette, type: "CMake: Configure", wait while the CMake project is configured.

7. Type "CMake: Build Target", and select the build target, for example: hello-world_PROGRAM. Wait while the hello-world application is built and programmed.

8. Switch to the Debug tab on the left Panel, select the debug configuration Launch (KitProg3).

9. Select the target ELF file, that corresponds to the CMake selected build target. For example, select "hello-world.elf" in case the current CMake target is "hello-world_PROGRAM".

10. The Cortex-Debug extension should start the debugging session using OpenOCD and KitProg3 CMSIS-DAP built-in debugger.

## Continuous integration

Script `ci/build-all.sh` simplifies the automated build/compile testing of this solution. By default, it builds all supported applications for all BSPs, OSes, toolchains and build configurations.

Arguments:

* -b/--bsp - Select target BSP (PMG1-CY7110/PMG1-CY7111/PMG1-CY7112/...)
* -o/--os - Select target OS (NOOS/...)
* -t/--toolchain - Select toolchain (GCC/ARM/IAR/LLVM)
* -g/--config - Select CMake build configuration (Debug/Release)

Each argument can be supplied multiple times.

### Examples

Build everything:

    ./ci/build-all.sh

Build everything using IAR and ARM toolchains:

    ./ci/build-all.sh -t IAR -t ARM

Build all PMG1-CY7110 and PMG1-CY7111 BSP compatible applications in Debug mode:

    ./ci/build-all.sh -b PMG1-CY7110 -b PMG1-CY7111 -g Debug

Build all applications in Release mode:

    ./ci/build-all.sh -g Release

#### Azure Pipelines

Azure Pipeline is executed for each commit in master and each GitHub Pull Request:

https://dev.azure.com/vmedvid/pmg1.cmake/_build?definitionId=16&_a=summary

The pipeline builds all applications with GCC 10.3.1 toolchain on [vmmedvid/modustoolbox-cmake](https://hub.docker.com/r/vmmedvid/modustoolbox-cmake) Docker image.

## Additional tips

* It is possible to call the Ninja program directly, for example:

        ninja -C build/PMG1-CY7110/NOOS/GCC/Debug hello-world_PROGRAM

    Often it is useful to call the ninja with additional arguments.
    For example, the below command enables verbosity and disables parallel compilation:

        cd build/PMG1-CY7110/NOOS/GCC/Debug
        ninja -v -j1

* When switching between toolchain versions (cmake -DGCC_TOOLCHAIN_PATH), the old toolchain version
  is sometimes cached in the CMake build directory. The most reliable way to address this is to delete
  the build directory before switching the toolchain version:

        rm -rf build/PMG1-CY7110/NOOS/GCC/Debug
        cmake -G Ninja -S . -B build/PMG1-CY7110/NOOS/GCC/Debug \
            -DTARGET=PMG1-CY7110 -DOS=NOOS -DTOOLCHAIN=GCC \
            -DGCC_TOOLCHAIN_PATH="C:/Program Files (x86)/GNU Arm Embedded Toolchain/10 2021.07" \
            -DCMAKE_BUILD_TYPE=Debug

[ModusToolboxForWindows]: https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3/ModusToolbox_2.3.0.4276-windows-install.exe
[ModusToolboxForMac]: https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3/ModusToolbox_2.3.0.4276-macos-install.pkg
[ModusToolboxForLinux]: https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3/ModusToolbox_2.3.0.4276-linux-install.tar.gz
[ModusToolboxForWindows-2.3.1]: https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3.1/ModusToolbox_2.3.1.4663-windows-install.exe
[ModusToolboxForMac-2.3.1]: https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3.1/ModusToolbox_2.3.1.4663-macos-install.pkg
[ModusToolboxForLinux-2.3.1]: https://download.cypress.com/downloadmanager/software/ModusToolbox/ModusToolbox_2.3.1/ModusToolbox_2.3.1.4663-linux-install.tar.gz
[hello-world]: https://github.com/Infineon/mtb-example-pmg1-hello-world/blob/master/README.md#operation
