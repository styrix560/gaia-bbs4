#!/bin/bash

echo "Building application"
flutter build web

echo "Removing previous version"
ssh zeus-deb "rm -rf /home/user/gaia-bbs4"

echo "Copying files"
scp -r build/web zeus-deb:/home/user/gaia-bbs4
