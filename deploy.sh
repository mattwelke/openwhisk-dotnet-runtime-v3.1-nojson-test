#!/bin/bash

RESOURCE_GROUP="Default"
FN_NAMESPACE="dallas-namespace"
ACTION_NAME="dotnet-runtime-3.1-nojson-test"

echo "Beginning build..."

rm -r bin 2>/dev/null
rm -r obj 2>/dev/null
rm -r out 2>/dev/null

BUILD_FILE="build.zip"

dotnet publish -c Release -o out
cd out
zip -r -0 ../$BUILD_FILE *
cd ..

echo "Build finished."

echo "Beginning deploy..."

ASSEMBLY="OpenWhiskDotnetNoJsonTest"
NAMESPACE=$ASSEMBLY
CLASS="Class1"
METHOD="Main"

# Switch to right resource group and namespace before doing deploy
ibmcloud target -r us-south
ibmcloud target -g $RESOURCE_GROUP
ibmcloud fn namespace target $FN_NAMESPACE

# Do deploy using action update (aka create or update) command
ibmcloud fn action update $ACTION_NAME $BUILD_FILE \
  --main "$ASSEMBLY::$NAMESPACE.$CLASS::$METHOD" \
  --docker "mwelke/openwhisk-runtime-dotnet-v3.1-nojson:1" \
  --web true

echo "Deploy finished."
