#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    exit 1
fi

input_dir="$1"
output_dir="$2"

declare -A file_map

while IFS= read -r -d '' file; do
    name=$(basename "$file")
    
    if [[ -e "$output_dir/$name" ]]; then
        ((file_map["$name"]++))
        new_name="${name%.*}_${file_map["$name"]}.${name##*.}"
    else
        new_name="$name"
        file_map["$name"]=1
    fi
    
    cp -p "$file" "$output_dir/$new_name"
done < <(find "$input_dir" -type f -print0)
