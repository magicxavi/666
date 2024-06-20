#!/bin/bash

MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "${MY_DIR}" ]]; then MY_DIR="${PWD}"; fi

ANDROID_ROOT="${MY_DIR}/../../.."

# Change directory to the cloned repository
cd ${ANDROID_ROOT}/hardware/qcom-caf/sm8150/display || exit

# Copy the patch file to the specified patches directory
cp ${ANDROID_ROOT}/device/xiaomi/laurel_sprout/patches/fix_raw.patch ${ANDROID_ROOT}/hardware/qcom-caf/sm8150/display/fix_raw.patch

# Apply the patch
git apply ${ANDROID_ROOT}/hardware/qcom-caf/sm8150/display/fix_raw.patch

# Check for conflicts
if [ $? -eq 0 ]; then
  echo "Patch applied successfully."
  # Commit the changes
  rm fix_raw.patch
  git add .
  git commit -m "gralloc: Fix RAW for trinket"
  git commit --amend --author="Dyneteve <dyneteve@pixelexperience.org>" --no-edit
else
  echo "Error applying the patch. Patch already applied."
fi

# Back to root directory
cd ${ANDROID_ROOT} || exit
