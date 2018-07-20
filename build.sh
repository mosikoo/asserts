#!/usr/bin/sh

# 日常
# export BUILD_HASH=daily && sh index.sh
# 生产
# sh index.sh

replaceFile() {
  file=`find build/$1/index*.$1`
  if [ ! -n "$file" ]; then
    return;
  fi
  echo "replace $file to build/$1/index.$1"
  mv $file build/$1/index.$1
}

tnpm install --production
tnpm install ice-scripts@latest

# todo def中区分环境变量
export BUILD_HASH=daily & tnpm run build

if [ $BUILD_HASH = "daily" ]; then
  replaceFile "js"
  replaceFile "css"
fi

mv build .package
