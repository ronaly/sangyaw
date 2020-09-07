#!/bin/bash
VERSION=`pubver bump patch`
echo "${VERSION}"
git add .
git commit -m "new version update ${VERSION}"
git push
flutter build apk --split-per-abi

echo "New version succes: ${VERSION}"
