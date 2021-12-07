#!/bin/sh
#终端输入 echo $PATH 查看PATH路径
# chmod 755 build.sh 获取权限
#PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
#export PATH
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

echo "Clean old build"
find . -d -name "build" | xargs rm -rf
#flutter clean

echo "开始获取 packages 插件资源"
flutter packages get

echo "开始构建 release for ios"
flutter build ios
echo "构建 release 已完成"
echo "开始 处理framework和资源文件"

#build_path="../build_flutter_weiboad_ios"
build_path="./build_flutter_ios"
if [ -d ${build_path} ]; then
find ${build_path} -name \*.framework | xargs rm -rf
else
mkdir ${build_path}
fi

cp -r build/ios/Release-iphoneos/*/*.framework ${build_path}
cp -r build/ios/Release-iphoneos/*.framework ${build_path}
#cp -r .ios/Flutter/App.framework ${build_path}
#cp -r .ios/Flutter/engine/Flutter.framework ${build_path}

#cp -r .ios/Flutter/FlutterPluginRegistrant/Classes/GeneratedPluginRegistrant.* ${build_path}

echo done
