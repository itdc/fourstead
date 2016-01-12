#!/usr/bin/env bash

foursteadRoot=~/.fourstead

mkdir -p "$foursteadRoot"

#cp -i src/stubs/Fourstead.yaml "$foursteadRoot/Fourstead.yaml"
#cp -i src/stubs/after.sh "$foursteadRoot/after.sh"
#cp -i src/stubs/aliases "$foursteadRoot/aliases"


cp -f src/stubs/Fourstead.yaml "$foursteadRoot/Fourstead.yaml"
cp -f src/stubs/after.sh "$foursteadRoot/after.sh"
cp -f src/stubs/aliases "$foursteadRoot/aliases"


echo "Fourstead initialized!"
