#!/bin/bash
die () {
  echo ">> [$(date)] [before] Error: $@"
  exit 1
}

echo ">> [$(date)] [before] Applying patches"
for file in /root/userscripts/patches/*.patch; do 
    if [ -f "$file" ]; then 
        echo ">> [$(date)] [before] Applying $(basename $file)"
        # TODO: Better error handeling; Maybe use a git patch command?
        patch --quiet --force -p1 -i "$file" || die "Failed to apply patch $file"
    fi 
done

generate_prebuilt () {
  [ "$#" -eq 2 ] || die "Expected 2 arguments, got $#"
  local packageName="$1"
  local binaryURL="$2"
  local packagePath="packages/apps/$packageName"
  
  echo ">> [$(date)] [before] Generating prebuilt for \"$packageName\""
  rsync -ac --delete "/root/userscripts/prebuilts/$packageName/" "$packagePath" || die "Failed to copy prebuilt files for \"$packageName\""
  wget -q -O "$packagePath/$packageName.apk" "$binaryURL" || die "Failed to download binary for \"$packageName\""
}

echo ">> [$(date)] [before] Parsing urls for prebuilts"
# Map: https://stackoverflow.com/a/691157
declare -A urls

# Process urls.txt file, see https://gist.github.com/melbahja/33fac6f3f823632e880401f5f7451cfb
while read line || [[ -n $line ]]; do
  # Ignore comments
  [[ $line = \#* || -z "$line" ]] && continue
  key=${line%% *}
  value=${line#* }
  # Remove leading whitespaces, https://www.baeldung.com/linux/trim-whitespace-bash-variable#using-sed
  value=$(echo $value | sed 's/[[:blank:]]//g')
  # Set var, see https://nickjanetakis.com/blog/associative-arrays-in-bash-aka-key-value-dictionaries
  urls["${key}"]="${value}"
  echo ">> [$(date)] [before] Loaded url for \"$key\""
done < "/root/userscripts/prebuilts/urls.txt" || die "Could not read \"scripts/prebuilts/urls.txt\"!"

echo ">> [$(date)] [before] Generating prebuilts"
# Read CUSTOM_PACKAGES for a list of packages, process only those. Define these urls somewhere else
for package in $CUSTOM_PACKAGES; do
  if [[ -v urls["${package}"] ]] ; then
    generate_prebuilt $package ${urls[${package}]}
  else
    die "No URL found for package \"$package\"!"
  fi
done
