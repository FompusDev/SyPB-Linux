#!/bin/bash
set -e

echo "=== Building SyPB inside Debian 10 Buster Docker Container (for max GLIBC compatibility) ==="

docker run --rm -v "$(pwd):/SyPB" i386/debian:10 bash -c '
set -e
echo "deb http://archive.debian.org/debian buster main" > /etc/apt/sources.list
echo "deb http://archive.debian.org/debian-security buster/updates main" >> /etc/apt/sources.list
apt-get -o Acquire::Check-Valid-Until=false update
apt-get install -y --allow-unauthenticated build-essential

cd "/SyPB/Project SyPB/SyPB_BOT"
bash build.sh
'

echo "Docker build finished! Binary is at: Project SyPB/SyPB_BOT/sypb_i386.so"

