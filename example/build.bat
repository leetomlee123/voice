call flutter build apk --target-platform android-arm64 --split-per-abi --build-name=1.0 --build-number=3 --release
call cd build/app/outputs/apk/release
call ipconfig
call python -m http.server 80

