#!/bin/bash
set -e

if [ -z "$name" ]; then
  echo "Error: You should provide the "name" argument"
  exit 1
fi

if [ -z "$folder" ]; then
  echo "Error: You should provide the "folder" argument"
  exit 1
fi

if [ ! -z "$folder" ]; then
  if [ ! -d "$folder" ]; then
    mkdir -p "$folder"
  fi
  cd $folder
fi

flutter create --template=package $1
cd $name && rm -rf LICENSE CHANGELOG.md README.md analysis_options.yaml pubspec.yaml .gitignore lib/$name.dart test/ linux macos windows android ios

touch lib/$name.dart
echo "library;" >lib/$name.dart

touch pubspec.yaml
echo "name: $name
description: Flutter developer coding challenge $name package.
version: 0.0.1
publish_to: \"none\"

environment:
  sdk: \">=3.4.4 <4.0.0\"
  flutter: \">=3.0.0\"

dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  flutter_lints: ^4.0.0
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true" >pubspec.yaml

dart format .
flutter pub get

if [ $? -eq 0 ]; then
  echo "Package $name created :)"
else
  echo "Error to create $name package"
fi
