echo "I: - Fixing Stuff on A50 Device Trees"
### Start ###

# Magisk update
echo "I: - Fetching and applying the latest Magisk version"
bash kernel/samsung/a50/usr/magisk/update_magisk.sh
bash kernel/samsung/a50-common/usr/magisk/update_magisk.sh

# Health fix
echo "I: - Fixing Health hals"
sudo rm -r hardware/interfaces/health/2.1/default/android.hardware.health@2.1-service.rc
cp device/samsung/a50-common/patch/android.hardware.health@2.1-service.rc hardware/interfaces/health/2.1/default

# Keystore patch
echo "I: - Patching keystore"
cd system/security
git apply ../../device/samsung/a50-common/patch/Keystore.patch
cd ../..

# Light patch
echo "I: - Patching light hals"
cd frameworks/base
wget https://raw.githubusercontent.com/sarthakroy2002/random-stuff/main/Patches/Fix-brightness-slider-curve-for-some-devices-a12l.patch 
patch -p1 < *.patch
cd ../..


# BT calls fix
echo "I: - Fixing BT hals"
cd system/bt
git apply ../../device/samsung/a50-common/patch/BTCalls-On-Samsung.patch
cd ../..