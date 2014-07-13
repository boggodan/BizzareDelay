#! /bin/sh

BASEDIR=$(dirname $0)

cd $BASEDIR

VERSION=`echo | grep PLUG_VER resource.h`
VERSION=${VERSION//\#define PLUG_VER }
VERSION=${VERSION//\'}
MAJOR_VERSION=$(($VERSION & 0xFFFF0000))
MAJOR_VERSION=$(($MAJOR_VERSION >> 16)) 
MINOR_VERSION=$(($VERSION & 0x0000FF00))
MINOR_VERSION=$(($MINOR_VERSION >> 8)) 
BUG_FIX=$(($VERSION & 0x000000FF))

FULL_VERSION=$MAJOR_VERSION"."$MINOR_VERSION"."$BUG_FIX

VST2="/Library/Audio/Plug-Ins/VST/BizzareDelay.vst"
VST3="/Library/Audio/Plug-Ins/VST3/BizzareDelay.vst3"
APP="/Applications/BizzareDelay.app"
AUDIOUNIT="/Library/Audio/Plug-Ins/Components/BizzareDelay.component"
RTAS="/Library/Application Support/Digidesign/Plug-Ins/BizzareDelay.dpm"

echo "making BizzareDelay version $FULL_VERSION mac distribution..."
echo ""

./update_version.py

#could use touch to force a rebuild
#touch blah.h

#remove existing dist folder
#if [ -d installer/dist ] 
#then
#  rm -R installer/dist
#fi

#mkdir installer/dist

#remove existing App
if [ -d $APP ] 
then
  sudo rm -R -f $APP
fi

#remove existing AU
if [ -d $AUDIOUNIT ] 
then
  sudo rm -R $AUDIOUNIT
fi

#remove existing VST2
if [ -d $VST2 ] 
then
  sudo rm -R $VST2
fi

#remove existing VST3
if [ -d $VST3 ] 
then
  rm -R $VST3
fi


#remove existing RTAS
if [ -d "${RTAS}" ] 
then
  sudo rm -R "${RTAS}"
fi

xcodebuild -project BizzareDelay.xcodeproj -xcconfig BizzareDelay.xcconfig -target "All" -configuration Release
#xcodebuild -project BizzareDelay-ios.xcodeproj -xcconfig BizzareDelay.xcconfig -target "IOSAPP" -configuration Release

#icon stuff - http://maxao.free.fr/telechargements/setfileicon.gz
echo "setting icons"
echo ""
setfileicon resources/BizzareDelay.icns $AUDIOUNIT
setfileicon resources/BizzareDelay.icns $VST2
setfileicon resources/BizzareDelay.icns $VST3
setfileicon resources/BizzareDelay.icns "${RTAS}"

#appstore stuff

# echo "code signing app"
# echo ""
# codesign -f -s "3rd Party Mac Developer Application: Oliver Larkin" $APP
#  
# echo "building pkg for app store"
# productbuild \
#      --component $APP /Applications \
#      --sign "3rd Party Mac Developer Installer: Oliver Larkin" \
#      --product "/Applications/BizzareDelay.app/Contents/Info.plist" installer/BizzareDelay.pkg

# installer, uses iceberg http://s.sudre.free.fr/Software/Iceberg.html

sudo sudo rm -R -f installer/BizzareDelay-mac.dmg

echo "building installer"
echo ""
freeze installer/BizzareDelay.packproj

# dmg, uses dmgcanvas http://www.araelium.com/dmgcanvas/

echo "building dmg"
echo ""

if [ -d installer/BizzareDelay.dmgCanvas ]
then
  dmgcanvas installer/BizzareDelay.dmgCanvas installer/BizzareDelay-mac.dmg
else
  hdiutil create installer/BizzareDelay.dmg -srcfolder installer/build-mac/ -ov -anyowners -volname BizzareDelay
  
  if [ -f installer/BizzareDelay-mac.dmg ]
  then
   rm -f installer/BizzareDelay-mac.dmg
  fi
  
  hdiutil convert installer/BizzareDelay.dmg -format UDZO -o installer/BizzareDelay-mac.dmg
  sudo sudo rm -R -f installer/BizzareDelay.dmg
fi

sudo sudo rm -R -f installer/build-mac/

# echo "copying binaries..."
# echo ""
# cp -R $AUDIOUNIT installer/dist/BizzareDelay.component
# cp -R $VST2 installer/dist/BizzareDelay.vst
# cp -R $VST3 installer/dist/BizzareDelay.vst3
# cp -R $RTAS installer/dist/BizzareDelay.dpm
# cp -R $APP installer/dist/BizzareDelay.app
# 
# echo "zipping binaries..."
# echo ""
# ditto -c -k installer/dist installer/BizzareDelay-mac.zip
# rm -R installer/dist

echo "done"