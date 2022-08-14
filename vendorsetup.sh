echo "I: - Fixing Stuff on A50 Device Trees"
### Start ###

# Magisk update
bash ../../kernel/samsung/a50/usr/magisk/update_magisk.sh
bash ../../kernel/samsung/a50-common/usr/magisk/update_magisk.sh

# Keystore patch
echo "Applying Keystore patch...";
cd system/security;
git apply ../../device/samsung/a50-common/patch/Keystore.patch;
cd - 

# Light patch 
cd frameworks/base && wget https://raw.githubusercontent.com/sarthakroy2002/random-stuff/main/Patches/Fix-brightness-slider-curve-for-some-devices-a12l.patch && patch -p1 < *.patch && cd -

# Health fix

sudo rm -r ./hardware/interfaces/health/2.1/default/android.hardware.health@2.1-service.rc
cp ./device/samsung/a50-common/patch/android.hardware.health@2.1-service.rc ./hardware/interfaces/health/2.1/default/

# BT calls fix 

cd system/bt;
git apply ../../device/samsung/a50-common/.patch/BTCalls-On-Samsung.patch;
cd -
