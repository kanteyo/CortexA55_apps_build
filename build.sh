#!/bin/bash
set -e

IP_ADDRESS=""
SSH="false"

while getopts ":s:" opt; do
  case $opt in
    s)
      IP_ADDRESS=$OPTARG
      SSH="true"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo ""Option -$OPTARG requires a value."" >&2
      exit 1
      ;;
  esac
done

BUILD_DIR=$(pwd)


if [ -d "./build" ]; then
	rm -rf build
fi

mkdir build
cd build

cmake ..
make

for FILE in "$BUILD_DIR"/build/*; do
  if [ -f "$FILE" ] && [ -x "$FILE" ]; then
    # 一つ上のディレクトリにコピー
    cp "$FILE" "$BUILD_DIR"
  fi
done

echo "build finish"

if [ "$SSH" = "true" ]; then
	scp "$FILE" root@"$IP_ADDRESS":/var
	echo "SSH:File transfer is successful."
fi

